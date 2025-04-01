using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class DanceManager : MonoBehaviour
{
    public Animator animator;
    Manager MainManager;
    private int levelToLoad;
    // Start is called before the first frame update
    void Start()
    {
        MainManager = new Manager();
        print(MainManager.getme);
    }

    public void FadeToLevel(int levelIndex)
    {
        animator.SetTrigger("FadeOut");
        levelToLoad=levelIndex;
    }
    public void OnFadeComplete()
    {
        SceneManager.LoadScene(levelToLoad);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
