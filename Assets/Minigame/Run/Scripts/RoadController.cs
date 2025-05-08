using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RoadController : MonoBehaviour
{
    public GameObject Hearts;
    public GameObject road;
    private GameObject currentObstacle;
    public float speed = 1f;
    public float spawnInterval = 2f;
    private bool gameOn = true;
    public GameObject[] obstacles;
    int index;
    public Animator animator;
    public GameObject Master;
    //public float speed;
    Master MainMaster;
    private int levelToLoad;

    //// Start is called before the first frame update
    //void Start()
    //{
    //    StartCoroutine(RoadSpeed());
    //}

    //// Update is called once per frame
    //void Update()
    //{

    //}

    //private IEnumerator RoadSpeed()
    //{
    //    float spawnTimer = 0f;
    //    while (gameOn)
    //    {
    //        float step = speed * Time.deltaTime;
    //        road.transform.position = new Vector3(road.transform.position.x + step, road.transform.position.y, road.transform.position.z);
    //        spawnTimer += Time.deltaTime;

    //        if (spawnTimer >= spawnInterval)
    //        {
    //            SpawnObstacle();
    //            spawnTimer = 0f;
    //        }
    //        yield return null;
    //    }
    //}

    //private void SpawnObstacle()
    //{
    //    Randomizer();
    //    Vector3 spawnPosition = new Vector3(0f, 0f, 0f);
    //    GameObject spawnedPrefab = Instantiate(currentObstacle, spawnPosition, Quaternion.identity);
    //    spawnedPrefab.transform.SetParent(road.transform);
    //}

    //private void Randomizer()
    //{
    //    index = Random.Range (0, obstacles.Length);
    //    currentObstacle = obstacles[index];
    //}
    public float speedIncreaseRate = 0.1f; // Rate at which the road speed increases
    public float spawnDecreaseRate = 0.05f; // Rate at which spawn interval decreases (obstacles spawn more frequently)

    // Start is called before the first frame update
    void Start()
    {
        StartCoroutine(RoadSpeed());

        GameObject ObjectMaster = Instantiate(Master, new Vector3(0, 0, 0), Quaternion.identity);
        MainMaster = ObjectMaster.GetComponent<Master>();
        //MainMaster = new Master();
        if (animator != null)
        {
            MainMaster.animator = animator;
            MainMaster.levelToLoad = levelToLoad;
        }
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
    }

    // Update is called once per frame
    void Update()
    {

    }

    private IEnumerator RoadSpeed()
    {
        float spawnTimer = 0f;
        while (gameOn)
        {
            // Increase the speed over time
            speed += speedIncreaseRate * Time.deltaTime;

            // Increase spawn rate (obstacle spawn more often)
            spawnInterval = Mathf.Max(0.5f, spawnInterval - spawnDecreaseRate * Time.deltaTime); // Set a minimum spawn interval to prevent it from getting too fast

            // Move the road
            float step = speed * Time.deltaTime;
            road.transform.position = new Vector3(road.transform.position.x + step, road.transform.position.y, road.transform.position.z);

            spawnTimer += Time.deltaTime;

            if (spawnTimer >= spawnInterval)
            {
                SpawnObstacle();
                spawnTimer = 0f;
            }

            yield return null;
        }
    }

    private void SpawnObstacle()
    {
        Randomizer();
        Vector3 spawnPosition = new Vector3(0f, 0f, 0f);
        GameObject spawnedPrefab = Instantiate(currentObstacle, spawnPosition, Quaternion.identity);
        RunController script = spawnedPrefab.GetComponent<RunController>();
        //script.MainMaster = MainMaster;
        // Run
        //script.Master = Master;
        script.animator = animator;
        spawnedPrefab.transform.SetParent(road.transform);
    }

    private void Randomizer()
    {
        index = Random.Range(0, obstacles.Length);
        currentObstacle = obstacles[index];
    }
}
