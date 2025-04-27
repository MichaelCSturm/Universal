using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DestructManager : MonoBehaviour
{
    public Animator animator;
    public GameObject Master;
   // public float speed;
    Master MainMaster;
    private int levelToLoad;
    public bool debugMode;
    private int totalBreakables;
    private bool winDisplayed = false;
    void Start()
    {
        GameObject ObjectMaster = Instantiate(Master, new Vector3(0, 0, 0), Quaternion.identity);
        MainMaster = ObjectMaster.GetComponent<Master>();
        //MainMaster = new Master();
        if (animator != null)
        {
            MainMaster.animator = animator;
            MainMaster.levelToLoad = levelToLoad;
        }
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
