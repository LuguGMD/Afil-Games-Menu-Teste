/// @description 

//Going through all menus
for(var _i = 0; _i < ds_list_size(menu_list); _i++)
{
	//Checking if menu exists
	if(menu_list[| _i] != 0)
	{
		//Destroying menu grid
		menu_list[| _i].destroy();
	}
}


