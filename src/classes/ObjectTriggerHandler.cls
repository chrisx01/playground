public with sharing class ObjectTriggerHandler {

    private boolean m_isExecuting = false;

    public ObjectTriggerHandler(boolean isExecuting){
        m_isExecuting = isExecuting;
    }

    public void OnBeforeInsert(Object[] newObjects){
        // EXECUTE BEFORE INSERT LOGIC
    }

    public void OnAfterInsert(Object[] newObjects){
        // EXECUTE AFTER INSERT LOGIC
    }

    public void OnBeforeUpdate(Object[] oldObjects, Object[] updatedObjects, Object[] MapObjectMap ) {
        // BEFORE UPDATE LOGIC
    }

    public void OnAfterUpdate(Object[] oldObjects, Object[] updatedObjects, Object[] MapObjectMap){
        // AFTER UPDATE LOGIC
    }

    public void OnBeforeDelete(Object[] ObjectsToDelete,Object[]  MapObjectMap){
        // BEFORE DELETE LOGIC
    }

    public void OnAfterDelete(Object[] deletedObjects, Object[] MapObjectMap){
        // AFTER DELETE LOGIC
    }

    public void OnUndelete(Object[] restoredObjects){
        // AFTER UNDELETE LOGIC
    }

    public boolean IsTriggerContext{
        get{ return m_isExecuting;}
    }
}