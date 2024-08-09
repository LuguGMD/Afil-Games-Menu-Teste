
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

//Holds if there is an interaction running
is_interacting = false;

enum Menus
{
	Base,
	Config,
	Return,
	PopUp
}

enum Buttons
{
	Play,
	Config,
	Exit,
	Volume,
	FullScreen,
	Back,
	Return,
	Confirm,
	Cancel
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

button_pressed = function(_button, _confirmation = true)
{
	//Playing sound
	scr_play_sfx(SFX.PressButton, false);
	
	switch(_button.index)
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
			//Checking if confirmation is needed
			if(_confirmation)
			{
				create_popUp(_button);
			}
			else
			{
				//Closing the game
				game_end();
			}
			
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
		case Buttons.Confirm:
		{
			if(_button.buttonReference != 0)
			{
				activate_menu();
				button_pressed(_button.buttonReference, false);
				show_menu = false;
				instance_destroy(self);
			}
		}
		break;
		case Buttons.Cancel:
		{
			if(_button.buttonReference != 0)
			{
				activate_menu();
				show_menu = false;
				instance_destroy(self);
			}
		}
		break;
		case Buttons.Volume:
		{
			is_interacting = !is_interacting;
			_button.txt = "Volume";
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

button_interacting = function()
{
	switch(selected_button.index)
	{
		case Buttons.Volume:
		
			selected_button.txt = "< " + string(floor(global.sfxVolume * 100)) + "% >";
			
			//Getting horizontal and vertical input
			var _h = keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left);
			
			if(_h != 0)
			{
				//Changing Sfx volume
				global.sfxVolume += _h/10;
				
				global.sfxVolume = clamp(global.sfxVolume, 0, 1);
				
				scr_play_sfx(snd_hover);
			}
			
			//Checking if clicked outside of the button
			if(mouse_check_button_pressed(mb_left) && !selected_button.pressed())
			{
				//Disabling interaction
				button_pressed(selected_button);
			}
		break;
	}
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

create_popUp = function(_button)
{
	var _hud = instance_create_layer(x, y, layer, obj_hud);
	with(_hud)
	{
		__popUp_hud(_button);
	}
	active_menu = false;
}

#endregion