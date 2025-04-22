using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RunController : MonoBehaviour
{
    int points;
    public int level;
    public int[] winThreshold; //made this public so we can adjust it to whatever feels most natural
    private void Start()
    {
        points = 0;
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



