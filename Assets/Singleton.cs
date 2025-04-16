using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Singleton 
{
    public static Singleton instance;
    public bool IsRunning;
    public float ElapsedTime;
    private Singleton() 
    {
        ElapsedTime = 0;

        IsRunning = true;
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
}
