using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class playerHealth : MonoBehaviour
{
    // Start is called before the first frame update
    public EnemySpawner spawningScript;
    public int health = 1;
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void OnTriggerEnter(Collider other)
    {
        Debug.Log("hit");
        // Check if the object we collided with has the "enemy" tag
        if (other.gameObject.CompareTag("enemy"))
        {
            health--;  // Decrease health when colliding with an "enemy"
            Debug.Log("Health: " + health);

            if (health <= 0)
            {
                // Call the game over method
                Debug.Log("lose lol");
                spawningScript.GameOver();
            }
        }
    }
}
