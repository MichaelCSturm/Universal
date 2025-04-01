using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DanceManager : MonoBehaviour
{
    Manager HeadHonco;
    // Start is called before the first frame update
    void Start()
    {
        HeadHonco = new Manager();
        print(HeadHonco.getme);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
