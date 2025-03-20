using UnityEngine;

public class FractureOnImpact : MonoBehaviour
{
    public float impactForceThreshold = 1f;
    public AudioSource breakSound;
    private Rigidbody[] pieceRigidbodies;

    void Start()
    {
        pieceRigidbodies = GetComponentsInChildren<Rigidbody>();
        foreach (Rigidbody rb in pieceRigidbodies)
        {
            rb.isKinematic = true;
        }
    }

    private void OnCollisionEnter(Collision collision)
    {
        if (collision.relativeVelocity.magnitude > impactForceThreshold)
        {
            ActivateFracture();
        }
    }

    void ActivateFracture()
    {
        foreach (Rigidbody rb in pieceRigidbodies)
        {
            rb.isKinematic = false;
            rb.AddExplosionForce(300f, transform.position, 5f);
        }

        if (breakSound != null)
        {
            breakSound.Play();
        }

        Destroy(gameObject, 5f);
    }
}
