using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TowardsExit : MonoBehaviour
{
    public float speed = 1.0f;
    public GameObject[] target;

    public Transform chosenTarget;

    public GameObject constructController;
    public ConstructController Controller;
    private Color ogColor;
    private Rigidbody rb;

    void Start()
    {

        // Find the ConstructController in the scene
        //constructController = FindObjectOfType<ConstructController>();
        Controller = constructController.GetComponent<ConstructController>();
        rb = GetComponent<Rigidbody>();

        if (Controller != null)
        {
            Debug.Log("ConstructController found!");
        }
        else
        {
            Debug.LogError("ConstructController not found!");
        }
        if (constructController == null)
        {
            Debug.LogError("ConstructController not found in the scene.");
        }

        // Choose a random target to go towards (optional, can be set by external script)
        findTarget();
    }
    void FixedUpdate()
    {
        if (chosenTarget != null)
        {
            Color myColor = GetComponent<Renderer>().material.color;
            
            Renderer targetRenderer = chosenTarget.GetComponent<Renderer>();
            if (targetRenderer != null)
            {
                targetRenderer.material.color = myColor;
            }
            var step = speed * Time.deltaTime;
            Vector3 newPosition = Vector3.MoveTowards(rb.position, chosenTarget.position, step);
            rb.MovePosition(newPosition);

            if (Vector3.Distance(transform.position, chosenTarget.position) < 0.1f)
            {

                Controller.AddPoint();
                Controller.killGuy();

                targetRenderer.material.color = ogColor;

                // Destroy this game object
                Destroy(gameObject);
            }
        }
        
    }

    public void findTarget()
    {
        if (target.Length > 0) 
        {
            int randomIndex = Random.Range(0, target.Length); 
            chosenTarget = target[randomIndex].transform;
            ogColor = target[randomIndex].GetComponent<Renderer>().material.color;
            target[randomIndex].SetActive(true);
        }
        else
        {
            Debug.Log("list is empty"); 
        }
    }
}
