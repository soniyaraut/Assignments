trigger CampaignRSVP on Campaign (before insert) {    
    List<Campaign> campaignlist = new List<Campaign>([
            SELECT Id
                 , Lead__r.RSVP__c 
                 , Status
                 , Type1__c
              FROM Campaign
    ]);  

    System.debug('Execute this : ' + campaignlist);
    
    for (Campaign c : Trigger.New) {        
        if (c.Type1__c.equals('Lead') && c.rsvp_1__c == null) {
               
           for (Campaign clead : campaignlist ) { 
               if (clead.Lead__r.RSVP__c != null) {
                   System.debug('' + clead.Lead__r.RSVP__c);
                   c.rsvp_1__c = clead.Lead__r.RSVP__c;
               }
           }
        }
    }
  }