/// @description




if(show_menu)
{
	menu_list[| menu_index].check_hover();
	
	var _h = keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left);
	var _v = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
	
	if(_h != 0 || _v != 0)
	{
		menu_list[| menu_index].change_selected(_h, _v);
	}
	
	with(menu_list[| menu_index])
	{
	
		for(var _i = 0; _i < width; _i++)
		{
			for(var _j = 0; _j < height; _j++)
			{
				if(buttons_grid[# _i, _j] != 0)
				{		
					if(index_x == _i && index_y == _j)
					{
						buttons_grid[# _i, _j].txt_xscale = lerp(buttons_grid[# _i, _j].txt_xscale, 1, .2);
						buttons_grid[# _i, _j].txt_yscale = buttons_grid[# _i, _j].txt_xscale;
					}
					else
					{
						buttons_grid[# _i, _j].txt_xscale = lerp(buttons_grid[# _i, _j].txt_xscale, .8, .2);
						buttons_grid[# _i, _j].txt_yscale = buttons_grid[# _i, _j].txt_xscale;
					}
					
					buttons_grid[# _i, _j].update();
					
				}
			}
		}
		
		#region Interactions
		
		var _button = buttons_grid[# index_x, index_y];
		
		if(_button.pressed() || keyboard_check_pressed(vk_enter))
		{
			switch(_button.index)
			{
				case Buttons.Play:
					room_goto(rm_gameplay);
					other.change_menu(Menus.Return);
				break;
				case Buttons.Config:
					other.change_menu(Menus.Config);
				break;
				case Buttons.Exit:
					game_end();
				break;
				case Buttons.Back:
					//Changing to last open menu
					other.change_menu(other.menu_last_index);
				break;
				case Buttons.FullScreen:
					//Changing fullscreen mode
					window_set_fullscreen(!window_get_fullscreen());
				break;
				case Buttons.Return:
					room_goto(rm_menu);
					other.change_menu(Menus.Base);
				break;
			}
		}
		
		if(_button.released() || keyboard_check_released(vk_enter))
		{
			
		}
		
		if(_button.pressing() || keyboard_check(vk_enter))
		{
			
		}
		
		#endregion
		
	}
}
