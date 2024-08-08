#region Buttons

function gui_x(_x){ return device_mouse_x_to_gui(0)}
function gui_y(_y){ return device_mouse_y_to_gui(0)}

function gui_button(_x, _y, _index, _sprite, _txt = "", _h_a = 1, _v_a = 1) constructor 
{
	
	index = _index;
	
	sprite_index = _sprite;
	image_index = 0;
	
	x = _x;
	y = _y;
	
	xstart = _x;
	ystart = _y;
	
	image_xscale = 1;
	image_yscale = 1;
	image_angle = 0;
	image_blend = $ffffff;
	image_alpha = 1;
	
	txt = _txt;
	h_allign = _h_a;
	v_allign = _v_a;
	
	txt_xscale = .8;
	txt_yscale = .8;
	
	buttonReference = 0;
	
	width = sprite_get_width(sprite_index);
	height = sprite_get_height(sprite_index);
	
	l = x - sprite_get_xoffset(sprite_index);
	r = l + width;
	u = y - sprite_get_yoffset(sprite_index);
	d = u + height;
	
	hover = function() 
	{
		return point_in_rectangle(gui_x(mouse_x), gui_y(mouse_y), l, u, r, d)
	}
	pressing = function()
	{
		return (point_in_rectangle(gui_x(mouse_x), gui_y(mouse_y), l, u, r, d) && mouse_check_button(mb_left))
	}
	pressed = function() 
	{ 
		return (point_in_rectangle(gui_x(mouse_x), gui_y(mouse_y), l, u, r, d) && mouse_check_button_pressed(mb_left))
	}
	released = function() 
	{ 
		return (point_in_rectangle(gui_x(mouse_x), gui_y(mouse_y), l, u, r, d) && mouse_check_button_released(mb_left))
	}
	
	draw_ext = function() 
	{
		//Getting the center
		var _x = (l + r) / 2;
		var _y = (u + d) / 2;
		
		//Allingment
		draw_set_halign(h_allign);
		draw_set_valign(v_allign);
		
		draw_set_color(c_black);
		
		draw_text_transformed(_x, _y, txt, txt_xscale, txt_yscale, 0);
		
		draw_set_color(-1);
		
		//Resetting
		draw_set_halign(-1);
		draw_set_valign(-1);
	}
	drop_shadow = function(color, alpha, xoffset, yoffset){
		shadow_alpha = alpha;
		shadow_blend = color;
		shadow_xoffset = xoffset;
		shadow_yoffset = yoffset;
	}
	
	static update = function(){
	
		width = sprite_get_width(sprite_index);
		height = sprite_get_height(sprite_index);
	
		l = x - sprite_get_xoffset(sprite_index);
		r = l + width;
		u = y - sprite_get_yoffset(sprite_index);
		d = u + height;
		
	}
	
	draw = function(){
		
		draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
		draw_ext();
		
		//if global.debug draw_rectangle_color(l,u,r,d,$00ff00,$00ff00,$00ff00,$00ff00,1);
		
	}
}
	
#endregion

#region Menus

function gui_menu(_w, _h) constructor
{	
	
	
	index_x = 0;
	index_y = 0;
	
	width = _w;
	height = _h;
	
	buttons_grid = ds_grid_create(width, height);
	
	add_button = function(_x, _y, _button)
	{
		buttons_grid[# _x, _y] = _button;
	}
	
	
	change_selected = function(_h_input = 0, _v_input = 0)
	{		
		var _x = index_x + _h_input;
		var _y = index_y + _v_input;
		
		if(_x >= width)
		{
			index_x = 0;
		}
		else if(_x < 0)
		{
			index_x = width-1;
			
			while(buttons_grid[# index_x, index_y] == 0)
			{
				index_x--;	
			}
			
		}
		else if(buttons_grid[# _x, index_y] == 0)
		{
			if(_h_input == 1)
			{
				index_x = 0;
			}
			else
			{
				index_x = width-1;
				
				while(buttons_grid[# index_x, index_y] == 0)
				{
					index_x--;	
				}
			}
		}
		else
		{
			index_x = _x;
		}
		
		if(_y >= height)
		{
			index_y = 0;
		}
		else if(_y < 0)
		{
			index_y = height-1;
			
			while(buttons_grid[# index_x, index_y] == 0)
			{
				index_y--;	
			}
			
		}
		else if(buttons_grid[# index_x, _y] == 0)
		{
			
			if(_v_input == 1)
			{
				index_y = 0;
			}
			else
			{
				index_y = height-1;
				
				while(buttons_grid[# index_x, index_y] == 0)
				{
					index_y--;	
				}
			}
		}
		else
		{
			index_y = _y;
		}
	}
	
	choose_selected = function(_x, _y)
	{
		index_x = _x;
		index_y = _y;
	}
	
	get_selected = function()
	{
		return buttons_grid[# index_x, index_y];
	}
	
	check_hover = function()
	{
		for(var _i = 0; _i < width; _i++)
		{
			for(var _j = 0; _j < height; _j++)
			{
				if(buttons_grid[# _i, _j] != 0)
				{
					
					if(buttons_grid[# _i, _j].hover())
					{
						index_x = _i;
						index_y = _j;
					}
				}
			}
		}
		
	}
	
	draw_buttons = function()
	{
		for(var _i = 0; _i < width; _i++)
		{
			for(var _j = 0; _j < height; _j++)
			{
				
				if(buttons_grid[# _i, _j] != 0)
				{		
					buttons_grid[# _i, _j].draw_ext();
				}
			}
		}
	}
	
	destroy = function()
	{
		ds_grid_destroy(buttons_grid);
	}
	
}

#endregion

#region HUDS

function __gameplay_hud() 
{
	//Creating Return Menu
	menu_list[| Menus.Return] = new gui_menu(1, 1);

	#region Return Menu

	var _gap = sprite_get_height(spr_button);
	var _offset = sprite_get_width(spr_button)/2;

	var _x = display_get_gui_width()/2 - _offset;
	var _y = display_get_gui_height()/2;

	//Adding button
	menu_list[| Menus.Return].add_button(0, 0, new gui_button(_x, _y, Buttons.Return, spr_button, "Retornar", 1, 1));

	#endregion

	menu_index = Menus.Return;
}

function __menu_hud()
{
	//Creating Base Menu
	menu_list[| Menus.Base] = new gui_menu(1, 3);
	//Creating Config Menu
	menu_list[| Menus.Config] = new gui_menu(1, 3);

	var _gap = sprite_get_height(spr_button);
	var _offset = sprite_get_width(spr_button)/2;

	#region Base Menu

	//Creating Base Menu buttons
	var _x = display_get_gui_width()/2 - _offset;
	var _y = display_get_gui_height()/3;

	//Adding button
	menu_list[| Menus.Base].add_button(0, 0, new gui_button(_x, _y, Buttons.Play, spr_button, "Jogar", 1, 1));
	_y += _gap;								 
										 
	//Adding button							 
	menu_list[| Menus.Base].add_button(0, 1, new gui_button(_x, _y, Buttons.Config, spr_button, "Configurações", 1, 1));
	_y += _gap;								
										
	//Adding button							
	menu_list[| Menus.Base].add_button(0, 2, new gui_button(_x, _y, Buttons.Exit, spr_button, "Sair", 1, 1));
	_y += _gap;

	#endregion

	#region Config Menu

	_x = display_get_gui_width()/2 - _offset;
	_y = display_get_gui_height()/3;

	//Adding button
	menu_list[| Menus.Config].add_button(0, 0, new gui_button(_x, _y, Buttons.Volume, spr_button, "Volume", 1, 1));
	_y += _gap;

	//Adding button
	menu_list[| Menus.Config].add_button(0, 1, new gui_button(_x, _y, Buttons.FullScreen, spr_button, "Tela Cheia", 1, 1));
	_y += _gap;

	//Adding button
	menu_list[| Menus.Config].add_button(0, 2, new gui_button(_x, _y, Buttons.Back, spr_button, "Voltar", 1, 1));
	_y += _gap;

	#endregion

	menu_index = Menus.Base;

}

function __popUp_hud(_button)
{
	//Creating Return Menu
	menu_list[| Menus.PopUp] = new gui_menu(2, 1);

	#region Return Menu

	var _gap = sprite_get_width(spr_button)/1.5;
	var _offset = sprite_get_width(spr_button)/1.5;

	var _x = display_get_gui_width()/2 - _offset;
	var _y = display_get_gui_height()/2;

	//Adding button
	menu_list[| Menus.PopUp].add_button(0, 0, new gui_button(_x, _y, Buttons.Cancel, spr_button, "Cancelar", 2, 1));
	
	var _b = menu_list[| Menus.PopUp].buttons_grid[# 0 , 0];
	
	_b.buttonReference = _button;
	
	_x += _gap;
	
	//Adding button
	menu_list[| Menus.PopUp].add_button(1, 0, new gui_button(_x, _y, Buttons.Confirm, spr_button, "Confirmar", 1, 1));
	
	_b = menu_list[| Menus.PopUp].buttons_grid[# 1 , 0];
	
	_b.buttonReference = _button;
	
	#endregion

	menu_index = Menus.PopUp;
}

#endregion