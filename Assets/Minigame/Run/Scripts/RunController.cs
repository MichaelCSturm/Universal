using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RunController : MonoBehaviour
{
    private void OnCollisionEnter(Collision other)
    {
        
        if (other.gameObject.CompareTag("Player"))
        {
            Debug.Log("Player touched: " + gameObject.name);

            
            if (CompareTag("Coin"))
            {
                Debug.Log("coin");
            }
            else if (CompareTag("Obstacle"))
            {
                Debug.Log("Obstacle touched");
            }
        
        }
    }
}



