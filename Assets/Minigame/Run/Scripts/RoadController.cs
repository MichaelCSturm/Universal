using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RoadController : MonoBehaviour
{
    public GameObject road;
    private GameObject currentObstacle;
    public float speed = 1f;
    public float spawnInterval = 2f;
    private bool gameOn = true;
    public GameObject[] obstacles;
    int index;


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
        spawnedPrefab.transform.SetParent(road.transform);
    }

    private void Randomizer()
    {
        index = Random.Range(0, obstacles.Length);
        currentObstacle = obstacles[index];
    }
}
