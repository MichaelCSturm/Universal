using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class LockPosition : MonoBehaviour
{
    private Vector3 initialPosition;

    void Start()
    {
        // Save the initial position of the GameObject
        initialPosition = transform.position;
    }

    void LateUpdate()
    {
        // Force the GameObject back to its original position every frame
        transform.position = initialPosition;
    }
}