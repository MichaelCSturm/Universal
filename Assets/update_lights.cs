using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class update_lights : MonoBehaviour
{
    public GameObject[] lights1;
    public GameObject[] lights2;
    public GameObject[] lights3;
    public Material Yellow1;
    public Material Yellow2;
    public Material Yellow3;
    bool running = true;
    public float speed;
    bool quit = false;

    void Start()
    {
        Yellow1.EnableKeyword("_EMISSION");
        Yellow2.EnableKeyword("_EMISSION");
        Yellow3.EnableKeyword("_EMISSION");
    }
    void First()
    {
        //foreach (GameObject light in lights1){
        //    float emissiveIntensity = 10;
        //    Color emissiveColor = Color.black;
        //    light.GetComponent<Renderer>().material.SetColor("_EmissiveColor", emissiveColor * emissiveIntensity);
        //}
        //Yellow1.SetColor("_EmissionColor", new Color(0f, 0f, 0f, 0f));// new Color(1f, 1f, 1f);
        Yellow1.color = new Color(1f, 1f, 1f);
        Yellow2.color = new Color(0f, 0f, 0f);
        Yellow3.color = new Color(0f, 0f, 0f);

    }
    void Second() 
    {
        Yellow1.color = new Color(0f, 0f, 0f);
        Yellow2.color = new Color(1f, 1f, 1f);
        Yellow3.color = new Color(0f, 0f, 0f);
    }
    void Third() 
    {
        Yellow1.color = new Color(0f, 0f, 0f);
        Yellow2.color = new Color(0f, 0f, 0f);
        Yellow3.color = new Color(1f, 1f, 1f);
    }
    // Update is called once per frame
    void Update()
    {
        if (running)
        {
            StartCoroutine(waiter());
        }
    }
    IEnumerator waiter()
    {

        print("asdsa");
        running = false;
        //Wait for waitTime amount of seconds
        float waitTime = speed;
        yield return wait(waitTime);
        First();
        //waitTime = 1;
        yield return wait(waitTime);
        Second();


        yield return wait(waitTime);
        Third();

        //yield return wait(waitTime);
        //dance();


        //yield return wait(waitTime);
        //testDance(waitTime);
       // yield return wait(waitTime);
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
