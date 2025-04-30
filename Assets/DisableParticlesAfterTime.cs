using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShrinkAndDisableParticles : MonoBehaviour
{
    public float delay = 5f;
    public float shrinkDuration = 1f;

    private ParticleSystem ps;
    private Vector3 originalScale;
    private float shrinkStartTime;
    private bool isShrinking = false;

    void Start()
    {
        ps = GetComponent<ParticleSystem>();
        originalScale = transform.localScale;

        if (ps != null)
        {
            Invoke(nameof(StartShrinking), delay);
        }
        else
        {
            Debug.LogWarning("No ParticleSystem found on this GameObject.");
        }
    }

    void StartShrinking()
    {
        shrinkStartTime = Time.time;
        isShrinking = true;
    }

    void Update()
    {
        if (isShrinking)
        {
            float elapsed = Time.time - shrinkStartTime;
            float t = Mathf.Clamp01(elapsed / shrinkDuration);
            transform.localScale = Vector3.Lerp(originalScale, Vector3.zero, t);

            if (t >= 1f)
            {
                ps.Stop();
                ps.Clear();
                isShrinking = false;
                // Optional: Destroy(gameObject); // Uncomment to destroy after shrinking
            }
        }
    }
}