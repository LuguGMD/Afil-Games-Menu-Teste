/// @description



//Checking if can show menu
if(show_menu)
{
	//Checking if menu exist
	if(menu_list[| menu_index] != 0)
	{
		//Checking hovering on buttons
		menu_list[| menu_index].check_hover();
	}
	else
	{
		show_debug_message("Menu not found");
	}
	
	//Getting horizontal and vertical input
	var _h = keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left);
	var _v = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
	
	//Checking if there were any inputs
	if(_h != 0 || _v != 0)
	{
		//Sending input to the menu
		menu_list[| menu_index].change_selected(_h, _v);
	}
	
		
	with(menu_list[| menu_index])
	{
			
		//Going through all buttons
		for(var _i = 0; _i < width; _i++)
		{
			for(var _j = 0; _j < height; _j++)
			{
				//Checking if button exists
				if(buttons_grid[# _i, _j] != 0)
				{		
					//Checking if its the selected button
					if(index_x == _i && index_y == _j)
					{
						if(other.active_menu)
						{
						other.button_hover(_i, _j);
						}
					}
					//Not the selected button
					else
					{
						other.button_no_hover(_i, _j);
					}
					
					//Updating the buttons
					buttons_grid[# _i, _j].update();
					
				}
			}
		}
	}
	#region Interactions
			
	//Checking if this menu can be interacted with
	if(active_menu)
	{
			
		//Runs when button is first selected
		first_select();
			
		//Checking if button exists
		if(selected_button != 0)
		{
			
			//Checking if button was selected
			if(selected_button.pressed() || keyboard_check_pressed(vk_enter))
			{
				button_pressed(selected_button);
			}
		
			//Checking if button was released
			if(selected_button.released() || keyboard_check_released(vk_enter))
			{
				button_released();
			}
			
			//Checking if button is beign hold
			if(selected_button.pressing() || keyboard_check(vk_enter))
			{
				button_pressing();
			}
			
		}
		
	}
		
	#endregion
}
