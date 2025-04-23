using UnityEngine;

public class Enemy : MonoBehaviour
{
    public enum EnemyType { Basic, Tough, FinalBoss }
    public EnemyType type = EnemyType.Basic;

    public float speed = 3f;
    public int health = 1;

    private Transform player;
    private float timeOffset;
    public GameObject manger;

    void Start()
    {
        player = GameObject.FindGameObjectWithTag("Player").transform;
        timeOffset = Random.Range(0f, 100f);

        switch (type)
        {
            case EnemyType.Tough:
                health = 3;
                break;
            case EnemyType.FinalBoss:
                health = 10;
                break;
            default:
                health = 1;
                break;
        }
    }

    void Update()
    {
        if (!player) return;

        switch (type)
        {
            case EnemyType.Basic:
                MoveBasic();
                break;
            case EnemyType.Tough:
                MoveTough();
                break;
            case EnemyType.FinalBoss:
                MoveFinalBoss();
                break;
        }
    }

    void MoveBasic()
    {
        Vector3 direction = (player.position - transform.position).normalized;
        Vector3 bounce = new Vector3(0f, Mathf.Sin(Time.time * 2f + timeOffset), 0f);
        transform.position += (direction + bounce * 0.2f) * speed * Time.deltaTime;
    }

    void MoveTough()
    {
        Vector3 forward = (player.position - transform.position).normalized;
        Vector3 zigzag = new Vector3(Mathf.Sin(Time.time * 5f + timeOffset) * 2f, 0f, 0f);
        transform.position += (forward + zigzag).normalized * speed * Time.deltaTime;
    }

    void MoveFinalBoss()
    {
        Vector3 waveMotion = new Vector3(0f, Mathf.Sin(Time.time * 3f) * 1.5f, Mathf.Cos(Time.time * 2f) * 1.5f);
        transform.position += waveMotion * speed * 0.25f * Time.deltaTime;
    }

    void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("projectile"))
        {
            health--;
            if (health <= 0)
            {
                //manger.GetComponent<SpawningScript>
                manger.GetComponent<EnemySpawner>().destroyEnemy();
                Destroy(gameObject);
            }
        }
    }
}