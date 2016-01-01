local skill_battle_cal={
[1] = {id=1,type="1,2,3",a_d="0,1",atker=3,defer=1,atk_inc_s=0,def_inc_s=0,dmg_inc_s=-.25},
[2] = {id=2,type="1,2,3",a_d="0,1",atker=3,defer="2,3,4,5,6,7,8",atk_inc_s=0,def_inc_s=0,dmg_inc_s=.25},
[3] = {id=3,type="1,2,3",a_d="0,1",atker=2,defer="5,6",atk_inc_s=0,def_inc_s=0,dmg_inc_s=.25},
[4] = {id=4,type=1,a_d=0,atker=4,defer="1,2,3,4,5,6,7,8",atk_inc_s=.25,def_inc_s=0,dmg_inc_s=0},
[5] = {id=5,type=3,a_d="0,1",atker=6,defer="1,2,3,4,5,6,7,8",atk_inc_s=.25,def_inc_s=0,dmg_inc_s=0},
[6] = {id=6,type=1,a_d=1,atker=7,defer="1,2,3,4,5,6,7,8",atk_inc_s=.25,def_inc_s=0,dmg_inc_s=0},
[7] = {id=7,type=1,a_d=0,atker="1,2,3,4,5,6,7,8",defer=8,atk_inc_s=0,def_inc_s=.25,dmg_inc_s=0},
[8] = {id=8,type=1,a_d=0,atker="9,10,11",defer="1,2,3,4,5,6,7,8",atk_inc_s=0,def_inc_s=0,dmg_inc_s=2.5},
[9] = {id=9,type=1,a_d=0,atker=12,defer="1,2,3,4,5,6,7,8",atk_inc_s=0,def_inc_s=0,dmg_inc_s=-.99}
}
return skill_battle_cal
