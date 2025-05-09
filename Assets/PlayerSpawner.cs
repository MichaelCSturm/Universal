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
            GameObject newPlayer = Instantiate(playerFinal, transform.position, transform.rotation);
            newPlayer.transform.localScale = transform.localScale;
        }
        else
        {
            player.transform.position = transform.position;
            player.transform.rotation = transform.rotation;
            player.transform.localScale = transform.localScale;
        }
    }

    
}
