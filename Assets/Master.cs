using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.SocialPlatforms.Impl;
using System.IO;
using System;


public class Master : MonoBehaviour
{
    
    public string filename = "MyScore.txt";
    public Animator animator;
    public int levelToLoad;
    //public float timePassed = Singleton.Instance.ElapsedTime;
    List<string> linesList = new List<string>();
    public List<string> ReadScore()
    {
        if (File.Exists(filename))
        {
            var sr = File.OpenText(filename);
            var line = sr.ReadLine();
           // List<string> linesList = new List<string>();

            while (line != null)
            {
                Debug.Log(line); // prints each line of the file
                line = sr.ReadLine();
                linesList.Add(line);
            }
            return linesList;
        }
        else
        {
            Debug.Log("Could not Open the file: " + filename + " for reading.");
            return new List<string>();
        }
    }
    public void Start()
    {
        if (File.Exists(filename))
        {
            Debug.Log(filename + " already exists.");
            return;
        }
        var sr = File.CreateText(filename);
        sr.Close();
        List<string> strings = ReadScore();
        foreach (string s in strings)
        {
            print(s);
        }
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
            var sr = new StreamWriter(filename);
            var score = ReturnScore().ToString();
            sr.WriteLine(score);
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
            print("Hey YOU FAILED THE LEVEL AND YOUR HEALTH IS BELOW OR EQUAL TO 0\n\n\n Impliment a system in Master FailLevel to swap to a menu scene");
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
