/*
  4. Campaign member Trigger
  Whenever a Campaign member of type lead is inserted, check the RSVP field on campaign
  member, if it is blank and if the Lead RSVP field has value we would need to update that value
  on the Campaign member RSVP field.
  5.Unable to Cross Ship
   1.Create SalesHeader__c object :(Having lookup to Account & Contact ) & Add necessary fields.
   2. Create assignment record type on Case

  On Insert or update of a SalesHeader__c, if
  SalesHeader__c.Status__c = “Open”
  SalesHeader__c.Pick_Status__c = “Open”
  SalesHeader__c.Total_Amount__c > 300
  \\ Evaluate Bill to and Ship to fields to see if they match, if there is any difference, 
  create a case
  IF (SalesHeader__c.Bill_to_Street__c <> SalesHeader__c.Ship_to_Street__c, OR
  SalesHeader__c.Bill_to_City__c <> SalesHeader__c.Ship_to_City__c; OR
  SalesHeader__c.Bill_to_Postal_Code__c <> SalesHeader__c.Ship_to_Postal_Code__c; OR
  SalesHeader__c.Bill_to_State__c <> SalesHeader__c.Ship_to_State__c )
  Then create a case with the following mappings

  Case Field Value

  Account SalesHeader__c.Bill_to_Customer__c
  Contact SalesHeader__c.Bill_to_Customer__c
  Record Type Assignmen
  Origin "Internal"
  Owner Unable to Cross Ship Queue
  Reason Unable to Cross Ship
  Priority Medium
  Status New
  Subject Account.Name + " " + Case.Type
  Type Unable to Cross Ship
  Open_Sales_Order__c SalesHeader__c.Id
  Transaction_Status__c EFT_Transaction_Status__c.Transaction_Status__
  c
  Sales_Order_Number__c SalesHeader__c.Name
  Order_Date__c EFT_Transaction_Status__c.Transaction_Date__c

*/

trigger CreateCaseAssignment3 on Salesheader_Third__c (after insert) {

    Case cases;
    List<Salesheader_Third__c> mysaleslst=Trigger.new;
    Account a=new Account();
    Contact c=new Contact();
    Database.DMLOptions dmo = new Database.DMLOptions();

    for(Salesheader_Third__c s: mysaleslst){
      if( s.Status__c == 'Open' && s.Pick_Status__c == 'Open' && s.Amount__c > 300){
          if(   s.Billing_Street__c <> s.Shipping_Street__c 
             || s.Billing_City__c <> s.Shipping_City__c
             || s.Billing_Postal_Code__c <> s.Shipping_Postal_Code__c
             || s.Billing_State__c <> s.Shipping_State__c ) {
              //Inside Inner if

                dmo.assignmentRuleHeader.useDefaultRule = true;
                a.id=S.Account_Name__c;
                c.id=S.Contact_Name__c;

                RecordType rt = [
                      SELECT Id
                        FROM RecordType
                        WHERE Name = 'Assignment' AND SObjectType = 'Case'
                ];    

                cases = new Case(
                  Account = a
                , Contact = c
                , RecordType = rt
                , Origin = 'Internal'
                , Reason = 'Unable to Cross Ship Queue'
                , Priority = 'Medium'
                , Status = 'New'
                , Type = 'Unable to Cross Ship Queue'
                , Subject =S.Account_Name__c + ' ' + Case.Type  
           );        
          }//end inner if
        }// end outer if
    }// end for loop
    
    try {
        insert cases;
    } Catch (DmlException e) {
        System.debug('' + e.getMessage());
    }
    
    
}