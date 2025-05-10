using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class test : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        int RandomLevelToFadeTo = UnityEngine.Random.Range(0, 5);
       
        print(RandomLevelToFadeTo);
    }
}
