using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[System.Serializable]  
public class Connect
{
    public GameObject controller;
    public GameObject bar;
    public float offset;
}

public class heightCon : MonoBehaviour
{
    public Connect[] TrackerConnections;
    
    void Start()
    {
        foreach (var tracker in TrackerConnections)
        {
            tracker.offset = tracker.bar.transform.position.y - tracker.controller.transform.position.y;
      
        }
        
    }
    void Update()
    {
        foreach (var tracker in TrackerConnections)
        {
            if (tracker.controller != null && tracker.bar != null)
            {
                Vector3 OZ = tracker.bar.transform.rotation.eulerAngles;
                OZ.z = tracker.controller.transform.rotation.eulerAngles.z;
                tracker.bar.transform.rotation = Quaternion.Euler(OZ);

                tracker.bar.transform.position = new Vector3(
                    tracker.bar.transform.position.x,
                    (tracker.controller.transform.position.y * 25) + tracker.offset,
                    tracker.bar.transform.position.z);
                
            }
        }
    }
}