/*
Use Case – we would like to use the email address of the incoming case to see if we can associate 
the correct person account to populate the Account and Contact Fields.
When a new case is created and the Case.Origin field is set to “Chat” or “Email” or “Web” take the
Case.SuppliedEmail field and look up to find a match in the following account fields –
Account.PersonEmail, Account.Email_Address__

*/

trigger WebEmailChatter on Case (before insert) {
    
    List<Case> caseList=Trigger.new;
    List<Contact> contactemails= new  List<Contact>([
       SELECT Email 
       	FROM Contact
   ]);
   Set<Contact> mycontactemailset=new Set<Contact>(contactemails);
   Map<String,Contact> contactemailmap = new  Map<String,Contact>();
    
   for(Contact contactitr : mycontactemailset){
        contactemailmap.put(contactitr.Email, contactitr);
    }

    for(Case caseitr : Trigger.new){
        if ( caseitr.Origin == ' Web ' 
          || caseitr.Origin == ' Phone ' 
          || caseitr.Origin == ' Email '
          || caseitr.Origin == ' Chat'
        ) {
          if (contactemailmap.containsKey(caseitr.Email__c)) {
                    caseitr.ContactId=contactemailmap.get(caseitr.Email__C).id;                
            }
    }
}