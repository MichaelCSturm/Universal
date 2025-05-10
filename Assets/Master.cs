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
    public GameObject Player;
    public string filename = "MyScore.txt";
    public Animator animator;
    public int levelToLoad;
    public bool debugmode = true;
    private bool once = true;
    private bool failonce = true;
    //public float timePassed = Singleton.Instance.ElapsedTime;
    List<string> linesList = new List<string>();
    public GameObject HealthSystem;
    //public GameObject AudioController;
    public void Start()
    {
        //int localhealth = Singleton.Instance.ReturnHealth();
        //string newLocalHealth = localhealth.ToString();
        //Debug.Log("HEALTH IS : " + newLocalHealth);
        debugmode = true;
    }
    public void FadeToLevel(int levelIndex)
    {
        print("fade out");
        animator.SetTrigger("FadeOut");
        print("fade out 2");
        levelToLoad = levelIndex;
        OnFadeComplete();

    }
    public void OnFadeComplete()
    {
        failonce = true;
        //Player.SetActive(false);
        print("on fade complete");
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
    public void IncreaseLevelAndLoadNextScene(int levelIndex)
    {
        if (Singleton.Instance.Level <3)
        {
            Singleton.Instance.Level = Singleton.Instance.Level + 1;

        }
        RandomLevel(levelIndex);
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
    public int ReturnHealth()
    {
        return Singleton.Instance.Health;
    }
    public int ReturnScore()
    {
        return Singleton.Instance.Score;
    }
    public void ResetScore()
    {
        Singleton.Instance.Score =0;
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
            if (Input.GetKeyUp(KeyCode.Escape))
            {
                FadeToLevel(3);
            }
            if (Input.GetKeyUp(KeyCode.J))
            {
                FadeToLevel(2);
            }
            if (Input.GetKeyUp(KeyCode.K))
            {
                FadeToLevel(1);
            }
            if (Input.GetKeyUp(KeyCode.U))
            {
                FadeToLevel(4);
            }
            if (Input.GetKeyUp(KeyCode.I))
            {
                FadeToLevel(5);
            }
            if (Input.GetKeyUp(KeyCode.P))
            {
                FadeToLevel(0);
            }
        }

    }
    public void IncreaseLevel()
    {
        Singleton.Instance.IncreaseLevel();
    }
    public int ReturnLevel()
    {
        return Singleton.Instance.Level;

    }
    public void ResetHealth()
    {
        Singleton.Instance.ResetHealth();
    }
    public void RandomLevel(int myLevel)
    {
        print("got to random level");
        int RandomLevelToFadeTo = UnityEngine.Random.Range(0, 6);

        while (RandomLevelToFadeTo == myLevel || RandomLevelToFadeTo == 0) { 
        RandomLevelToFadeTo = UnityEngine.Random.Range(1, 6);
            if (RandomLevelToFadeTo != myLevel) 
            {
                break;
            }
        }
        print("going to level fade");
        FadeToLevel(RandomLevelToFadeTo);
        //FadeToLevel(3);
    }
    public void FailLevel(int myLevel)
    {
        print("fail level called");
        //Singleton.Instance.Health = 1;
        if (failonce)
        {
            PlayLose();
            failonce = false;
            Singleton.Instance.SubtractHealth();
            //print(Singleton.Instance.Health.ToString());
            if (Singleton.Instance.Health <= 0)
            {
                var score = ReturnScore().ToString();
                print("Hey YOU FAILED THE LEVEL AND YOUR HEALTH IS BELOW OR EQUAL TO 0 Impliment a system in Master FailLevel to swap to a menu scene");
                // Console.WriteLine(score, "your score");
                Singleton.Instance.ResetHealth();
                Singleton.Instance.ResetLevel();
                Singleton.Instance.ResetTimer();
                SaveScore();
                ResetScore();
                //RandomLevel(myLevel);
                FadeToLevel(0);
            }
            else 
            {
                RandomLevel(0);
            }

        }

    }
    public void PlayLose()
    {
        try
        {
            GameObject AudioPlayer = GameObject.FindWithTag("MusicPlayer");
            if (AudioPlayer != null)
            {
                MusicScript script = AudioPlayer.GetComponent<MusicScript>();
                script.PlayLoseSound();
            }
            else {
                print("Hey we dont got a Music Player in this ");
            }
        }
        catch (Exception e) { 
        
        print(e.ToString());
            print("ERRORRR in Master PlayLose()");
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
