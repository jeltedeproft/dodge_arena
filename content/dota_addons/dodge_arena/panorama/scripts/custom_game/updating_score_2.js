"use strict";

function OnKillEvent( event )
{
	var teamPanel = $.GetContextPanel();
	var teamId = $.GetContextPanel().GetAttributeInt( "team_id", -1 );
	if ( teamId !== event.team_id )
		return;
	var panel2 = $('#TeamScorePanel');
	panel2.text = event.team_kills.toString();
}


(function()
{
//	$.Msg( "overthrow_scoreboard_team_overlay" );

	var teamPanel = $.GetContextPanel();
	GameEvents.Subscribe( "kill_event", OnKillEvent );
})();
