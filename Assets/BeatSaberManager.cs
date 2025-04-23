using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using static UnityEditor.FilePathAttribute;

public class BeatSaberManager : MonoBehaviour
{
    public GameObject SpawnPoint1;
    public GameObject SpawnPoint2;
    public GameObject SpawnPoint3;
    public GameObject HeadTrigger;
    public GameObject RightArmTrigger;
    public GameObject LeftArmTrigger;
    public GameObject RightLegTrigger;
    public GameObject LeftLegTrigger;
    public GameObject Hitbox;
    public Animator animator;
    public GameObject Master;
    public float speed;
    Master MainMaster;
    private int levelToLoad;

    //public float[] values;

    public List<GameObject> hitboxes;
    //public List<noOfGameObjects> objects = new List<noOfGameObjects>();
    // Start is called before the first frame update
    bool quit = false;
    public int LimitOfBoxes = 1;
    public float timeValue = 15;
    public int GoodScore = 0;
    public int BadScore = 0;
    void CreateHitBox()
    {
        Vector3 Location = new Vector3(0, 0, 0);
        int xcount = Random.Range(1, 3);
        switch(xcount)
        {
            case 1:
                Location = SpawnPoint1.transform.position;
                break;
            case 2:
                Location = SpawnPoint2.transform.position;
                break;
            case 3:
                Location = SpawnPoint3.transform.position;
                break;
            default:
                break;
        }


        GameObject thisbox = Instantiate(Hitbox, Location, Quaternion.identity);
        //scriptbox = thisbox.GameObject.GetComponent<BeatSaberHitbox>();
        hitboxes.Add(thisbox);
        thisbox.GetComponent<BeatSaberHitbox>().HeadTrigger = HeadTrigger;
        thisbox.GetComponent<BeatSaberHitbox>().RightArmTrigger = RightArmTrigger;
        thisbox.GetComponent<BeatSaberHitbox>().LeftArmTrigger = LeftArmTrigger;
        thisbox.GetComponent<BeatSaberHitbox>().RightLegTrigger = RightLegTrigger;
        thisbox.GetComponent<BeatSaberHitbox>().LeftLegTrigger = LeftLegTrigger;
        thisbox.GetComponent<BeatSaberHitbox>().Manager = Master;
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
        }
        // MainMaster.startTimer();
        CreateHitBox();
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
                StartCoroutine(waiter());
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
                }
                if (GoodScore >= 2)
                {
                    print("WINNINNNG");
                    MainMaster.AddToScore(1);
                    print(MainMaster.ReturnScore().ToString());
                    print(MainMaster.TimeManager().ToString());
                    MainMaster.FadeToLevel(1);
                }
                Destroy(hitboxes[0]);
                hitboxes.RemoveAt(0);
                //triggerOnce = true;
            }
        }

    }

    IEnumerator waiter()
    {
      
        

        //Wait for waitTime amount of seconds
        float waitTime = 1;
        CreateHitBox();
        
        waitTime = 1;
        yield return wait(waitTime);

        
    }

    IEnumerator wait(float waitTime)
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
