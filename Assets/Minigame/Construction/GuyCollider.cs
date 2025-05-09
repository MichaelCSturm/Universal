using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GuyCollider : MonoBehaviour
{
    public ConstructController constructController;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
    public void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("Guy"))
        {
            constructController.NumGuysLost();
            constructController.KillGuy();
            if (other.gameObject != null){
                Destroy(other.gameObject);
            }
            

        }
    }
}
