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
    public float TimeManager()
    { 
        Singleton.Instance.ElapsedTime += Time.deltaTime;
        float timePassed = Singleton.Instance.ElapsedTime;
        return timePassed;
    }
    public void Update()
    {
        var ignoreme = TimeManager();
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
