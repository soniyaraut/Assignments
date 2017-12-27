public with sharing class accsearchcontroller { 


    public list <account> acc {get;set;} 
    public list <contact> contobj {get; set;}
    public list <Opportunity> oppobj {get; set;}
    public list <Lead> leadobj {get; set;}    
    public string searchstring {get;set;} 
    
    
    public accsearchcontroller( ) {  } 
     
    public void accountsearch() {   
        acc= Database.query('SELECT Name, Id FROM account where name like \'%'  +  searchstring  +  '%\' Limit 5');         
      
        contobj = Database.query('SELECT FirstName, LastName FROM Contact WHERE FirstName LIKE \'%' + searchstring + '%\'  OR LastName LIKE  \'%' + searchstring + '%\'LIMIT 5' );

		oppobj = Database.query('SELECT Name FROM Opportunity WHERE Name  LIKE \'%' + searchstring + '%\' LIMIT 5' );        
       
  		 leadobj = Database.query('SELECT Name FROM Lead WHERE Name  LIKE \'%' + searchstring + '%\' LIMIT 5' );        
    } 
    
    public void clear(){ 
    
    acc.clear(); 
    } 
}