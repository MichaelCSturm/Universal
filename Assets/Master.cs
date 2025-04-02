using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class Master : MonoBehaviour
{
    public Animator animator;
    public int levelToLoad;
    public void FadeToLevel(int levelIndex)
    {
        animator.SetTrigger("FadeOut");
        levelToLoad = levelIndex;
    }
    public void OnFadeComplete()
    {
        SceneManager.LoadScene(levelToLoad);
    }
}
