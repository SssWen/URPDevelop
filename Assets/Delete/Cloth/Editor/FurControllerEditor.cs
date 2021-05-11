// using UnityEngine;
// using UnityEditor;

// [CustomEditor(typeof(FurController))]
// public class FurControllerEditor : Editor
// {
//     public override void OnInspectorGUI()
//     {
//         DrawDefaultInspector();

//         FurController fluffController = (FurController)target; 
//         if(!Application.isPlaying)
//         {
//             if (GUILayout.Button("查看修改"))
//             {
//                 fluffController.UpdateFurEditor();
//             }
//         }
//         if (GUILayout.Button("保存预设"))
//         {
//             fluffController.SaveFluff();
//         }
//     }
// }
