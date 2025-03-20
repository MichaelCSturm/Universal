using UnityEngine;

[System.Serializable]
public class VRMap
{
    public Transform vrTarget;
    public Transform ikTarget;
    public Vector3 trackingPositionOffset;
    public Vector3 trackingRotationOffset;

    
    public void Map()
    {
        ikTarget.position = vrTarget.TransformPoint(trackingPositionOffset);
        ikTarget.rotation = vrTarget.rotation * Quaternion.Euler(trackingRotationOffset);
    }
    /*public void Maphead()
    {
        ikTarget.position = vrTarget.TransformPoint(trackingPositionOffset) + BodyPositionOffset;
        ikTarget.rotation = vrTarget.rotation * Quaternion.Euler(trackingRotationOffset);
    }*/
}

public class IKTargetFollowVRRig : MonoBehaviour
{
    [Range(0,1)]
    public float turnSmoothness = 0.1f;
    public VRMap head;
    public VRMap leftHand;
    public VRMap rightHand;
    public VRMap leftLeg;
    public VRMap rightLeg;
    public VRMap waist;

    public Vector3 waistBodyPositionOffset;

    //public float headBodyYawOffset;
    // Update is called once per frame
    void LateUpdate()
    {
        transform.position = waist.ikTarget.position + waistBodyPositionOffset;

        float yaw = waist.vrTarget.eulerAngles.y;
        transform.rotation = Quaternion.Lerp(transform.rotation,Quaternion.Euler(transform.eulerAngles.x, yaw, transform.eulerAngles.z),turnSmoothness);

        head.Map();
        leftHand.Map();
        rightHand.Map();
        leftLeg.Map();
        rightLeg.Map();
        waist.Map();
    }
}
