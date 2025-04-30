using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class BS_Hand_Hitbox : BeatSaberHitbox
{
    // Start is called before the first frame update
    void Start()
    {
        CheckForSpeficTrigger = true;
        //SpeficTriggerList.Add(RightArmTrigger);
        //SpeficTriggerList.Add(LeftArmTrigger);
        system = GetComponentInChildren<ParticleSystem>();
    }

    
}
