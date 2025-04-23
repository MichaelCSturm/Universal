using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.SocialPlatforms.Impl;

public class Master : MonoBehaviour
{

    public Animator animator;
    public int levelToLoad;
    //public float timePassed = Singleton.Instance.ElapsedTime;
    public void FadeToLevel(int levelIndex)
    {
        animator.SetTrigger("FadeOut");
        levelToLoad = levelIndex;
    }
    public void OnFadeComplete()
    {
        SceneManager.LoadScene(levelToLoad);
    }
    //public static Singleton Instance { get; private set; }
    public int ReturnScore()
    {
        return Singleton.Instance.Score;
    }
    public void AddToScore(int number_to_add)
    {
        Singleton.Instance.Score = Singleton.Instance.Score + number_to_add;
    }
    public void Timer()
    {
        Singleton.Instance.ElapsedTime += Time.deltaTime;
    }
    public float TimeManager()
    { 
        return Singleton.Instance.ElapsedTime;
    }
    public void Update()
    {
        Timer();
    }


    //void Awake()
    //{
    //    Singleton = new Singleton();
    //}
    //public void startTimer()
    //{
    //    Singleton.Instance.ResetTimer();
    //    Singleton.Instance.StartTimer();
    //}
}
