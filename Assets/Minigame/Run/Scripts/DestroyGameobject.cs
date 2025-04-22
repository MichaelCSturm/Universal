using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class DestroyGameobject : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnTriggerEnter(Collider collision)
    {
        Debug.Log("Destroycalled");
        if (collision.gameObject.CompareTag("Obstacle"))
        {
            Debug.Log("Comparedtag");
            Destroy(collision.gameObject.transform.parent.gameObject);
        }
    }
}
