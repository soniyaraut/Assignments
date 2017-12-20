public with sharing class PM_Q5 {

    public List<string> AlphaList{get;set;}
    public list <Contact> accconList {get;set;} // stores Contact records to be displayed when clicked on the account name
    public String IdtoDelete{get;set;}
    public String searchAlphabet{get;set;}
    public Boolean valueboolean {get;set;} 
    public String searchstring {get;set;}
    public Integer countOfAccRecords{get;set;}
    public String accountIdopp  {get;set;} //account Id to get Related list records    
    public list <account> accList {get;set;} // stores opportunity records to be displayed when clicked on the account name
    public list <Opportunity> accoppList {get;set;}// stores opportunity records to be displayed when clicked on the account name
    
    public PM_Q5(ApexPages.StandardController controller) {
        AlphaList=new string[]{'A', 'B ', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' , 'All'};  
    }
     
       public void accountDisplay(){
           accList= Database.query('SELECT Name,Phone,BillingCity,BillingStreet FROM account');
                
       } 
    
    public void displayoppList(){
       accoppList = [SELECT Name FROM opportunity WHERE AccountId =:(accountIdopp)];
     //    PageReference pref = new PageReference('https://ap5.salesforce.com/MyAccountRecords/'+accountIdopp); 
       accconList = [SELECT Name FROM Contact WHERE AccountId =:(accountIdopp)];
    valueboolean = true;
        
    }
   
   
   
   //displaying rror if length of string less than 3  and also displaying the search results
   public void accountsearch(){
        System.debug(searchstring.length());
       if(searchstring.length()<3){
        
         ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter atleast 3 characters'));
         
       }else{
           System.debug(searchstring.length());
            accList= Database.query('select Name,Phone,BillingCity,BillingStreet from account where name like \'%'+searchstring+'%\' Limit 5');
            String temporary; 
            temporary='%'+searchstring+'%';
            countOfAccRecords=[select count()
                               FROM Account 
                               WHERE Name LIKE : temporary
        ];
        
       }
     
    }
 
  
  public void accountsearchwithAlphabet(){
        System.debug(searchAlphabet.length());
      
           System.debug(searchAlphabet.length());
            accList= Database.query('select Name,Phone,BillingCity,BillingStreet from account where name like \''+searchAlphabet+'%\' Limit 5');
            String temporary; 
            temporary='%'+searchAlphabet+'%';
            countOfAccRecords=[select count()
                               FROM Account 
                               WHERE Name LIKE : temporary
        ];
        
       
     
    }
    
  @RemoteAction
  public static String deleteContactRecord(String contName){
  List<contact> contactlisttobedeleted = new List<Contact>();
      contactlisttobedeleted = [SELECT Name FROM Contact WHERE AccountId =:(contName)];   
        if(contactlisttobedeleted .size()!=null) {
                  delete contactlisttobedeleted ; 
                  
                  
        }
        return null;
 }
  
  
  
  
    public void clear(){     
        accList.clear(); 
    } 
}