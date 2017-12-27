      /*
          5.Address Did Not Verify – AVS:
             1.Create SalesHeader__c object :(Having lookup to Account & Contact ) & Add necessary fields.
             2.Create EFT_Transaction_Status__c object with the necessary fields and add look up to
            SalesHeader__c
             3. Create assignment record type on Case
             4. On Insert of a EFT_Transaction_Status__c, if
            EFT_Transaction_Status__c.Method_Name__c = “Credit Card Address Verify”
            EFT_Transaction_Status__c.Transaction_Status__c= “Declined”
            SalesHeader__c.Status__c = “Open”

            Create a Case with this mapping:

            Case Field Value
            Account SalesHeader__c.Bill_to_Customer__c
            Contact SalesHeader__c.Bill_to_Customer__c
            Record Type Assignment
            Origin "Internal"
            Owner AVS Queue
            Reason Address Did Not Verify
            Priority High
            Status New
            Subject Account.Name + " " + Case.Type
            Type Address Did Not Verify
            Open_Sales_Order__c SalesHeader__c.Id
            Transaction_Status__c EFT_Transaction_Status__c.Transaction_Status__c
            Sales_Order_Number__c SalesHeader__c.Name
            Order_Date__c EFT_Transaction_Status__c.Transaction_Date__c
      */

      trigger CreateCase on EFT_Transaction_Status__c (after insert) {

      //Below trigger is for Trigger Assignment set 1 5th question
      final Integer i = 0;
      Case cases;
      List<EFT_Transaction_Status__c> myeft = Trigger.new;    
      List<EFT_Transaction_Status__c> lsteft = new List<EFT_Transaction_Status__c>();
      
      lsteft = [
        SELECT SalesHeader__r.Status__c
             , SalesHeader__r.Bill_to_Customer__c
             , SalesHeader__r.Contact_Name__c
             , SalesHeader__r.Name
             , Method_Name__c
             , Transaction_Status__c
             , Transaction_Date__c
          FROM EFT_Transaction_Status__c 
         WHERE ID in : myeft
      ];

      Account a = new Account();
      Contact c = new Contact();
      RecordType rt = [
          SELECT Id
            FROM RecordType
           WHERE Name = ' Assignment ' AND SObjectType = ' Case '
      ];
         
      for (EFT_Transaction_Status__c eee : lsteft) {
        if (eee.Method_Name__c == ' Credit Card Address Verify ' &&
            eee.Transaction_Status__c == ' Declined ' &&
            eee.SalesHeader__r.Status__c == ' Open ') {            
               a.id = eee.SalesHeader__r.Bill_to_Customer__c;
               c.id = eee.SalesHeader__r.Contact_Name__c;
              
               cases = new Case(
                              Account = a
                            , Contact = c
                            , RecordType = rt
                            , Origin = 'Internal'
                            , Reason = 'Address did not verify'
                            , Priority = 'High'
                            , Status = 'New'
                            , Type = 'Address did not verify'
                            , Open_sales_order__c = eee.SalesHeader__r.Id
                            , Transaction_Status__c = eee.Transaction_Status__c
                            , Sales_Order_Number__c = eee.SalesHeader__r.Name
                            , Date__c = eee.Transaction_Date__c
               );   
        }
      }

      try {
          insert cases;
          System.debug('' + Cases.Id);
          System.debug(' Account : ' + a.id + '\n Status : ' + cases.Status 
                                     + ' Priority : ' + cases.Priority
          );
        
        update cases;
      } catch (DmlException E) {
        System.debug('' + e .getMessage());
      }

      System.debug('Exceuted');

 }