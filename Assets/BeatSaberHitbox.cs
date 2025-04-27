using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BeatSaberHitbox : Hitbox
{
    public ParticleSystem system;
    //private bool hit = false;
    void Update()
    {
        if (hit)
        {
            var emitParams = new ParticleSystem.EmitParams();
            emitParams.startColor = Color.red;
            emitParams.startSize = 0.2f;
            system.Emit(emitParams, 10);
            system.Play(); 
       }
    }

    void OnTriggerEnter(Collider other)
    {
        
        hit = true;
        Debug.Log("ayo it hit");
    }
}
