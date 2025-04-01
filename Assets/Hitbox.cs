using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Hitbox : MonoBehaviour
{
    public GameObject HeadTrigger;
    public GameObject RightArmTrigger;
    public GameObject LeftArmTrigger;
    public GameObject RightLegTrigger;
    public GameObject LeftLegTrigger;
    public bool CheckForSpeficTrigger;
    public GameObject SpeficTrigger;
    public GameObject Manager;
    List<GameObject> Triggers;
    //List<GameObject> goList;
    void Start()
    {
        Triggers = new List<GameObject>();
        Triggers.Add(HeadTrigger);
        Triggers.Add(RightArmTrigger);
        Triggers.Add(LeftArmTrigger);
        Triggers.Add(RightLegTrigger);
        Triggers.Add(LeftLegTrigger);
        //foreach (GameObject Trigger in Triggers)
        //{ 
        //    print(Trigger);
        //}
    }
    void OnTriggerEnter(Collider other)
    {
       
        if (CheckForSpeficTrigger == false)
        {
            if (Triggers != null)
            {
                foreach (GameObject Trigger in Triggers)
                {
                    if (Trigger == other.gameObject)
                    {
                        print(Trigger);
                        if (Manager != null)
                        {
                            DanceManager dscript = Manager.GetComponent<DanceManager>();
                            dscript.FadeToLevel(0);
                        }
                    }
                }
                    
            }
           
        }
        else
        {
            if (SpeficTrigger != null)
            {
                if (SpeficTrigger == other.gameObject)
                {
                    print(SpeficTrigger.name);
                    if (Manager != null)
                    {
                        print("Yo sent it up stream");
                    }
                }
            }
        }
        
    }
}
