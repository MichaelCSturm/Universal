using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BeatSaberHitbox : Hitbox
{
    public ParticleSystem system;
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
}
