using UnityEngine;

public class EnemySpawner : MonoBehaviour
{
    public GameObject[] enemyPrefabs;
    public float spawnInterval = 2f;

    public int points; // points added when enemy dies
    public int difficultyWC; //amount of points needed to win
    public int level; //0-2
    public GameObject Master;
    public Animator animator;
    public float speed;
    Master MainMaster;
    private int levelToLoad;
    public int NumberOfEnemysToDestroy;
    public GameObject selfManager;
    public int destroyedEnemys = 0;
    


    void Start()
    {
        GameObject ObjectMaster = Instantiate(Master, new Vector3(0, 0, 0), Quaternion.identity);
        MainMaster = ObjectMaster.GetComponent<Master>();
        // The reason it has to be an object inside of the actual scene is because unity likes to not place nice with calling Update() despite being insiated
        if (animator != null)
        {
            MainMaster.animator = animator;
            MainMaster.levelToLoad = levelToLoad;
        }
        InvokeRepeating(nameof(SpawnEnemy), 1f, spawnInterval);
    }
    public void Update()
    {
        if (points >= difficultyWC)// WIN CON RIGHT HERE
        {
            MainMaster.FadeToLevel(2);
        }
    }
    public void OnFadeComplete() // The animation will freak out if this is not here.
    {
        MainMaster.OnFadeComplete();
    }
    public void destroyEnemy()
    {
        destroyedEnemys = destroyedEnemys + 1;
        print(MainMaster.TimeManager().ToString());
    }

    void SpawnEnemy()
    {
        int randomNumber = Random.Range(0, enemyPrefabs.Length);
        Vector3 spawnPos = new Vector3(Random.Range(-10f, 10f), 0, Random.Range(10f, 20f));
        GameObject enemy = Instantiate(enemyPrefabs[randomNumber], spawnPos, Quaternion.identity);
        enemy.GetComponent<Enemy>().manger = selfManager;
        Enemy e = enemy.GetComponent<Enemy>();
        e.manger = selfManager;

    }
}