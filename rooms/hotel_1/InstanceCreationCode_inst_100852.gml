ini_open(global.saveFile);

if (ini_read_real("Cutscenes", "miltonIntro", false) == true)
{
    instance_destroy();
    instance_destroy(inst_100851);
}

ini_close();

trigger = function()
{
    add_saveVariable("Cutscenes", "miltonIntro", true, global.saveFile);
    push_saveVariables();
    obj_music.pauseMusic = true;
    instance_destroy();
    instance_create_depth(x, y, 0, obj_miltonCutscene);
    var _box = instance_create_depth(x, y, 0, obj_dialog);
    
    with (_box)
    {
        addDialog(spr_dialogportraitPlaceholder2, "dialog_milton1_1_MT");
        addDialog(spr_dialogportraitPlaceholder2, "dialog_milton1_2_MT");
        addDialog(spr_dialogportraitPlaceholder1, "dialog_milton1_1_MR");
        addDialog(spr_dialogportraitPlaceholder2, "dialog_milton1_3_MT");
        addDialog(spr_dialogportraitPlaceholder2, "dialog_milton1_4_MT");
        addDialog(spr_dialogportraitPlaceholder2, "dialog_milton1_5_MT");
        addDialog(spr_dialogportraitPlaceholder2, "dialog_milton1_6_MT");
        addDialog(spr_dialogportraitPlaceholder1, "dialog_milton1_1_MR");
        addDialog(spr_dialogportraitPlaceholder2, "dialog_milton1_7_MT");
        addDialog(spr_dialogportraitPlaceholder2, "dialog_milton1_8_MT");
        addDialog(spr_dialogportraitPlaceholder2, "dialog_milton1_9_MT");
    }
};
