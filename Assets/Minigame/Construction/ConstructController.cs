using System;
using System.Collections;
using UnityEngine;
using Random = UnityEngine.Random;

public class ConstructController : MonoBehaviour
{
    public GameObject Player;
    public GameObject Hearts;
    public bool debugMode;
    public int points;
    public int[] difficultyWC; //win condition
    public int level; 

    public GameObject startingGuys;
    public int[] maxGuys;
    private int guys = 0;
    public float speed = 1.0f;

    public GameObject[] targets;
    public GameObject[] startLocations;

    //private Transform chosenTarget;
    public Animator animator;
    public GameObject Master;
    Master MainMaster;
    private int levelToLoad;
    public int myLevel = 5;

    public GameObject Controller;
    public float Timer = 46;
    GameObject camera;
    public Material prettyColors;
    // Start is called before the first frame update
    void Start()
    {
        
        Player = GameObject.FindGameObjectWithTag("Player");
        camera = GameObject.FindGameObjectWithTag("MainCamera");
        RenderSettings.skybox = prettyColors;
        GameObject ObjectMaster = Instantiate(Master, new Vector3(0, 0, 0), Quaternion.identity);
        MainMaster = ObjectMaster.GetComponent<Master>();
        //MainMaster = new Master();
        if (animator != null)
        {
            MainMaster.animator = animator;
            MainMaster.levelToLoad = levelToLoad;
            MainMaster.debugmode = debugMode;
        }
        StartCoroutine(SpawnGuys());
        int health = MainMaster.ReturnHealth();
        HeartController HScript = Hearts.GetComponent<HeartController>();
        if (health == 4)
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
        Console.WriteLine("Health: ", health.ToString());

    }
    public void OnFadeComplete() // The animation will freak out if this is not here.
    {
        MainMaster.OnFadeComplete();
    }
    // Update is called once per frame
    void Update()
    {
        Timer = Timer -= Time.deltaTime;
        if (Timer <= 0)
        {
            print("LOOSER YOURE A LOOSER ");
            MainMaster.AddToScore(-1);

            //MainMaster.RandomLevel(myLevel);
            MainMaster.FailLevel(myLevel);
        }
        if (points == difficultyWC[level])
        {
            //win
            print("won game");
            MainMaster.IncreaseLevel();
            MainMaster.AddToScore(1);
            MainMaster.RandomLevel(myLevel);
           
        }
    }

    IEnumerator SpawnGuys()
    {   
        while (guys <= maxGuys[level])
        {
            float randomTime = Random.Range(10f, 15f);
            int randomStart = Random.Range(0, startLocations.Length);
            GameObject newGuy = Instantiate(startingGuys, startLocations[randomStart].transform.position, startLocations[randomStart].transform.rotation);
            guys++; 

            TowardsExit te = newGuy.GetComponent<TowardsExit>();
            if (te != null)
            {
                te.constructController = Controller;
            
                te.target = targets;

                if(randomStart <= 3)
                {
                    te.TB = true;
                }
                else
                {
                    te.TB = false;
                }

            

                te.speed = speed;

                te.findTarget();
            }
            else
            {
                Debug.LogError("te (TowardsExit instance) is null!");
            }

            yield return new WaitForSeconds(randomTime);
        }

    }

    public void AddPoint()
    {
        points++;
    }
    public void killGuy()
    {
        guys--;
    }
        
}


    

