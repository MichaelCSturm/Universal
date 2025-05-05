using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class GameController : MonoBehaviour
{
    public int hardLevelPoints = 10;
    public int mediumLevelPoints = 5;
    public int easyLevelPoints = 3;

    private int winThreshold;
    private int currentPoints = 0;

    private bool newRound = true;

    public GameObject[] lavaCubes;
    public GameObject[] safeCubes;
    public GameObject[] WarningCubes;

    public List<int> chosenIndexes = new List<int>();
    private List<int> warningIndex;
    private List<int> safeIndex;

    private bool isLavaSwitching = false;

    private float time = 5f;

    public int numberOfLavaBlocks = 5;

    // Start is called before the first frame update
    void Start()
    {
        currentPoints = 0;
        newRound = true;
        StartCoroutine(SwitchLava());
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void GameOver()
    {
        newRound = false;
        Debug.Log("GameOver");
        //Add the logic for game ending
    }
    private void GameWin()
    {
        Debug.Log("GameWin");
        //add the logic for win and change scenes here
    }
    public void AddPoints()
    {
        Debug.Log("AddPoints");
        if(newRound == true)
        {
            Debug.Log(newRound == true);
            currentPoints++;
            CheckPoints();
            newRound = false;
        }

    }
    private void CheckPoints()
    {
        if(currentPoints < winThreshold)
        {
            GameWin();
        }
    }
    private void CheckLevel()
    {
        //add logic here to switch the game level and the winthreshold variable with it
    }


   IEnumerator SwitchLava()
    {
        if (time > 1f)
        {
            time = time - 0.25f;
        }
        Debug.Log("SwitchLava");
        isLavaSwitching = true;
        RunWarning();
        yield return new WaitForSeconds(time);
        AddLava();
        yield return new WaitForSeconds(3f);
        isLavaSwitching = false;

        if (!isLavaSwitching && newRound == true)
        {
            StartCoroutine(SwitchLava());
        }
    }

    private void RunWarning()
    {
        Debug.Log("RunWarning");
        Randomizer();

        // Disable all cubes first to ensure a clean slate
        for (int i = 0; i < WarningCubes.Length; i++)
        {
            WarningCubes[i].SetActive(false);
        }
        for (int i = 0; i < safeCubes.Length; i++)
        {
            safeCubes[i].SetActive(false);
        }

        // Enable warning cubes at the chosen indexes
        foreach (int index in chosenIndexes)
        {
            if (index >= 0 && index < WarningCubes.Length)
            {
                WarningCubes[index].SetActive(true);
            }
        }

        for (int i = 0; i < safeCubes.Length; i++)
        {
            if (!chosenIndexes.Contains(i))
            {
                safeCubes[i].SetActive(true);
            }
        }

    }
    private void AddLava()
    {
        Debug.Log("AddLava");

        for (int i = 0; i < WarningCubes.Length; i++)
        {
            WarningCubes[i].SetActive(false);
        }
        for (int i = 0; i < lavaCubes.Length; i++)
        {
            lavaCubes[i].SetActive(false);
        }
        for (int i = 0; i < safeCubes.Length; i++)
        {
            safeCubes[i].SetActive(false);
        }
        foreach (int index in chosenIndexes)
        {
            if (index >= 0 && index < lavaCubes.Length)
            {
                lavaCubes[index].SetActive(true);
            }
        }

        newRound = true;
    }
    private void Randomizer()
    {
        Debug.Log("Randomizer");
        chosenIndexes.Clear();

        List<int> availableIndexes = new List<int>();
        for (int i = 0; i < 20; i++)
        {
            availableIndexes.Add(i);
        }

        for (int i = 0; i < availableIndexes.Count; i++)
        {
            int randomIndex = Random.Range(i, availableIndexes.Count);
            int temp = availableIndexes[i];
            availableIndexes[i] = availableIndexes[randomIndex];
            availableIndexes[randomIndex] = temp;
        }

        for (int i = 0; i < numberOfLavaBlocks; i++)
        {
            chosenIndexes.Add(availableIndexes[i]);
        }
    }
}
