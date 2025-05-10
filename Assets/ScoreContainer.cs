using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;


public class ScoreContainer : MonoBehaviour
{
   
    //public struct TextTogameObjects
    //{
    //    public string name;
    //    public GameObject gameObject;
    //}

    //public TextTogameObjects[] namedgameObjects;
    public GameObject[] gameObjects;
    private GameObject[]  myObjectsToPutAway = new GameObject[] { };
    //public Dictionary<string,GameObject> TextTogameObjects;
    public GameObject scorePlacement;
    public float spaceInbetweenNumbers = .5f;
    //public int score;
    // Start is called before the first frame update
    private void Start()
    {
        
        
        //UpdateScore(2222);
        
    }
    public void DeleteText()
    {
        foreach (GameObject obj in myObjectsToPutAway)
        {
            Destroy(obj);
        }
        myObjectsToPutAway = new GameObject[] { };
    }
    public void UpdateScore(float score)
    {
        string stringscore =score.ToString();
        int numberOfCharacterSpots = stringscore.Length;
        
        if (numberOfCharacterSpots % 2 == 0)
        {
            char[] characters = stringscore.ToCharArray();
            var charList = characters.ToList();
            char LastElementWeAreRemoving = charList[charList.Count - 1];
            charList.RemoveAt(charList.Count - 1);
            characters = charList.ToArray();


            int length = characters.Length / 2;
            print(score + ", " + length);

            //// Now we iterate through top half
            ///
            int i = length;
            Vector3 currentPos = scorePlacement.transform.position;

            while (i < characters.Length)
            {
                char c = characters[i];
                string cToString = c.ToString();
                GameObject me = Instantiate(gameObjects[int.Parse(cToString)], currentPos, transform.rotation);
                myObjectsToPutAway.Append(me);
                currentPos.x += spaceInbetweenNumbers;
                i = i + 1;
            }
            /// Now we iterate through bottom half
            /// 
            i = length;
            currentPos = scorePlacement.transform.position;
            currentPos.x -= spaceInbetweenNumbers;
            while (i != 0)
            {
                char c = characters[i];
                string cToString = c.ToString();
                GameObject me = Instantiate(gameObjects[int.Parse(cToString)], currentPos, transform.rotation);
                myObjectsToPutAway.Append(me);
                currentPos.x -= spaceInbetweenNumbers;
                i = i - 1;
            }

            // Here we put the last element back in
            //currentPos.x -= spaceInbetweenNumbers;
            GameObject mine = Instantiate(gameObjects[int.Parse(LastElementWeAreRemoving.ToString())], currentPos, transform.rotation);
            myObjectsToPutAway.Append(mine);
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
                GameObject me = Instantiate(gameObjects[int.Parse(cToString)], currentPos, transform.rotation);
                myObjectsToPutAway.Append(me);
                currentPos.x += spaceInbetweenNumbers;
                i = i + 1;
            }
            /// Now we iterate through bottom half
            /// 
            i = length;
            currentPos = scorePlacement.transform.position;
            currentPos.x -= spaceInbetweenNumbers;
            while (i != 0)
            {
                char c = characters[i];
                string cToString = c.ToString();
                GameObject me = Instantiate(gameObjects[int.Parse(cToString)], currentPos, transform.rotation);
                myObjectsToPutAway.Append(me);
                currentPos.x -= spaceInbetweenNumbers;
                i = i - 1 ;
            }




        }
        
    }
}
