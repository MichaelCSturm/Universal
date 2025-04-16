using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BeatSaberManager : MonoBehaviour
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
    public void OnFadeComplete()
    {
        MainMaster.OnFadeComplete();
    }
}
