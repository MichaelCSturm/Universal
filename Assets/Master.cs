using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.SocialPlatforms.Impl;
using System.IO;
using System;
using System.Runtime.Serialization.Formatters.Binary;
using System.Text;
using System.Linq;


public class Master : MonoBehaviour
{
    
    public string filename = "MyScore.txt";
    public Animator animator;
    public int levelToLoad;
    public bool debugmode = false;
    private bool once = true;
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
    public string GetHighScores()
    {
        string path = Application.persistentDataPath + Path.DirectorySeparatorChar + filename;

        if (File.Exists(path))
        {
            //string path = Application.persistentDataPath + Path.DirectorySeparatorChar + filename;
            print(path);
            using var sr = new StreamReader(path);
            string line;
            List<string> lines = new List<string>();
            while ((line = sr.ReadLine()) != null)
            {
                lines.Add(line);
            }
            int greatestnum = 0;
            foreach (string num in lines)
            {
                int number = int.Parse(num);
                if (number > greatestnum)
                {
                    greatestnum = number;
                }
            }
            return greatestnum.ToString();
        }
        else
        {
            return "0";
        }
    }
    public void SaveScore()
    {
        if (once)
        {
            once = false;
            //print(File.Exists(filename));
            string path = Application.persistentDataPath + Path.DirectorySeparatorChar + filename;

            if (File.Exists(path))
            {
                //string path = Application.persistentDataPath + Path.DirectorySeparatorChar + filename;
                print(path);
                BinaryFormatter bf = new BinaryFormatter();
                using FileStream file = File.Open(path, FileMode.Append);
                using var sr = new StreamWriter(file);
                string myscore = ReturnScore().ToString(); 
                print(myscore);
                sr.WriteLine(myscore);


                

                //file.Close();
            }
            else
            {
                //string path = Application.persistentDataPath + Path.DirectorySeparatorChar + filename;
                print(path);
                BinaryFormatter bf = new BinaryFormatter();
                using FileStream file = File.Create(path);
                using var sr = new StreamWriter(file);
                string myscore = ReturnScore().ToString();
                print(myscore);
                sr.WriteLine(myscore);

            }
            once = true;
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



    /// <summary>
    ///  HERE BE DEBUG MODE
    /// </summary>



    public void Update()
    {
        Timer();
        if (debugmode)
        {
            if (Input.GetKey(KeyCode.Space))
            {
                //FailLevel();
                print(GetHighScores());
            }

        }
        
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
            print("Hey YOU FAILED THE LEVEL AND YOUR HEALTH IS BELOW OR EQUAL TO 0 Impliment a system in Master FailLevel to swap to a menu scene");
           // Console.WriteLine(score, "your score");
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
