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
        Vector3 spawnPosition = new Vector3(-23.65999984741211f, -0.4040253162384033f, -0.5642862319946289f);
        GameObject spawnedPrefab = Instantiate(currentObstacle, spawnPosition, Quaternion.identity);
        spawnedPrefab.transform.SetParent(road.transform);
    }

    private void Randomizer()
    {
        index = Random.Range (0, obstacles.Length);
        currentObstacle = obstacles[index];
    }

     //need to add in destroy obstacle function
}
