using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class uiDanceCircle : MonoBehaviour
{

    public float destroyAfterThisTime = 5.0f;
    public float decay = 2;
    public GameObject self;
    public float x =100;
    public float y = 100;
    public float z = 100;
    float a;
    float b;

    public static Vector3 HalflifeLerp(Vector3 current, Vector3 target, float halflife, float deltaTime)
    {
        float lambda = Mathf.Log(2) / halflife;
        float t = 1 - Mathf.Exp(-lambda * deltaTime);
        return Vector3.Lerp(current, target, t);
    }
    public float expDecay(float a, float b, float dt, float h)
    {
        //print(b + (a - b));
        return b + (a - b) * Mathf.Exp(-dt / h);
    }
    void Start()
    {
       // x = self.transform.localScale.x;
       // y = self.transform.localScale.y;
       // z = self.transform.localScale.z;
        Destroy(gameObject, destroyAfterThisTime);
        a = 10f; // Example value
        b = 0f; // Example value
    }
    
    // Update is called once per frame
    void Update()
    {
        //a = expDecay(a, b, decay, Time.deltaTime);
        //print(a);
        //= Vector3.Lerp(transform.localScale, transform.localScale * 2, Time.deltaTime * 10);
        //x = expDecay(x, 0.1f, decay, Time.deltaTime);
        //y = expDecay(y, 0.1f, decay, Time.deltaTime);
        //z = expDecay(z, 0.1f, decay, Time.deltaTime);
        //print(x);
        //Debug.Log("x: ", x);


        self.transform.localScale = HalflifeLerp(self.transform.localScale, new Vector3(0, 0, 0), destroyAfterThisTime/8, Time.deltaTime);
    }
}
