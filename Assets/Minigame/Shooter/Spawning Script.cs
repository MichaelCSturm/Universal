using UnityEngine;
using static Enemy;

public class EnemySpawner : MonoBehaviour
{
    private GameObject gatToPutAway;
    public GameObject HealthHolder;
    private GameObject HealthHolderToPutAway;
    public GameObject Gat;
    public GameObject Player;
    public GameObject Hearts;
    public GameObject[] enemyPrefabs;
    public float spawnInterval = 2f;

    public int points; // points added when enemy dies
    public int[] difficultyWC; //amount of points needed to win
    public int level; //0-2
    public GameObject Master;
    public Animator animator;
    public float speed;
    Master MainMaster;
    private int levelToLoad;
    public int PointsToWin;
    public GameObject selfManager;
    public int destroyedEnemys = 0;
    private bool startLoadingLevel = true;
    public int myLevel;
  

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
        int health = MainMaster.ReturnHealth();
        HeartController HScript = Hearts.GetComponent<HeartController>();
        if (health == 4)
        {
            HScript.FourLife();
        }
        if (health == 3)
        {
            HScript.ThreeLife();
        }
        if (health == 2)
        {
            HScript.TwoLife();
        }
        if (health == 1)
        {
            HScript.OneLife();
        }
        MainMaster.Player = Player;
        print(health.ToString());
        GameObject rightHand = GameObject.FindGameObjectWithTag("Right Hand Trigger");
        gatToPutAway= Instantiate(Gat, rightHand.transform);
        GameObject hip = GameObject.FindGameObjectWithTag("Hip");
        HealthHolderToPutAway = Instantiate(HealthHolder, hip.transform);
        HealthHolderToPutAway.GetComponent<playerHealth>().spawningScript = this;
        //playerHealth.spawningScript
    }
    public void Update()
    {
        if (points >= PointsToWin && startLoadingLevel)// WIN CON RIGHT HERE
        {
            print(" AY WE WINNING SWITCHING TO THE NEXT SCENE");
            Destroy(HealthHolderToPutAway);
            Destroy(gatToPutAway);
            MainMaster.RandomLevel(myLevel);
            startLoadingLevel = false;
        }
    }
    public void GameOver()
    {
        Destroy(HealthHolderToPutAway);
        Destroy(gatToPutAway);
        MainMaster.FailLevel(myLevel);
    }
    public void OnFadeComplete() // The animation will freak out if this is not here.
    {
        MainMaster.OnFadeComplete();
    }
    public void destroyEnemy(EnemyType type)
    {
        // Guide to update the global score:
        //
        // Call MainMaster.AddToScore(1);
        //
        // Do not access the singleton itself utilize the MainMaster
        switch (type)
        {
            case EnemyType.Tough:
                points = points + 15;
                MainMaster.AddToScore(15);
                break;
            case EnemyType.FinalBoss:
                points = points + 40;
                MainMaster.AddToScore(40);
                break;
            default:
                points = points + 1;
                MainMaster.AddToScore(1);
                break;
        }
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