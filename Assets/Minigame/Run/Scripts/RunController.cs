using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RunController : MonoBehaviour
{
    int points;
    public int level;
    public int[] winThreshold; //made this public so we can adjust it to whatever feels most natural
    public Animator animator;
    public GameObject Master;
    public float speed;
    public Master MainMaster;
    private int levelToLoad;
    private bool once = true;
    public int myLevel = 1;
    private void Start()
    {
        GameObject ObjectMaster = Instantiate(Master, new Vector3(0, 0, 0), Quaternion.identity);
        MainMaster = ObjectMaster.GetComponent<Master>();
        //MainMaster = new Master();
        if (animator != null)
        {
            MainMaster.animator = animator;
            MainMaster.levelToLoad = levelToLoad;
        }
        points = 0;
    }
    public void OnFadeComplete() // The animation will freak out if this is not here.
    {
        MainMaster.OnFadeComplete();
    }
    private void OnTriggerEnter(Collider other)
    {

            if (other.CompareTag("Coin"))
            {
                Debug.Log("Player touched: " + gameObject.name);
                AddPoints();
                Debug.Log("coin");
            }
            if (other.CompareTag("Obstacle"))
            {
                GameOver();
                Debug.Log("Obstacle touched");
            }
    }

    private void AddPoints()
    {
        points++;
        // Guide to update the global score:
        //
        // Call MainMaster.AddToScore(1);
        //
        // Do not access the singleton itself utilize the MainMaster
        //
        MainMaster.AddToScore(1);
        if (points >= winThreshold[level] && once)
        {
            GameWin();
            once = false;
        }
    }

    private void GameOver()
    {
        
        Debug.Log("Ayo you lose");
        MainMaster.RandomLevel(myLevel);

    }
    private void GameWin()
    {
        Debug.Log("Ayo you win");
        MainMaster.IncreaseLevel();
        MainMaster.AddToScore(1);

        MainMaster.RandomLevel(myLevel);
        //MainMaster.FadeToLevel(1);
        //
        //  Here's a guide on how to swap to the next scene its pretty simple. Just call the MainManger to the scene you want to switch to
        //
        //      For example:
        //      MainMaster.FadeToLevel(1);
        //
    }
}



