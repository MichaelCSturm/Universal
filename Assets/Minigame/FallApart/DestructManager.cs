using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DestructManager : MonoBehaviour
{
    private int totalBreakables;
    private bool winDisplayed = false;
    void Start()
    {
        totalBreakables = GameObject.FindGameObjectsWithTag("Breakable").Length;
        if (totalBreakables == 0)
        {
            Debug.LogWarning("No Breakable objects found in the scene.");
        }
    }
    void Update()
    {
        if (!winDisplayed)
        {
            int remaining = GameObject.FindGameObjectsWithTag("Breakable").Length;
            if (remaining == 0 && totalBreakables > 0)
            {
                winDisplayed = true;
                Debug.Log("YOU WIN");
            }
        }
    }
}
