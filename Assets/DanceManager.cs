using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class DanceManager : MonoBehaviour
{
    public Animator animator;
    Master MainMaster;
    private int levelToLoad;
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
    }

    

    // Update is called once per frame
    void Update()
    {
        timeValue -=Time.deltaTime;
        print(MainMaster.TimeManager().ToString());
    }
}
