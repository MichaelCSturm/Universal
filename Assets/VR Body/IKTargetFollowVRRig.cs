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
}

public class IKTargetFollowVRRig : MonoBehaviour
{
    [Range(0,1)]
    public float turnSmoothness = 0.1f;
    public VRMap head;
    public VRMap leftHand;
    public VRMap rightHand;

    public VRMap waist;
    public VRMap leftLeg;
    public VRMap rightLeg;

    public Vector3 waistBodyPositionOffset;
    public float headBodyYawOffset;

    // Update is called once per frame
    void LateUpdate()
    {
        transform.position = waist.ikTarget.position + waistBodyPositionOffset;
        float yaw = waist.vrTarget.eulerAngles.y;
        transform.rotation = Quaternion.Lerp(transform.rotation,Quaternion.Euler(transform.eulerAngles.x, yaw, transform.eulerAngles.z),turnSmoothness);

        head.Map();
        leftHand.Map();
        rightHand.Map();

        waist.Map();
        leftLeg.Map();
        rightLeg.Map();
    }

    private void Start()
    {
//UpdateHeight();
    }

    void UpdateHeight()
    {
        float defaultHeight = 1.7f;
        Vector3 footPos = (leftLeg.vrTarget.position + rightLeg.vrTarget.position) * 0.5f;
        float currentHeight = Mathf.Abs(head.vrTarget.position.y - footPos.y);
        float scaleRatio = currentHeight / defaultHeight;
        transform.localScale = Vector3.one * scaleRatio;
    }
}
