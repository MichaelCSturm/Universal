using System;
using System.Collections;
using System.Collections.Generic;
using Unity.XR.CoreUtils;
using UnityEngine;

public static class ClassExtension
{
    public static List<GameObject> GetAllChilds(this GameObject Go)
    {
        List<GameObject> list = new List<GameObject>();
        for (int i = 0; i < Go.transform.childCount; i++)
        {
            list.Add(Go.transform.GetChild(i).gameObject);
        }
        return list;
    }
}
public class DestructManager : MonoBehaviour
{
    public GameObject Player;
    public GameObject Hearts;
    public Animator animator;
    public GameObject Master;
   // public float speed;
    Master MainMaster;
    private int levelToLoad;
    public bool debugMode;
    private int totalBreakables;
    private bool winDisplayed = false;

    public int myLevel = 3;
    public float Timer = 30;
    public GameObject ModelTimer;
    bool running = true;
    public float waitTime = 1;
    bool quit = false;
    public int numberOfModels = 30;

    void Start()
    {
        GameObject ObjectMaster = Instantiate(Master, new Vector3(0, 0, 0), Quaternion.identity);
        MainMaster = ObjectMaster.GetComponent<Master>();
        //MainMaster = new Master();
        if (animator != null)
        {
            MainMaster.animator = animator;
            MainMaster.levelToLoad = levelToLoad;
            MainMaster.debugmode = debugMode;
        }
        totalBreakables = GameObject.FindGameObjectsWithTag("Breakable").Length;
        if (totalBreakables == 0)
        {
            Debug.LogWarning("No Breakable objects found in the scene.");
        }
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
    void Update()
    {
        Timer= Timer -= Time.deltaTime;
        if (Timer <= 0)
        {
            print("LOOSER YOURE A LOOSER ");
            MainMaster.AddToScore(-1);

            MainMaster.FailLevel(myLevel);
        }
        if (!winDisplayed)
        {
            int remaining = GameObject.FindGameObjectsWithTag("Breakable").Length;
            if (remaining == 0 && totalBreakables > 0)
            {
                winDisplayed = true;
                Debug.Log("YOU WIN");
                MainMaster.AddToScore(1);
                MainMaster.IncreaseLevel();

                MainMaster.RandomLevel(myLevel);

            }
        }
        if (running)
        {
            print("started");
            StartCoroutine(waiter());
        }

    }
    static List<Transform> GetAllChildren(Transform parent, List<Transform> transformList = null)
    {
        if (transformList == null) transformList = new List<Transform>();

        foreach (Transform child in parent)
        {
            transformList.Add(child);
            GetAllChildren(child, transformList);
        }
        return transformList;
    }

    void Changetimer()
    {
        numberOfModels = numberOfModels - 1;
        List<GameObject> childList = ModelTimer.GetAllChilds();
        foreach (GameObject child in childList)
        {
            child.SetActive(false);
            if (child.name == numberOfModels.ToString() )
            {
                child.SetActive(true);
            }
        }

       

    }
    public void OnFadeComplete() // has to be here or animator will freak out
    {
        MainMaster.OnFadeComplete();
    }
    IEnumerator waiter()
    {

        running = false;



        yield return wait(waitTime);
        Changetimer();

        running = true;
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



