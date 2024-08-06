/// @description 


if(show_menu)
{
	draw_set_font(fnt_text);
	menu_list[| menu_index].draw_buttons();
	draw_set_font(-1);
}