using UnityEngine;

public class ExplodeOnImpact : MonoBehaviour
{
    public GameObject fractureVariant;
    public float explosionForce = 250f;
    public float explosionRadius = 1.5f;
    public float fragmentLifetime = 5f;

    private void OnCollisionEnter(Collision collision)
    {
        if (collision.relativeVelocity.magnitude > 1f)
        {
            Explode();
        }
    }

    void Explode()
    {
        if (fractureVariant != null)
        {
            GameObject fragments = Instantiate(fractureVariant, transform.position, transform.rotation);

            foreach (Rigidbody rb in fragments.GetComponentsInChildren<Rigidbody>())
            {
                rb.AddExplosionForce(explosionForce, transform.position, explosionRadius);
            }

            Destroy(fragments, fragmentLifetime);
        }

        Debug.Log("Destroying ExplodingSphere: " + gameObject.name);
        Destroy(gameObject);
    }
}
