using Unity.VisualScripting;
using UnityEngine;

public class MusicScript : MonoBehaviour
{
    public AudioClip[] playlist;
    
    private AudioSource audiosource;
    public bool randomPlay = false;
    private int currentClipIndex = 0;
    void Start()
    {
        audiosource = FindObjectOfType<AudioSource>();
        audiosource.loop = false;
    }

    void Update()
    {
        if (!audiosource.isPlaying)
        {
            AudioClip nextClip;
            if (randomPlay)
            {
                nextClip = GetRandomClip();
            }
            else
            {
                nextClip = GetNextClip();
            }
             // = playlist.IndexOf(nextClip);
            //int index;
            for (int i = 0; i < playlist.Length; i++)
            {
                if (playlist[i] == nextClip)
                {
                    currentClipIndex = i;
                    break;
                }
            }
            audiosource.clip = nextClip;
            audiosource.Play();
        }
    }

    private AudioClip GetRandomClip()
    {
        return playlist[Random.Range(0, playlist.Length)];
    }

    private AudioClip GetNextClip()
    {
        return playlist[(currentClipIndex + 1) % playlist.Length];
    }

    private void Awake()
    {
        DontDestroyOnLoad(transform.gameObject);
    }
}