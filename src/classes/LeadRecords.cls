public class LeadRecords 
{
	public void print()
    {
        List<Lead> recordId=[select id from Lead];
         Set<Lead> ids = new Set<Lead>(recordId);
        	LeadRecords lr=new LeadRecords();
			lr.print();
        for(Lead l:ids)
        {
            System.debug(''+l);
        }
    }
}

/*
LeadRecords lr=new LeadRecords();
lr.print();
*/