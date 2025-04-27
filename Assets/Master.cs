using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.SocialPlatforms.Impl;
using System.IO;
using System;
using System.Runtime.Serialization.Formatters.Binary;
using System.Text;


public class Master : MonoBehaviour
{
    
    public string filename = "MyScore.txt";
    public Animator animator;
    public int levelToLoad;
    //public float timePassed = Singleton.Instance.ElapsedTime;
    List<string> linesList = new List<string>();
   
    public void Start()
    {
        
    }
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
    public void SaveScore()
    {
        if (File.Exists(filename))
        {
            string path = Application.persistentDataPath + Path.DirectorySeparatorChar + filename;
            BinaryFormatter bf = new BinaryFormatter();
            FileStream file = File.Open(path, FileMode.OpenOrCreate);
            string score = "9999";
            byte[] writeArr = Encoding.UTF8.GetBytes(score);
            file.Write(writeArr, 0, score.Length);
        }
        else
        {
            print("EY WE DONT HAVE THAT FILE FOR SOME REASON");
        }
    }
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
    public void IncreaseLevelAndLoadNextScene(int levelIndex)
    {
        Singleton.Instance.IncreaseLevel();
        FadeToLevel(levelIndex);
    }
    public void ResetHealth()
    {
        Singleton.Instance.ResetHealth();
    }
    public void FailLevel()
    {
        Singleton.Instance.SubtractHealth();
        if (Singleton.Instance.Health <= 0)
        {
            var score = ReturnScore().ToString() ;
            print("Hey YOU FAILED THE LEVEL AND YOUR HEALTH IS BELOW OR EQUAL TO 0\n\n\n Impliment a system in Master FailLevel to swap to a menu scene");
            Console.WriteLine(score, "your score");
            Singleton.Instance.ResetHealth();
            Singleton.Instance.ResetLevel();
            Singleton.Instance.ResetTimer();
            SaveScore();
        }

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
