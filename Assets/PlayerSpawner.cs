using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerSpawner : MonoBehaviour
{
    public GameObject playerFinal;
    GameObject player;
    // Start is called before the first frame update
    void Awake()
    {
        player = GameObject.FindGameObjectWithTag("Player");
        if (player == null)
        {
            Instantiate(playerFinal, transform.position, transform.rotation);
        }
        else
        {
            player.transform.position = transform.position;
            player.transform.rotation = transform.rotation;
        }
    }

    
}
