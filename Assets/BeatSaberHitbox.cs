using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class BeatSaberHitbox : Hitbox
{
    public ParticleSystem system;
    //private bool hit = false;
    bool once = true;
    public Animator animator;
    void Update()
    {
        if (hit && once)
        {
            var emitParams = new ParticleSystem.EmitParams();
            emitParams.startColor = Color.red;
            emitParams.startSize = 0.2f;
            system.Emit(emitParams, 10);
            system.Play(); 
            once = false;
            animator.Play("MakeSmaller on hit");
       }
    }

    void OnTriggerEnter(Collider other)
    {
        if (other.tag != "BeatSaberBox")
        {
            hit = true;
            Debug.Log("ayo it hit");
        }
        
    }
}
