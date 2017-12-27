/*
4. Contact Duplicate Check Trigger
Create a new Trigger on Contact that will check for duplicates before allowing a new record
into the database.
Validate against the email address and phone number fields.
An error be thrown with the error message – “A Contact with the same email address or
phone number already exists in system.”
Should be bulk safe in nature and must be capable of handling at least 200 records at a time.
*/

trigger ContactTrigger on Contact (before insert) {    
        //Validating Email Id       
        List<Contact> emailexistingList = [
          SELECT Email
            FROM Contact
        ];
        
        List<Contact> phoneexistingList=[
          SELECT Phone
            FROM Contact
        ];
    
        Set<String> myexistingEmailset = new Set<String>();
        Set<String> myexistingphoneset = new Set<String>();
    
        for (Contact copy : emailexistingList ) {
            myexistingEmailset.add(copy.Email);
        }
    
        for (Contact copy : phoneexistingList ) {
             myexistingphoneset.add(copy.Phone);
        }  
    
        for (Contact temp : Trigger.new) {
             if (temp.Email != null) {
                if (myexistingEmailset.contains(temp.Email)) {
                    temp.addError(' Record already exist with same Email ');
                }
             }

              if (Trigger.isInsert || Trigger.isUpdate) {
                  if(temp.Phone != null) {
                      if(myexistingphoneset.contains(temp.Phone)) {
                        temp.addError(' Record already exist with same Phone Number ');   
                     }                               
                 }
              }           
        }    
}