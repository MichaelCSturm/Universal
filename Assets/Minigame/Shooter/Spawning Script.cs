using UnityEngine;

public class EnemySpawner : MonoBehaviour
{
    public GameObject[] enemyPrefabs;
    public float spawnInterval = 2f;

    public int points;
    public int[] difficultyWC; //win condition
    public int level; //0-2

    void Start()
    {
        InvokeRepeating(nameof(SpawnEnemy), 1f, spawnInterval);
    }

    void SpawnEnemy()
    {
        int randomNumber = Random.Range(0, enemyPrefabs.Length);
        Vector3 spawnPos = new Vector3(Random.Range(-10f, 10f), 0, Random.Range(10f, 20f));
        GameObject enemy = Instantiate(enemyPrefabs[randomNumber], spawnPos, Quaternion.identity);

        Enemy e = enemy.GetComponent<Enemy>();
        
    }
}
