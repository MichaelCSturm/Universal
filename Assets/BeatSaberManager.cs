using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BeatSaberManager : MonoBehaviour
{
    public GameObject SpawnPoint1;
    public GameObject SpawnPoint2;
    public GameObject SpawnPoint3;
    public GameObject Hitbox;
    public Animator animator;
    public float speed;
    Master MainMaster;
    private int levelToLoad;

    public float[] values;

    public List<GameObject> hitboxes;
    //public List<noOfGameObjects> objects = new List<noOfGameObjects>();
    // Start is called before the first frame update

    public float timeValue = 90;
    void Start()
    {
        MainMaster = new Master();
        if (animator != null)
        {
            MainMaster.animator = animator;
            MainMaster.levelToLoad = levelToLoad;
        }
        // MainMaster.startTimer();
        GameObject thisbox = Instantiate(Hitbox, new Vector3(0, 0, 0), Quaternion.identity);
        hitboxes.Add(thisbox);
    }
    public void OnFadeComplete()
    {
        MainMaster.OnFadeComplete();
    }
    public void Update()
    {   
        if (hitboxes[0] != null)
        {
            foreach (GameObject box in hitboxes)
            {
                box.transform.position = new Vector3(box.transform.position.x + speed, 0, 0);
            }

        }

    }

    //IEnumerator waiter()
    //{
    //    //Rotate 90 deg
    //    transform.Rotate(new Vector3(90, 0, 0), Space.World);

    //    //Wait for 4 seconds
    //    float waitTime = 4;
    //    yield return wait(waitTime);

    //    //Rotate 40 deg
    //    transform.Rotate(new Vector3(40, 0, 0), Space.World);

    //    //Wait for 2 seconds
    //    waitTime = 2;
    //    yield return wait(waitTime);

    //    //Rotate 20 deg
    //    transform.Rotate(new Vector3(20, 0, 0), Space.World);
    //}

    //IEnumerator wait(float waitTime)
    //{
    //    float counter = 0;

    //    while (counter < waitTime)
    //    {
    //        //Increment Timer until counter >= waitTime
    //        counter += Time.deltaTime;
    //        Debug.Log("We have waited for: " + counter + " seconds");
    //        if (quit)
    //        {
    //            //Quit function
    //            yield break;
    //        }
    //        //Wait for a frame so that Unity doesn't freeze
    //        yield return null;
    //    }
    //}
}
