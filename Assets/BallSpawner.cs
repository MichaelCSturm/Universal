using System.Collections;
using System.Collections.Generic;
using UnityEngine;

using static UnityEditor.FilePathAttribute;


public class BallSpawner : MonoBehaviour
{
    public float waitTime;
    bool quit = false;
    public GameObject Ball;
    public GameObject Spawner;
    // Start is called before the first frame update
    bool running = true;
    public void SpawnBall()
    {
        Vector3 Location = Spawner.transform.position;
        Instantiate(Ball, Location, Quaternion.identity);
        //print("Spawning");
    }
    void Update()
    {

        if (running)
        {
            StartCoroutine(waiter());
        }
        

    }


    IEnumerator waiter()
    {

        running = false;



        yield return wait(waitTime);
        SpawnBall();
        yield return wait(waitTime);
        running = true;
    }

    IEnumerator wait(float waitTime)
    {
        float counter = 0;

        while (counter < waitTime)
        {
            //Increment Timer until counter >= waitTime
            counter += Time.deltaTime;
            //Debug.Log("We have waited for: " + counter + " seconds");
            if (quit)
            {
                //Quit function
                yield break;
            }
            //Wait for a frame so that Unity doesn't freeze
            yield return null;
        }
    }
}
