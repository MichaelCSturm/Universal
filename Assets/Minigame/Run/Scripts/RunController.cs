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
    Master MainMaster;
    private int levelToLoad;
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
        if (gameObject.CompareTag("Coin"))
        {
            if (other.gameObject.CompareTag("Player"))
            {
                Debug.Log("Player touched: " + gameObject.name);
                AddPoints();
                Debug.Log("coin");
            }
        }

        if (gameObject.CompareTag("Obstacle"))
        {
            if (other.gameObject.CompareTag("Player"))
            {
                GameOver();
                Debug.Log("Obstacle touched");
            }

        }
    }

    private void AddPoints()
    {
        points++;

        if(points >= winThreshold[level])
        {
            GameWin();
        }
    }

    private void GameOver()
    {
        Debug.Log("Ayo you lose");
    }
    private void GameWin()
    {
        Debug.Log("Ayo you win");
    }
}



