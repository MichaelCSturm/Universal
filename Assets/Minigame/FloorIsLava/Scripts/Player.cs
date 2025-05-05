using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Player : MonoBehaviour
{
    public GameController gameControllerScript;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Lava"))
        {
            Debug.Log("Hit Lava");
            gameControllerScript.GameOver();
        }
        if (other.CompareTag("Safezone"))
        {
            Debug.Log("In safezone");
            gameControllerScript.AddPoints();
        }
    }
}
