using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BS_Feet_Hitbox : BeatSaberHitbox
{
    // Start is called before the first frame update
    // Start is called before the first frame update
    void Start()
    {
        CheckForSpeficTrigger = true;
        //SpeficTriggerList.Add(RightLegTrigger);
        //SpeficTriggerList.Add(LeftLegTrigger);
        system = GetComponentInChildren<ParticleSystem>();
    }
}
