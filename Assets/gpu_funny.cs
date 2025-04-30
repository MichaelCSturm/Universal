using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class gpu_funny : MonoBehaviour
{
    public int Instances;

    //public Vector3 Position, Rotation, Scale;

    public Mesh mesh;

    public Material[] Materials;

    private List<List<Matrix4x4>> Batches = new List<List<Matrix4x4>>();

    private void RenderBatches()
    {
        /// HEY THIS COULD BE BROKEN IDK foreach (var Batch:List<Matrix4x4> in Batches)
        foreach (var Batch in Batches)
        {
            for (int i = 0; i < mesh.subMeshCount; i++) 
            {
                //print("hey made it here");
                Graphics.DrawMeshInstanced(mesh,i, Materials[i],Batch);
            }
        }
    }
    public void Start()
    {
        int AddedMatricies = 0;

        Batches.Add(new List<Matrix4x4>());
        for (int i =0; i < Instances; i++)
        {
            if (AddedMatricies < 1000)
            {
                Batches[Batches.Count - 1].Add(Matrix4x4.TRS(pos: new Vector3(x: Random.Range(0, 50), y: 0, z: Random.Range(0, 50)), Random.rotation, s: new Vector3(1,1,1)));
                AddedMatricies += 1;
            }
            else
            {
                Batches.Add(new List<Matrix4x4>());
                AddedMatricies = 0;
            }
        }
        //Matrix4x4 matrix = Matrix4x4.TRS(Position, Quaternion.Euler(Rotation), Scale);
    }
    public void Update()
    {
        RenderBatches();
    }
}
