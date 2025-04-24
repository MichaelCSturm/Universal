using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Singleton 
{
    public static Singleton instance;
    public bool IsRunning;
    public float ElapsedTime;
    public int Score;
    public int Level;
    public int Health;
    private int OrignalHealth;
    private Singleton() 
    {
        ElapsedTime = 0;

        IsRunning = true;

        Score = 0;

        Level = 0;

        Health = 3;

        OrignalHealth = Health;
    }

    public static Singleton Instance
    {
        get
        {
            if (instance == null)
            {
                instance = new Singleton();
            }
            return instance;
        }
    }

    //private void Awake()
    //{
    //    if (Instance != null && Instance != this)
    //    {
    //        Destroy(gameObject);
    //    }
    //    else
    //    {
    //        Instance = this;
    //    }
    //}
    private void Update()
    {
        if (IsRunning)
        {
            ElapsedTime += Time.deltaTime;
        }
    }
    public void ResetLevel()
    {
        Level = 0;
    }
    public void IncreaseLevel()
    {
        Level = Level + 1;
    }

    public void StartTimer()
    {
        IsRunning = true;
    }

    public void StopTimer()
    {
        IsRunning = false;
    }

    public void ResetTimer()
    {
        ElapsedTime = 0f;
    }
    public void SubtractHealth()
    {
        Health = Health - 1;
    }
    public void ResetHealth()
    {
        Health = OrignalHealth;
    }
}
