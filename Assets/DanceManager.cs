using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class DanceManager : MonoBehaviour
{
    public bool debugMode;
    public Animator animator;
    public GameObject Master;
    public float speed;
    Master MainMaster;
    private int levelToLoad;
    public Animator characterAnimator;

    public string[] listOfAnimations;
    public Material strobeLight;
    bool quit = false;
    bool running = true;
    public GameObject hip;

    // Start is called before the first frame update



    ////////
    //          Speed should NOT set lower than  .3
    //
    //
    //          if done it could give someone a cesure
    ////////
    //
    int xcount = 1;
    public float timeValue = 90;
    void Start()
    {
        
        //GameObject circ = Instantiate(uiCircle, new Vector3(0, 0, 0), new Quaternion(0, 90, -90, 0));
        strobeLight.color = new Color(0f, 0f, 0f);
        GameObject ObjectMaster = Instantiate(Master, new Vector3(0, 0, 0), Quaternion.identity);
        MainMaster = ObjectMaster.GetComponent<Master>();
        //MainMaster = new Master();
        if (animator != null)
        {
            MainMaster.animator = animator;
            MainMaster.levelToLoad = levelToLoad;
            MainMaster.debugmode = debugMode;
        }
        // MainMaster.startTimer();
    }
    public void OnFadeComplete()
    {
        MainMaster.OnFadeComplete();
    }
    public void trafficLightYellow()
    {
        strobeLight.color = new Color(.75f, .75f, 0f);
    }
    public void trafficLightGreen()
    {
        strobeLight.color = new Color(0f, 1f, 0f);
    }
    public void trafficLightRed()
    {
        strobeLight.color = new Color(1f, 0f, 0f);
    }
    public void dance()
    {
        
        int xcountnew = Random.Range(0, 6);/////// _________________ This makes it so the same dance move does't happend twice in a row
        do
        {

            xcountnew = Random.Range(0, 6);

        } while (xcountnew == xcount);
        xcount = xcountnew;
        //print(xcount);
        switch (xcount)
        {
            case 0:
                characterAnimator.Play(listOfAnimations[xcount]);
                break;
            case 1:
                characterAnimator.Play(listOfAnimations[xcount]);
                break;
            case 2:
                characterAnimator.Play(listOfAnimations[xcount]);
                break;
            
            case 3:
                characterAnimator.Play(listOfAnimations[xcount]);
                break;
            case 4:
                characterAnimator.Play(listOfAnimations[xcount]);
                break;
            case 5:
                characterAnimator.Play(listOfAnimations[xcount]);
                break;
            default:
                characterAnimator.Play("Armature|movehandsTest");
                print("error");
                break;
        }
    }
    public void testDance(float time)
    {
        //GameObject ObjectMaster = Instantiate(uiCircle, new Vector3(0, 0, 0), new Quaternion(0, 180, 90, 0));
        
        //float orignalTime = time;
        //while (time > 0)
        //{

        //   float percentleft = time / orignalTime;
        //  print(percentleft);
        // uiCircle.transform.localScale = uiCircle.transform.localScale * percentleft;
        // time = time - Time.deltaTime;
        //}

    }
    // Update is called once per frame
    void Update()
    {
       // print(hip.transform.position);
        if (running)
        {
            StartCoroutine(waiter());
        }
    }
    IEnumerator waiter()
    {


        running = false;
        //Wait for waitTime amount of seconds
        float waitTime = speed;
        yield return wait(waitTime);
        trafficLightRed();
        //waitTime = 1;
        yield return wait(waitTime);
        trafficLightYellow();


        yield return wait(waitTime);
        trafficLightGreen();

        yield return wait(waitTime);
        dance();


        yield return wait(waitTime);
        testDance(waitTime);
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
