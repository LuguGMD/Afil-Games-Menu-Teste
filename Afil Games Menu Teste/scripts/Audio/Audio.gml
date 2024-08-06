enum SFX
{
	HoverButton,
	PressButton
}

function scr_play_sfx(_sfx, _randPitch = false)
{
	var _pitch = 1;
	
	//Checking if pitch is random
	if(_randPitch)
	{
		_pitch = random_range(0.8, 1.2);
	}
	
	var _sound = undefined;
	
	//Getting sound to play
	switch(_sfx)
	{
		case SFX.HoverButton:
			_sound = undefined;
		break;
		
		case SFX.PressButton:
			_sound = undefined;
		break;
		
		default:
			_sound = undefined;
		break;
	}
	
	//Checking if sound was picked correctly
	if(_sound != undefined)
	{
		//Playing the sound
		audio_play_sound(_sound, 0, false, global.sfxVolume, 0,_pitch);
	}
	else
	{
		show_debug_message("Sound is not defined");
	}
	
}