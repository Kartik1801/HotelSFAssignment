global with sharing class currencyConversion {
    @future(Callout=true)
    global static void getconversionrate(List<ID> roomID){

        List<String> cList = new List<String>{'USD', 'AED', 'CAD', 'GBP'};
        Map<String, Double> cMap = new Map<String, Double> ();

        Room__C[] rs = [ SELECT Id,Cost__c, basecost__c, Hotel__r.currency__C FROM Room__C  where Id IN :roomID];
        System.debug(rs);

        String endpoint = 'https://api.apilayer.com/fixer/convert';        
        String key = 'uGRjvF447ETTYqOhgHwxArJyqiY6NAO4';    
        String method = 'GET';
        
        for(String c : cList){
            
            Http httpManager = new Http();
            HttpRequest req = new HttpRequest();
            HttpResponse res =  new HttpResponse();
            req.setMethod(method);
            req.setHeader('apikey', key);
            String body = 'From=INR'+ '&To=' + c + '&Amount=1';
            req.setEndpoint(endpoint + '?' + body);
            res = httpManager.send(req); 
            Map<String, Object> ares = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            Map<String, Object> info = (Map<String, Object>) ares.get('info');
            Decimal rate = (Decimal) info.get('rate');
            System.debug(ares);
            System.debug(info);
            System.debug(rate);
            cMap.put(c, rate);
        }
        List<Room__c> up = new List<Room__c>();
        for (Room__c r : rs){
            r.Cost__c =(Decimal) r.basecost__c * cMap.get(r.Hotel__r.Currency__c);
            up.add(r);
        }
        Database.SaveResult[] s = database.update(up);
    }
}