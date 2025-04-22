using UnityEngine;

public class Shooter : MonoBehaviour
{
    public GameObject projectilePrefab;  // Reference to the projectile prefab
    public Transform shootingPoint;      // Point from where the projectile will be shot (could be a child object)
    public float fireRate = 1f;          // Time between each shot (in seconds)
    public float projectileSpeed = 10f;  // Speed of the projectile

    private float nextFireTime = 0f;     // Time when the next shot can be fired

    void Update()
    {
        // Auto-fire: Fire every 'fireRate' seconds
        if (Time.time > nextFireTime)
        {
            ShootProjectile();
            nextFireTime = Time.time + fireRate;  // Set the next shot time based on fire rate
        }
    }

    void ShootProjectile()
    {
        // Instantiate the projectile at the shooting point
        GameObject projectile = Instantiate(projectilePrefab, shootingPoint.position, shootingPoint.rotation);

        // Add a velocity to the projectile to move it forward
        Rigidbody rb = projectile.GetComponent<Rigidbody>();
        if (rb != null)
        {
            // Set the projectile's velocity along the forward direction (z-axis in Unity 3D)
            rb.velocity = shootingPoint.forward * projectileSpeed;
        }
    }
}