using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TowardsExit : MonoBehaviour
{
    public float speed = 1.0f;
    public GameObject[] target;

    private Transform chosenTarget;


    void Update()
    {
        if (chosenTarget != null)
        {
            var step = speed * Time.deltaTime;
            transform.position = Vector3.MoveTowards(transform.position, chosenTarget.position, step); 
        }
    }

    public void findTarget()
    {
        if (target.Length > 0) 
        {
            int randomIndex = Random.Range(0, target.Length); 
            chosenTarget = target[randomIndex].transform;
            target[randomIndex].SetActive(true);
        }
        else
        {
            Debug.Log("list is empty"); 
        }
    }
}
