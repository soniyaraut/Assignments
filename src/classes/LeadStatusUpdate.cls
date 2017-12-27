public class LeadStatusUpdate{
   public void find(){      
        
        List<Lead> tempStatus = [ 
			SELECT Id
  			  FROM Lead
  		     WHERE Status LIKE ' Closed___Not % ' 
		];
        
		for(Lead l:tempStatus) {
             l.Status = ' Open - Contacted ';
            try {
                 update l;
            } catch(Exception e) {
                System.debug('Erroe :\n ' + e.getMessage());
            }
        }
        System.debug(''+tempStatus);
    }
    
    
    /*
LeadStatusUpdate lsu=new LeadStatusUpdate();
lsu.find();
*/
}