using UnityEngine;

public class FractureScript : MonoBehaviour
{
    public GameObject fractureVariant;
    public GameObject Full;
    // Start is called once before the first execution of Update after the MonoBehaviour is created
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnCollisionEnter(Collision collision)
    {
        //toggle solid
        //Full.SetActive(false);
        Destroy(Full);

        //toggle break apart
        fractureVariant.SetActive(true);
    }


}
