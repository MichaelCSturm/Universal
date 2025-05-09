using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using static UnityEditor.FilePathAttribute;

public class ScoreContainer : MonoBehaviour
{
   
    //public struct TextTogameObjects
    //{
    //    public string name;
    //    public GameObject gameObject;
    //}

    //public TextTogameObjects[] namedgameObjects;
    public GameObject[] gameObjects;

    //public Dictionary<string,GameObject> TextTogameObjects;
    public GameObject scorePlacement;
    public float spaceInbetweenNumbers = .5f;
    //public int score;
    // Start is called before the first frame update
    private void Start()
    {
        UpdateScore(4);
        UpdateScore(67);
        UpdateScore(1);
        UpdateScore(22222);
        UpdateScore(5);
        UpdateScore(12);
    }
    public void UpdateScore(float score)
    {
        string stringscore =score.ToString();
        int numberOfCharacterSpots = stringscore.Length;
        
        if (numberOfCharacterSpots % 2 == 0)
        {
            //print("hey figure out a center point from the center because theres more than one middle in the array");///
        }
        else 
        {
            char[] characters = stringscore.ToCharArray();
            int length = characters.Length / 2;
            print(score +", "+length);

            //// Now we iterate through top half
            ///
            int i = length;
            Vector3 currentPos = scorePlacement.transform.position;
            
            while (i < characters.Length)
            {
                char c = characters[i];
                string cToString = c.ToString();
                Instantiate(gameObjects[int.Parse(cToString)], currentPos, Quaternion.identity);
                currentPos.x += spaceInbetweenNumbers;
                i = i + 1;
            }

        }
    }
}
