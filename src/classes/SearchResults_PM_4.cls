public class SearchResults_PM_4 {

    public String SearchResults_PM_4 { get; set; }  
    String  searchKey {get; set;}
    Public List<account> accountList{get;set;}

	Public void searchMethod() {        
    accountList = New List<account>();        
     if (searchKey.length() > 1) {        
         String searchKey = ' * ' + searchKey + ' * ';
         String searchQuery = 
                       ' FIND ' 
                     + searchKey 
                     + ' IN Name FIELDS RETURNING  Account (Id , Name )';
      
         List<List <sObject>> searchList = search.query(searchQuery);
         accountList = ((List<Account>)searchList[0]);
         if (accountList.size() == 0) {
                ApexPages.addmessage(new apexpages.message(apexpages.severity.Error , 
                                                      'Search Key Cannot be null')
             );
             return;
          }            
      }
	}
}