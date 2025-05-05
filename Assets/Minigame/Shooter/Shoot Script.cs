using UnityEngine;
using Valve.VR;
public class Shooter : MonoBehaviour
{
    public SteamVR_Action_Boolean triggerAction;  // Assign this in the inspector
    public SteamVR_Input_Sources handType = SteamVR_Input_Sources.RightHand;  // Or LeftHand\
    public AudioSource gunsound;

    public GameObject projectilePrefab;  // Reference to the projectile prefab
    public Transform shootingPoint;      // Point from where the projectile will be shot (could be a child object)
        // Time between each shot (in seconds)
    public float projectileSpeed = 10f;  // Speed of the projectile

    private float nextFireTime = 0f;     // Time when the next shot can be fired

    void Update()
    {
        if (triggerAction.GetStateDown(handType))
        {
            Debug.Log("Trigger Pressed Down");
            ShootProjectile();
            gunsound.Play();
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