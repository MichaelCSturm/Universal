using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ConstructController : MonoBehaviour
{
    public int points;
    public int[] difficultyWC; //win condition
    public int level; 
    public GameObject[] startingGuys;
    public int[] maxGuys;
    private int guys = 0;
    public float speed = 1.0f;

    public GameObject[] targets;

    private Transform chosenTarget;
    // Start is called before the first frame update
    void Start()
    {
        StartCoroutine(SpawnGuys());
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    IEnumerator SpawnGuys()
    {   
        while (guys <= maxGuys[level])
        {
            int randomGuy = Random.Range(0, startingGuys.Length);
            float randomTime = Random.Range(10f, 15f); 

            GameObject newGuy = Instantiate(startingGuys[randomGuy]);
            guys++; 

            TowardsExit te = newGuy.GetComponent<TowardsExit>();
        if (te != null)
        {
            te.target = targets; 
            te.findTarget();
        }

        yield return new WaitForSeconds(randomTime);
        }

    }
}

    

