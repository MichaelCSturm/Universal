using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Toggle : MonoBehaviour
{
    public GameObject target;

    public void Toggles()
    {
        target.SetActive(!target.activeSelf);
    }

}
