using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ProjectileSuicider : MonoBehaviour
{
    public float destroyAfterThisTime = 5.0f;
    // Update is called once per frame
    void Start()
    {
        Destroy(gameObject, destroyAfterThisTime);
    }
}
