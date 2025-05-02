using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CanvasScript : MonoBehaviour
{
    public GameObject[] Info;
    private int i = 0;
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void nextButt()
{
    Info[i].SetActive(false);
    i++;
    if (i >= Info.Length)
    {
        i = 0;
    }
    Info[i].SetActive(true);
}

public void prevButt()
{
    Info[i].SetActive(false);
    i--;
    if (i < 0)
    {
        i = Info.Length - 1;
    }
    Info[i].SetActive(true);
}
}
