
//Holds if the buttons are to be shown
show_menu = true;
//Holds if the buttons are to be interacted
active_menu = true;

//Hold the index of the menu to show
menu_index = 0;
//Holds the index of the menu last shown
menu_last_index = 0;

//Hold a reference to the selected button
selected_button = 0;

enum Menus
{
	Base,
	Config,
	Return
}

enum Buttons
{
	Play,
	Config,
	Exit,
	Volume,
	FullScreen,
	Back,
	Return
}

//Creating a list to hold all menus
menu_list = ds_list_create();

#region Functions

change_menu = function(_new_menu)
{
	//Resetting position of the menu
	menu_list[| menu_index].choose_selected(0,0);
	
	//Storingg last menu index
	menu_last_index = menu_index;
	//Changing current menu
	menu_index = _new_menu;
}

first_select = function()
{
	with(menu_list[| menu_index])
	{
		//Checking if selected button just changed
		if(other.selected_button != buttons_grid[# index_x, index_y])
		{
			
			//Playing sound
			scr_play_sfx(SFX.HoverButton, false);
			
			//Changing to the new button
			other.selected_button = buttons_grid[# index_x, index_y];
		}
	}
}

button_hover = function(_x, _y)
{
	with(menu_list[| menu_index])
	{
		//Streching button
		buttons_grid[# _x, _y].txt_xscale = lerp(buttons_grid[# _x, _y].txt_xscale, 1, .2);
		buttons_grid[# _x, _y].txt_yscale = buttons_grid[# _x, _y].txt_xscale;
	}
}

button_no_hover = function(_x, _y)
{
	with(menu_list[| menu_index])
	{
		//Unstretching button
		buttons_grid[# _x, _y].txt_xscale = lerp(buttons_grid[# _x, _y].txt_xscale, .8, .2);
		buttons_grid[# _x, _y].txt_yscale = buttons_grid[# _x, _y].txt_xscale;
	}
}

button_pressed = function()
{
	//Playing sound
	scr_play_sfx(SFX.PressButton, false);
	
	switch(selected_button.index)
	{
		case Buttons.Play:
		{
			//Going to the gameplay room
			room_goto(rm_gameplay);
		}
		break;
		case Buttons.Config:
		{
			//Changing to the config menu
			other.change_menu(Menus.Config);
		}
		break;
		case Buttons.Exit:
		{
			//Closing the game
			game_end();
		}
		break;
		case Buttons.Back:
		{
			//Changing to last open menu
			other.change_menu(other.menu_last_index);
		}
		break;
		case Buttons.FullScreen:
		{
			//Changing fullscreen mode
			window_set_fullscreen(!window_get_fullscreen());
		}
		break;
		case Buttons.Return:
		{
			//Going to the menu room
			room_goto(rm_menu);
		}
		break;
	}
}

button_released = function()
{
	
}

button_pressing = function()
{
	
}

//Activates all shown menus
activate_menu = function()
{
	//Going through all huds
	for(var _i = 0; _i < instance_number(obj_hud); _i++)
	{
		//Getting a reference to the hud
		var _hud = instance_find(obj_hud, _i);
		//Checking if it's not self
		if(_hud.id != id)
		{
			//Checking if hud is beign shown
			if(_hud.show_menu)
			{
				//Activating menu
				_hud.active_menu = true;
			}
		}
	}
}


#endregion