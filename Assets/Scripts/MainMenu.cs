using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.SceneManagement;

public class MainMenu : MonoBehaviour
{
    public bool debugMode;
    public Animator animator;
    public GameObject Master;
    //public float speed;
    Master MainMaster;
    private int levelToLoad;
    //public GameObject score;
    public TextMeshProUGUI textMeshProUGUI;
    void Start()
    {
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
    }

    // Update is called once per frame
    void Update()
    {
        if (debugMode)
        {
            if (Input.GetKeyUp(KeyCode.Escape))
            {
                MainMaster.IncreaseLevelAndLoadNextScene(3);
            }
        }
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
