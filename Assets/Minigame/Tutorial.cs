using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.InputSystem;

public class Tutorial : MonoBehaviour
{
    public GameObject[] tutorials;
    private int index = 0;

    // Start is called before the first frame update
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {
        //if (Keyboard.current.aKey.wasPressedThisFrame)
        //{
        //    PreviousTutorial();
        //}
        //if (Keyboard.current.dKey.wasPressedThisFrame)
        //{
        //    NextTutorial();
        //}
    }

    public void NextTutorial()
    {
        if (index < tutorials.Length - 1)
        {
            tutorials[index].SetActive(false);
            index++;
            tutorials[index].SetActive(true);
        }
        else
        {
            tutorials[index].SetActive(false);
            index = 0;
            tutorials[index].SetActive(true);
        }
    }
    public void PreviousTutorial()
    {
        if (index > 0)
        {
            tutorials[index].SetActive(false);
            index--;
            tutorials[index].SetActive(true);
        }
        else
        {
            tutorials[index].SetActive(false);
            index = tutorials.Length - 1;
            tutorials[index].SetActive(true);
        }

    }
}
