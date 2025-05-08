using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Random = UnityEngine.Random;
//using static UnityEditor.FilePathAttribute;

public class BeatSaberManager : MonoBehaviour
{
    public GameObject Hearts;
    public float waitTime;
    public bool debugMode;
    public GameObject RightHandSpawnPoint;
    public GameObject LeftHandSpawnPoint;
    public GameObject RightLegSpawnPoint;
    public GameObject LeftLegSpawnPoint;
    public GameObject GeneralSpawnPoint;
    public GameObject HeadTrigger;
    public GameObject RightArmTrigger;
    public GameObject LeftArmTrigger;
    public GameObject RightLegTrigger;
    public GameObject LeftLegTrigger;
    public GameObject Hitbox;
    public GameObject FeetHitbox;
    public GameObject HandHitbox;

    public int myLevel;

    public Animator animator;
    public GameObject Master;
    public float speed;
    Master MainMaster;
    private int levelToLoad;
    public GameObject Player;

    //public float[] values;

    public List<GameObject> hitboxes;
    //public List<noOfGameObjects> objects = new List<noOfGameObjects>();
    // Start is called before the first frame update
    bool quit = false;
    public int LimitOfBoxes = 1;
    public float timeValue = 15;
    public int GoodScore = 0;
    public int BadScore = 0;

    int getRandomNumber(int num1, int num2)
    {
        int xcount = Random.Range(num1, num2);
        return xcount;
    }
    void randomBox(GameObject whichbox, Vector3 Location)
    {
        GameObject thisbox;
        int chosenbox = getRandomNumber(1, 10);
        if (chosenbox > 8) // 80% chance to create a box ment for that spot
        {
           chosenbox = getRandomNumber(1, 10);
            thisbox = Instantiate(Hitbox, Location, Quaternion.identity);
            hitboxes.Add(thisbox);
            thisbox.GetComponent<BeatSaberHitbox>().HeadTrigger = HeadTrigger;
            thisbox.GetComponent<BeatSaberHitbox>().RightArmTrigger = RightArmTrigger;
            thisbox.GetComponent<BeatSaberHitbox>().LeftArmTrigger = LeftArmTrigger;
            thisbox.GetComponent<BeatSaberHitbox>().RightLegTrigger = RightLegTrigger;
            thisbox.GetComponent<BeatSaberHitbox>().LeftLegTrigger = LeftLegTrigger;
            thisbox.GetComponent<BeatSaberHitbox>().Manager = Master;
        }
        else
        {
            thisbox = Instantiate(whichbox, Location, Quaternion.identity);
            hitboxes.Add(thisbox);
            thisbox.GetComponent<BeatSaberHitbox>().HeadTrigger = HeadTrigger;
            thisbox.GetComponent<BeatSaberHitbox>().RightArmTrigger = RightArmTrigger;
            thisbox.GetComponent<BeatSaberHitbox>().LeftArmTrigger = LeftArmTrigger;
            thisbox.GetComponent<BeatSaberHitbox>().RightLegTrigger = RightLegTrigger;
            thisbox.GetComponent<BeatSaberHitbox>().LeftLegTrigger = LeftLegTrigger;
            thisbox.GetComponent<BeatSaberHitbox>().Manager = Master;
            thisbox.GetComponent<BeatSaberHitbox>().SpeficTriggerList.Add(RightArmTrigger);
            thisbox.GetComponent<BeatSaberHitbox>().SpeficTriggerList.Add(LeftArmTrigger);
        }
    }
    void CreateHitBox()
    {
        Vector3 Location = new Vector3(0, 0, 0);
        int xcount = getRandomNumber(1, 5);
        switch(xcount)
        {
            case 1:
                Location = RightHandSpawnPoint.transform.position;
                break;
            case 2:
                Location = LeftHandSpawnPoint.transform.position;
                break;
            case 3:
                Location = RightLegSpawnPoint.transform.position;
                break;
            case 4:
                Location = LeftLegSpawnPoint.transform.position;
                break;
            case 5:
                Location = GeneralSpawnPoint.transform.position;
                break;
            default:
                break;
        }

        

        
        switch (xcount)
        {
            case 1:

                randomBox(HandHitbox, Location);
                break;
                
            case 2:
                randomBox(HandHitbox, Location);
                break;

                
            case 3:
                randomBox(FeetHitbox, Location);
                break;
            case 4:
                randomBox(FeetHitbox, Location);

                break;
            case 5:
                GameObject thisbox;
                thisbox = Instantiate(Hitbox, Location, Quaternion.identity);
                hitboxes.Add(thisbox);
                thisbox.GetComponent<BeatSaberHitbox>().HeadTrigger = HeadTrigger;
                thisbox.GetComponent<BeatSaberHitbox>().RightArmTrigger = RightArmTrigger;
                thisbox.GetComponent<BeatSaberHitbox>().LeftArmTrigger = LeftArmTrigger;
                thisbox.GetComponent<BeatSaberHitbox>().RightLegTrigger = RightLegTrigger;
                thisbox.GetComponent<BeatSaberHitbox>().LeftLegTrigger = LeftLegTrigger;
                thisbox.GetComponent<BeatSaberHitbox>().Manager = Master;
                break;
            default:
                break;
        }
        
        //scriptbox = thisbox.GameObject.GetComponent<BeatSaberHitbox>();
        
        
        //    public GameObject HeadTrigger;
        //public GameObject RightArmTrigger;
        //public GameObject LeftArmTrigger;
        //public GameObject RightLegTrigger;
        //public GameObject LeftLegTrigger;
    }
    void Start()
    {
        GameObject ObjectMaster = Instantiate(Master, new Vector3(0,0,0), Quaternion.identity);
        MainMaster = ObjectMaster.GetComponent<Master>();
        //MainMaster = new Master();
        if (animator != null)
        {
            MainMaster.animator = animator;
            MainMaster.levelToLoad = levelToLoad;
            MainMaster.debugmode = debugMode;
        }
        // MainMaster.startTimer();
        CreateHitBox();
        //
        int health = MainMaster.ReturnHealth();
        HeartController HScript = Hearts.GetComponent<HeartController>();
        if (health ==4)
        {
            HScript.FourLife();
        }
        if (health == 3)
        {
            HScript.ThreeLife();
        }
        if (health == 2)
        {
            HScript.TwoLife();
        }
        if (health == 1)
        {
            HScript.OneLife();
        }
        MainMaster.Player = Player;
        Console.WriteLine("Health: ",health.ToString());

    }
    public void OnFadeComplete()
    {
        MainMaster.OnFadeComplete();
    }
    public void Update()
    {
        //var ignoreme = MainMaster.TimeManager().ToString();
        if (hitboxes.Count != 0)
        {
            foreach (GameObject box in hitboxes)
            {
                box.transform.position = new Vector3(box.transform.position.x, box.transform.position.y, box.transform.position.z + speed);
            }
            if (hitboxes[0].transform.position.z > 4 && LimitOfBoxes >hitboxes.Count)
            {
                StartCoroutine(waiterr());
                //triggerOnce = false;
                
            }
            if (hitboxes[0].transform.position.z > 30)
            {
                if (hitboxes[0].GetComponent<BeatSaberHitbox>().hit == true)
                {
                    GoodScore = GoodScore + 1;
                }
                else
                {
                    BadScore = BadScore + 1;
                }
                if(BadScore >= 2)
                {
                    print("YO WE LOST");
                    print(MainMaster.TimeManager().ToString());
                    MainMaster.AddToScore(-1);
                    MainMaster.FailLevel(myLevel);
                }
                if (GoodScore >= 2)
                {
                    print("WINNINNNG");
                    MainMaster.AddToScore(1);
                    print(MainMaster.ReturnScore().ToString());
                    print(MainMaster.TimeManager().ToString());
                    //MainMaster.FadeToLevel(1);

                    MainMaster.AddToScore(1);
                    //MainMaster.IncreaseLevel();

                    MainMaster.RandomLevel(myLevel);
                }
                Destroy(hitboxes[0]);
                hitboxes.RemoveAt(0);
                //triggerOnce = true;
            }
        }

    }

    IEnumerator waiterr()
    {
      
        

        //Wait for waitTime amount of seconds
       
        CreateHitBox();
        
        //waitTime = 1;
        yield return waitt(waitTime);

        
    }

    IEnumerator waitt(float waitTime)
    {
        float counter = 0;

        while (counter < waitTime)
        {
            //Increment Timer until counter >= waitTime
            counter += Time.deltaTime;
            //Debug.Log("We have waited for: " + counter + " seconds");
            if (quit)
            {
                //Quit function
                yield break;
            }
            //Wait for a frame so that Unity doesn't freeze
            yield return null;
        }
    }
}
