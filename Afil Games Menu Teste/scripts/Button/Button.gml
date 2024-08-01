function gui_x(_x){ return device_mouse_x_to_gui(0)}
function gui_y(_y){ return device_mouse_y_to_gui(0)}

function gui_button(_x, _y, _sprite, _txt = "") constructor {
	
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
	
	shadow_alpha = 0;
	shadow_blend = $000000;
	shadow_xoffset = 0;
	shadow_yoffset = 0;
	
	width = sprite_get_width(sprite_index);
	height = sprite_get_height(sprite_index);
	
	l = x - sprite_get_xoffset(sprite_index);
	r = l + width;
	u = y - sprite_get_yoffset(sprite_index);
	d = u + height;
	
	hover = function() { return point_in_rectangle(gui_x(mouse_x), gui_y(mouse_y), l, u, r, d)}
	pressing = function() { return (point_in_rectangle(gui_x(mouse_x), gui_y(mouse_y), l, u, r, d) and mouse_check_button(mb_left))}
	pressed = function() { return (point_in_rectangle(gui_x(mouse_x), gui_y(mouse_y), l, u, r, d) and mouse_check_button_pressed(mb_left))}
	released = function() { return (point_in_rectangle(gui_x(mouse_x), gui_y(mouse_y), l, u, r, d) and mouse_check_button_released(mb_left))}
	
	draw_ext = function() 
	{
		//Getting the center
		var _x = (l + r) / 2;
		var _y = (u + d) / 2;
		
		//Allingment
		draw_set_halign(1);
		draw_set_valign(1);
		
		draw_set_color(c_black);
		
		draw_text(_x, _y, txt);
		
		draw_set_color(-1);
		
		//Resseting
		draw_set_halign(1);
		draw_set_valign(1);
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
		
		#region SHADOW
			//draw_set_alpha(shadow_alpha);
			//gpu_set_fog(1, shadow_blend, 1, 0);
			//draw_sprite_ext(sprite_index, image_index, x + shadow_xoffset, y + shadow_yoffset, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
			//gpu_set_fog(0, $ffffff, 0, 1);
			//draw_set_alpha(1);
			//draw_set_color(#ffffff);
		#endregion
		
		draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
		draw_ext();
		
		//if global.debug draw_rectangle_color(l,u,r,d,$00ff00,$00ff00,$00ff00,$00ff00,1);
		
	}
}