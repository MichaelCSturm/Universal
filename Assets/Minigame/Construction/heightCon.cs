using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[System.Serializable]  
public class Connect
{
    public GameObject controller;
    public GameObject bar;
    public float offset;
    public int aol;
}



public class heightCon : MonoBehaviour
{
    public Connect[] TrackerConnections;

    public float[] aolOff;

    void Start()
    {
        TrackerConnections[0].controller = GameObject.FindGameObjectWithTag("Left Leg VR Target");
        TrackerConnections[1].controller = GameObject.FindGameObjectWithTag("Right Leg VR Target");
        TrackerConnections[2].controller = GameObject.FindGameObjectWithTag("Right Hand VR Target");
        TrackerConnections[2].controller = GameObject.FindGameObjectWithTag("Left Hand VR Target");
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
                //Vector3 OZ = tracker.bar.transform.rotation.eulerAngles;
                //OZ.z = tracker.controller.transform.rotation.eulerAngles.z;
                //tracker.bar.transform.rotation = Quaternion.Euler(OZ);

                tracker.bar.transform.position = new Vector3(
                    tracker.bar.transform.position.x,
                    (tracker.controller.transform.position.y * aolOff[tracker.aol]) + tracker.offset,
                    tracker.bar.transform.position.z);
                
            }
        }
    }
}