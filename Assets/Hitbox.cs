using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class Hitbox : MonoBehaviour
{
    public GameObject HeadTrigger;
    public GameObject RightArmTrigger;
    public GameObject LeftArmTrigger;
    public GameObject RightLegTrigger;
    public GameObject LeftLegTrigger;
    public bool CheckForSpeficTrigger;
    //public GameObject SpeficTrigger;
    public List<GameObject> SpeficTriggerList;
    public GameObject Manager;
    public List<GameObject> Triggers;
    //List<GameObject> goList;

    public bool hit = false;

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
                            hit = true;
                            //DanceManager dscript = Manager.GetComponent<DanceManager>();
                            //dscript.runNextArea();
                        }
                    }
                }

            }

        }
        else
        {
            if (SpeficTriggerList.Count > 0)
            {
                foreach (GameObject Trigger in Triggers)
                {
                    if (Trigger == other.gameObject)
                    {
                        print(Trigger);

                        hit = true;
                        //DanceManager dscript = Manager.GetComponent<DanceManager>();
                        //dscript.runNextArea();

                    }
                }
            }
            //    if (SpeficTrigger != null)
            //    {
            //        if (SpeficTrigger == other.gameObject)
            //        {
            //            print(SpeficTrigger.name);
            //            if (Manager != null)
            //            {
            //                print("Yo sent it up stream");
            //            }
            //        }
            //    }
            //}

        }
    }
}
