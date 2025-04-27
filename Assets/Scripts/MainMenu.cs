using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class MainMenu : MonoBehaviour
{
    public Animator animator;
    public GameObject Master;
    //public float speed;
    Master MainMaster;
    private int levelToLoad;
    void Start()
    {
        GameObject ObjectMaster = Instantiate(Master, new Vector3(0, 0, 0), Quaternion.identity);
        MainMaster = ObjectMaster.GetComponent<Master>();
        //MainMaster = new Master();
        if (animator != null)
        {
            MainMaster.animator = animator;
            MainMaster.levelToLoad = levelToLoad;
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }
    public void OnFadeComplete() // has to be here or animator will freak out
    {
        MainMaster.OnFadeComplete();
    }
    public void ChangeScene(int index)
    {
        MainMaster.FadeToLevel(index);
    }
    public void TutorialViewer()
    {

    }
}
