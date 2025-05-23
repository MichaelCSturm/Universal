using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.SceneManagement;
using Valve.VR;

public class MainMenu : MonoBehaviour
{
    public Material sky;
    public GameObject Player;
    public GameObject[] objects;
    public SteamVR_Behaviour_Pose[] SteamVrBehaviorPoses;
    public bool debugMode;
    public Animator animator;
    public GameObject Master;
    //public float speed;
    Master MainMaster;
    private int levelToLoad;
    public int myLevel= 0;
    //public GameObject score;
    public TextMeshProUGUI textMeshProUGUI;
    void Start()
    {
        RenderSettings.skybox = sky;
        GameObject ObjectMaster = Instantiate(Master, new Vector3(0, 0, 0), Quaternion.identity);
        MainMaster = ObjectMaster.GetComponent<Master>();
        //MainMaster = new Master();
        if (animator != null)
        {
            MainMaster.animator = animator;
            MainMaster.levelToLoad = levelToLoad;
            MainMaster.debugmode = debugMode;
        }
        string HighScore = MainMaster.GetHighScores();
       // TextMeshPro scoreText = score.GetComponent<TextMeshPro>();
        string realText = "High Score " + HighScore;
        textMeshProUGUI.text = realText;
        MainMaster.Player = Player;
    }

    // Update is called once per frame
    void Update()
    {
        
    }
    public void OnFadeComplete() // has to be here or animator will freak out
    {
        MainMaster.OnFadeComplete();
    }
    public void ChangeScene()
    {
        
        MainMaster.RandomLevel(0);
    }
    public void TutorialViewer()
    {

    }
    public void ThrowText()
    {
        print("There is a click");
    }
}
