using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HeartController : MonoBehaviour
{
    // Start is called before the first frame update
    public Material LiveHeartMat;
    public Material DeadHeartMat;
    //public int lives;
    public GameObject[] Hearts;
    public Animator[] Animators;
    public void OneLife() 
    {
        if (Hearts != null)
        {
            Hearts[0].GetComponent<Renderer>().material = LiveHeartMat;
            Hearts[1].GetComponent<Renderer>().material = DeadHeartMat;
            Hearts[2].GetComponent<Renderer>().material = DeadHeartMat;
            Hearts[3].GetComponent<Renderer>().material = DeadHeartMat;
            Animators[1].Play("BreakHeart");
            Animators[2].Play("BreakHeart");
            Animators[3].Play("BreakHeart");
        }
    }
    public void TwoLife()
    {
        if (Hearts != null)
        {
            Hearts[0].GetComponent<Renderer>().material = LiveHeartMat;
            Hearts[1].GetComponent<Renderer>().material = LiveHeartMat;
            Hearts[2].GetComponent<Renderer>().material = DeadHeartMat;
            Hearts[3].GetComponent<Renderer>().material = DeadHeartMat;
            Animators[2].Play("BreakHeart");
            Animators[3].Play("BreakHeart");
        }
    }
    public void ThreeLife()
    {
        if (Hearts != null)
        {
            Hearts[0].GetComponent<Renderer>().material = LiveHeartMat;
            Hearts[1].GetComponent<Renderer>().material = LiveHeartMat;
            Hearts[2].GetComponent<Renderer>().material = LiveHeartMat;
            Hearts[3].GetComponent<Renderer>().material = DeadHeartMat;
            
            Animators[3].Play("BreakHeart");
        }
    }
    public void FourLife()
    {
        if (Hearts != null)
        {
            Hearts[0].GetComponent<Renderer>().material = LiveHeartMat;
            Hearts[1].GetComponent<Renderer>().material = LiveHeartMat;
            Hearts[2].GetComponent<Renderer>().material = LiveHeartMat;
            Hearts[3].GetComponent<Renderer>().material = LiveHeartMat;
        }
    }
}
