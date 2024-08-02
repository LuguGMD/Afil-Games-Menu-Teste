
show_menu = true;

menu_index = 0;
menu_last_index = 0;

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

//Creating Base Menu
menu_list[| Menus.Base] = new gui_menu(1, 3);
//Creating Config Menu
menu_list[| Menus.Config] = new gui_menu(1, 3);
//Creating Return Menu
menu_list[| Menus.Return] = new gui_menu(1, 1);

var _gap = sprite_get_height(spr_button);
var _offset = sprite_get_width(spr_button)/2;

#region Base Menu

//Creating Base Menu buttons
var _x = room_width/2 - _offset;
var _y = room_height/4;



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

//Creating Config Menu buttons
_x = room_width/2 - _offset;
_y = room_height/4;

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

#region Return Menu

//Creating Config Menu buttons
_x = room_width/2 - _offset;
_y = room_height/4;

//Adding button
menu_list[| Menus.Return].add_button(0, 0, new gui_button(_x, _y, Buttons.Return, spr_button, "Retornar", 1, 1));

#endregion

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

#endregion