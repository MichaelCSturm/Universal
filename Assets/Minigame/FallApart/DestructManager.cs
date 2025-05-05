using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DestructManager : MonoBehaviour
{
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
    }
    void Update()
    {
        Timer= Timer -= Time.deltaTime;
        if (Timer <= 0)
        {
            print("LOOSER YOURE A LOOSER ");
            MainMaster.AddToScore(-1);

            MainMaster.RandomLevel(myLevel);
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
    }
}
