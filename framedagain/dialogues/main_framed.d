/////////////////////////////////////////////////////////////
// Dialogue inside Chateau Irenicus about the poster(s)    //
// Kept separate so it can be imported into Transitions    //
// This is the only bit that might be used for Transitions //
// Compiled via main_framed.tpa using main_framed.tra      //
/////////////////////////////////////////////////////////////

APPEND %IMOEN_JOINED%
	// Left before Skie dead via item
	IF ~Global("#L_PosterTalk","GLOBAL",1) Global("bd_player_exiled","GLOBAL",2)~ BEGIN SKIE_DEAD_IMOEN
		SAY @3000 /* ~What is that?  Skie Silvershield is dead?~ */
		= @3025	/* ~Did you see this, <CHARNAME>?  Listen!~ */
		= #%SCROLL_READ1%
		= @3026	/* ~And that's not all!~ */
		= #%SCROLL_READ3%
		+ ~!IsValidForPartyDialogue("JAHEIRA") !IsValidForPartyDialogue("MINSC")~ + @3001 /* ~I guess so.  And for some reason I am wanted for it.~ */ + FRAMED_AGAIN_IMOEN
		+ ~!IsValidForPartyDialogue("JAHEIRA") IsValidForPartyDialogue("MINSC")~ + @3001 /* ~I guess so.  And for some reason I am wanted for it.~ */ EXTERN ~MINSCJ~ FRAMED_AGAIN_MINSC
		+ ~IsValidForPartyDialogue("JAHEIRA")~ + @3001 /* ~I guess so.  And for some reason I am wanted for it.~ */ EXTERN ~JAHEIRAJ~ FRAMED_AGAIN_JAHEIRA
	END

	// BG2 or Exiled, i.e. Entar is the only duke going after PC 
	IF ~Global("#L_PosterTalk","GLOBAL",1) OR(2) Global("bd_player_exiled","GLOBAL",1) Global("#L_EET","GLOBAL",0)~ BEGIN ENTAR_BOUNTY_IMOEN
		SAY @3006 /* ~What is that?  Duke Entar put a price on your head?~ */
		= @3025	/* ~Did you see this, <CHARNAME>?  Listen!~ */
		= #%SCROLL_READ3%
		+ ~!IsValidForPartyDialogue("JAHEIRA")~ + @3008 /* ~A rather high price, actually. This is becoming an annoyingly regular occurance.~ */ + POOR_ENTAR_IMOEN
		+ ~IsValidForPartyDialogue("JAHEIRA")~ + @3008 /* ~A rather high price, actually. This is becoming an annoyingly regular occurance.~ */ EXTERN ~JAHEIRAJ~ POOR_ENTAR_JAHEIRA
	END

	// Escaped after found guilty, all dukes are after PC
	IF ~Global("#L_PosterTalk","GLOBAL",1) Global("bd_player_exiled","GLOBAL",0) Global("#L_EET","GLOBAL",1)~ BEGIN DUKES_BOUNTY_IMOEN
		SAY @3007 /* ~What is that?  The Dukes of Baldur's Gate have put a price on your head?~ */
		= @3025	/* ~Did you see this, <CHARNAME>?  Listen!~ */
		= #%SCROLL_READ2%
		++ @3008 /* ~A rather high price, actually. This is becoming an annoyingly regular occurance.~ */ + AT_LEAST_KNOW_IMOEN
	END

	// Left before Skie dead via item - only NPC in party
	IF ~~ BEGIN	FRAMED_AGAIN_IMOEN
		SAY @3002 /* ~Don't tell me you've been framed again!~ */
		++ @3003 /* ~It would appear so.  This is becoming an annoyingly regular occurance.~ */ + SORRY_SKIE_IMOEN
	END

	// Left before Skie dead
	IF ~~ BEGIN	SORRY_SKIE_IMOEN
		SAY @3004 /* ~I am sorry to hear about Skie though.~ */
		+ ~!IsValidForPartyDialogue("JAHEIRA")~ + @3005 /* ~Yeah, me too.~ */ + POOR_ENTAR_IMOEN
		+ ~IsValidForPartyDialogue("JAHEIRA")~ + @3005 /* ~Yeah, me too.~ */ EXTERN ~JAHEIRAJ~ POOR_ENTAR_JAHEIRA
	END

	// Entar put out bounty - Jaheira not available
	IF ~~ BEGIN	POOR_ENTAR_IMOEN
		SAY @3011 /* ~Duke Entar must be about out of his mind, losing both of his children.~ */
		++ @3012 /* ~Yeah, I'd feel a lot sorrier for him if he hadn't put a 10,000 gold reward on my head.~ */ + AT_LEAST_KNOW_IMOEN
	END

	// All roads intersect here by default
	IF ~~ BEGIN AT_LEAST_KNOW_IMOEN
		SAY @3009 /* ~At least this time you know who wants you dead, and why.~ */
		+ ~!Global("bd_player_exiled","GLOBAL",2) !IsValidForPartyDialogue("JAHEIRA")~ + @3010 /* ~Oddly enough, that doesn't feel like much of an improvement.~ */ + WHERE_DAGGER_IMOEN
		+ ~!Global("bd_player_exiled","GLOBAL",2) IsValidForPartyDialogue("JAHEIRA")~ + @3010 /* ~Oddly enough, that doesn't feel like much of an improvement.~ */ EXTERN ~JAHEIRAJ~ WHERE_DAGGER_JAHERIA
		+ ~Global("bd_player_exiled","GLOBAL",2) !IsValidForPartyDialogue("JAHEIRA")~ + @3010 /* ~Oddly enough, that doesn't feel like much of an improvement.~ */ + WHAT_DAGGER_IMOEN
		+ ~Global("bd_player_exiled","GLOBAL",2) IsValidForPartyDialogue("JAHEIRA")~ + @3010 /* ~Oddly enough, that doesn't feel like much of an improvement.~ */ EXTERN ~JAHEIRAJ~ WHAT_DAGGER_JAHERIA
	END

	// Left before Skie dead, Jaheira not available
	IF ~~ BEGIN WHAT_DAGGER_IMOEN
		SAY @3013 /* ~What's this about a soul dagger?~ */
		+ ~!IsValidForPartyDialogue("MINSC")~ + @3014 /* ~Your guess is as good as mine.~ */ + WHY_YOU_IMOEN
		+ ~IsValidForPartyDialogue("MINSC")~ + @3014 /* ~Your guess is as good as mine.~ */ EXTERN ~MINSCJ~ WHY_YOU_MINSC
	END

	// Left before Skie dead, Minsc not available
	IF ~~ BEGIN WHY_YOU_IMOEN
		SAY @3015 /* ~I wonder why they think you did it.~ */
		+ ~!IsValidForPartyDialogue("JAHEIRA")~ + @3016 /* ~I don't know.  Dopplegangers maybe?~ */ + LETS_GO_IMOEN
		+ ~IsValidForPartyDialogue("JAHEIRA")~ + @3016 /* ~I don't know.  Dopplegangers maybe?~ */ EXTERN ~JAHEIRAJ~ LETS_GO_JAHEIRA
	END

	IF ~~ BEGIN	LETS_GO_IMOEN
		SAY @3017 /* ~Hmm, could be.  But let's worry about this once we're out of here.~ */
		IF ~~ DO ~SetGlobal("#L_PosterTalk","GLOBAL",9)~ EXIT
	END

	// Left after trial, Jaheira not available
	IF ~~ BEGIN WHERE_DAGGER_IMOEN
		SAY @3018 /* ~I see they still haven't found that soul dagger.~ */
		IF ~PartyHasItem("#LScr02") !IsValidForPartyDialogue("MINSC")~ + DUKES_DAGGER_LEGS_IMOEN
		IF ~PartyHasItem("#LScr02") IsValidForPartyDialogue("MINSC")~ EXTERN ~MINSCJ~ DUKES_DAGGER_LEGS_MINSC
		IF ~PartyHasItem("#LScr03") !IsValidForPartyDialogue("MINSC")~ + ENTAR_DAGGER_LEGS_IMOEN
		IF ~PartyHasItem("#LScr03") IsValidForPartyDialogue("MINSC")~ EXTERN ~MINSCJ~ ENTAR_DAGGER_LEGS_MINSC
	END

	// Exiled after trial, Minsc not available
	IF ~~ BEGIN	ENTAR_DAGGER_LEGS_IMOEN
		SAY @3019 /* ~What does he think?  The dagger sprouted legs and walked out on it's own?  It wasn't to be found in the entire area.~ */
		+ ~!IsValidForPartyDialogue("JAHEIRA")~ + @3022 /* ~Who can say what they think.  But let's worry about this once we're out of here.~ */ + RIGHT_IMOEN
		+ ~IsValidForPartyDialogue("JAHEIRA")~ + @3022 /* ~Who can say what they think.  But let's worry about this once we're out of here.~ */ EXTERN ~JAHEIRAJ~ RIGHT_JAHEIRA
	END

	// Escaped after trial, Minsc not available
	IF ~~ BEGIN	DUKES_DAGGER_LEGS_IMOEN
		SAY @3020 /* ~What do they think?  The dagger sprouted legs and walked out on it's own?  It wasn't to be found in the entire area.~ */
		+ ~!IsValidForPartyDialogue("JAHEIRA")~ + @3022 /* ~Who can say what they think.  But let's worry about this once we're out of here.~ */ + RIGHT_IMOEN
		+ ~IsValidForPartyDialogue("JAHEIRA")~ + @3022 /* ~Who can say what they think.  But let's worry about this once we're out of here.~ */ EXTERN ~JAHEIRAJ~ RIGHT_JAHEIRA
	END

	IF ~~ BEGIN RIGHT_IMOEN
		SAY @3023 /* ~Right!  First things first.~ */
		IF ~~ DO ~SetGlobal("#L_PosterTalk","GLOBAL",9)~ EXIT
	END
END

APPEND JAHEIRAJ
	// Left before Skie dead via item, Imoen not available
	IF ~Global("#L_PosterTalk","GLOBAL",2) Global("bd_player_exiled","GLOBAL",2)~ BEGIN SKIE_DEAD_JAHEIRA
		SAY @3000 /* ~What is that?  Skie Silvershield is dead?~ */
		= @3025	/* ~Did you see this, <CHARNAME>?  Listen!~ */
		= #%SCROLL_READ1%
		= @3026	/* ~And that's not all!~ */
		= #%SCROLL_READ3%
		++ @3001 /* ~I guess so.  And for some reason I am wanted for it.~ */ + FRAMED_AGAIN_JAHEIRA
	END

	// BG2 or Exiled, i.e. Entar is the only duke going after PC, Imoen not available
	IF ~Global("#L_PosterTalk","GLOBAL",2) OR(2) Global("bd_player_exiled","GLOBAL",1) Global("#L_EET","GLOBAL",0)~ BEGIN ENTAR_BOUNTY_JAHEIRA
		SAY @3006 /* ~What is that?  Duke Entar put a price on your head?~ */
		= @3025	/* ~Did you see this, <CHARNAME>?  Listen!~ */
		= #%SCROLL_READ3%
		++ @3008 /* ~A rather high price, actually. This is becoming an annoyingly regular occurance.~ */ + POOR_ENTAR_JAHEIRA
	END

	// Escaped after found guilty, all dukes are after PC, Imoen not available
	IF ~Global("#L_PosterTalk","GLOBAL",1) Global("bd_player_exiled","GLOBAL",0) Global("#L_EET","GLOBAL",1)~ BEGIN DUKES_BOUNTY_IMOEN
		SAY @3007 /* ~What is that?  The Dukes of Baldur's Gate have put a price on your head?~ */
		= @3025	/* ~Did you see this, <CHARNAME>?  Listen!~ */
		= #%SCROLL_READ2%
		+ ~!IsValidForPartyDialogue("MINSC")~ + @3008 /* ~A rather high price, actually. This is becoming an annoyingly regular occurance.~ */ + AT_LEAST_KNOW_JAHEIRA
		+ ~IsValidForPartyDialogue("MINSC")~ + @3008 /* ~A rather high price, actually. This is becoming an annoyingly regular occurance.~ */ EXTERN ~MINSCJ~ AT_LEAST_KNOW_MINSC
	END

	// Left before Skie dead
	IF ~~ BEGIN	FRAMED_AGAIN_JAHEIRA
		SAY @3002 /* ~Don't tell me you've been framed again!~ */
		+ ~!IsValidForPartyDialogue("IMOEN2")~ + @3003 /* ~It would appear so.  This is becoming an annoyingly regular occurance.~ */ + SORRY_SKIE_JAHEIRA
		+ ~IsValidForPartyDialogue("IMOEN2")~ + @3003 /* ~It would appear so.  This is becoming an annoyingly regular occurance.~ */ EXTERN ~%IMOEN_JOINED%~ SORRY_SKIE_IMOEN
	END

	// Left before Skie dead via item, Imoen not available
	IF ~~ BEGIN	SORRY_SKIE_JAHEIRA
		SAY @3004 /* ~I am sorry to hear about Skie though.~ */
		++ @3005 /* ~Yeah, me too.~ */ + POOR_ENTAR_JAHEIRA
	END

	// Entar put out bounty
	IF ~~ BEGIN POOR_ENTAR_JAHEIRA
		SAY @3011 /* ~Duke Entar must be about out of his mind, losing both of his children.~ */
		+ ~!IsValidForPartyDialogue("IMOEN2") !IsValidForPartyDialogue("MINSC")~ + @3012 /* ~Yeah, I'd feel a lot sorrier for him if he hadn't put a 10,000 gold reward on my head.~ */ + AT_LEAST_KNOW_JAHEIRA
		+ ~!IsValidForPartyDialogue("IMOEN2") IsValidForPartyDialogue("MINSC")~ + @3012 /* ~Yeah, I'd feel a lot sorrier for him if he hadn't put a 10,000 gold reward on my head.~ */ EXTERN ~MINSCJ~ AT_LEAST_KNOW_MINSC
		+ ~IsValidForPartyDialogue("IMOEN2")~ + @3012 /* ~Yeah, I'd feel a lot sorrier for him if he hadn't put a 10,000 gold reward on my head.~ */ EXTERN ~%IMOEN_JOINED%~ AT_LEAST_KNOW_IMOEN
	END

	// Imoen and Minsc not available
	IF ~~ BEGIN AT_LEAST_KNOW_JAHEIRA
		SAY @3009 /* ~At least this time you know who wants you dead, and why.~ */
		+ ~!Global("bd_player_exiled","GLOBAL",2)~ + @3010 /* ~Oddly enough, that doesn't feel like much of an improvement.~ */ + WHERE_DAGGER_JAHERIA
		+ ~Global("bd_player_exiled","GLOBAL",2)~ + @3010 /* ~Oddly enough, that doesn't feel like much of an improvement.~ */ + WHAT_DAGGER_JAHERIA
	END

	// Left before Skie dead via item
	IF ~~ BEGIN WHAT_DAGGER_JAHERIA
		SAY @3013 /* ~What's this about a soul dagger?~ */
		+ ~!IsValidForPartyDialogue("MINSC") !IsValidForPartyDialogue("IMOEN2")~ + @3014 /* ~Your guess is as good as mine.~ */ + WHY_YOU_JAHEIRA
		+ ~!IsValidForPartyDialogue("MINSC") IsValidForPartyDialogue("IMOEN2")~ + @3014 /* ~Your guess is as good as mine.~ */ EXTERN ~%IMOEN_JOINED%~ WHY_YOU_IMOEN
		+ ~IsValidForPartyDialogue("MINSC")~ + @3014 /* ~Your guess is as good as mine.~ */ EXTERN ~MINSCJ~ WHY_YOU_MINSC
	END

	// Left before Skie dead via item, Imoen and Minsc not available
	IF ~~ BEGIN WHY_YOU_JAHEIRA
		SAY @3015 /* ~I wonder why they think you did it.~ */
		++ @3016 /* ~I don't know.  Dopplegangers maybe?~ */ + LETS_GO_JAHEIRA
	END

	// Left before Skie dead via item
	IF ~~ BEGIN LETS_GO_JAHEIRA
		SAY @3017 /* ~Hmm, could be.  But let's worry about this once we're out of here.~ */
		IF ~~ DO ~SetGlobal("#L_PosterTalk","GLOBAL",9)~ EXIT
	END

	// Left after trial
	IF ~~ BEGIN WHERE_DAGGER_JAHERIA
		SAY @3018 /* ~I see they still haven't found that soul dagger.~ */
		IF ~PartyHasItem("#LScr02") !IsValidForPartyDialogue("MINSC") !IsValidForPartyDialogue("IMOEN2")~ GOTO DUKES_DAGGER_LEGS_JAHEIRA
		IF ~PartyHasItem("#LScr02") !IsValidForPartyDialogue("MINSC") IsValidForPartyDialogue("IMOEN2")~ EXTERN ~%IMOEN_JOINED%~ DUKES_DAGGER_LEGS_IMOEN
		IF ~PartyHasItem("#LScr02") IsValidForPartyDialogue("MINSC")~ EXTERN ~MINSCJ~ DUKES_DAGGER_LEGS_MINSC
		IF ~PartyHasItem("#LScr03") !IsValidForPartyDialogue("MINSC") !IsValidForPartyDialogue("IMOEN2")~ GOTO ENTAR_DAGGER_LEGS_JAHEIRA
		IF ~PartyHasItem("#LScr03") !IsValidForPartyDialogue("MINSC") IsValidForPartyDialogue("IMOEN2")~ EXTERN ~%IMOEN_JOINED%~ ENTAR_DAGGER_LEGS_IMOEN
		IF ~PartyHasItem("#LScr03") IsValidForPartyDialogue("MINSC")~ EXTERN ~MINSCJ~ ENTAR_DAGGER_LEGS_MINSC
	END

	// Exiled after trial, Minsc and Imoen not available
	IF ~~ BEGIN	ENTAR_DAGGER_LEGS_JAHEIRA
		SAY @3019 /* ~What does he think?  The dagger sprouted legs and walked out on it's own?  It wasn't to be found in the entire area.~ */
		++ @3021 /* ~Who can say what goes on inside his head.  But let's worry about this once we're out of here.~ */ + RIGHT_JAHEIRA
	END

	// Escaped after trial, Minsc and Imoen not available
	IF ~~ BEGIN	DUKES_DAGGER_LEGS_JAHEIRA
		SAY @3020 /* ~What do they think?  The dagger sprouted legs and walked out on it's own?  It wasn't to be found in the entire area.~ */
		++ @3022 /* ~Who can say what they think.  But let's worry about this once we're out of here.~ */ + RIGHT_JAHEIRA
	END

	// Left after trial, Minsc not available
	IF ~~ BEGIN RIGHT_JAHEIRA
		SAY @3023 /* ~Right!  First things first.~ */
		IF ~~ DO ~SetGlobal("#L_PosterTalk","GLOBAL",9)~ EXIT
	END
END

APPEND MINSCJ
	// Left before Skie dead via item, Imoen and Jaheira not available
	IF ~Global("#L_PosterTalk","GLOBAL",3) Global("bd_player_exiled","GLOBAL",2)~ BEGIN SKIE_DEAD_MINSC
		SAY @3000 /* ~What is that?  Skie Silvershield is dead?~ */
		= @3025	/* ~Did you see this, <CHARNAME>?  Listen!~ */
		= #%SCROLL_READ1%
		= @3026	/* ~And that's not all!~ */
		= #%SCROLL_READ3%
		++ @3001 /* ~I guess so.  And for some reason I am wanted for it.~ */ + FRAMED_AGAIN_MINSC
	END

	// BG2 or Exiled, i.e. Entar is the only duke going after PC, Imoen and Jaheira not available
	IF ~Global("#L_PosterTalk","GLOBAL",3) OR(2) Global("bd_player_exiled","GLOBAL",1) Global("#L_EET","GLOBAL",0)~ BEGIN ENTAR_BOUNTY_MINSC
		SAY @3006 /* ~What is that?  Duke Entar put a price on your head?~ */
		= @3025	/* ~Did you see this, <CHARNAME>?  Listen!~ */
		= #%SCROLL_READ3%
		++ @3008 /* ~A rather high price, actually. This is becoming an annoyingly regular occurance.~ */ + POOR_ENTAR_MINSC
	END

	// Escaped after found guilty, all dukes are after PC, Imoen and Jaheira not available
	IF ~Global("#L_PosterTalk","GLOBAL",1) Global("bd_player_exiled","GLOBAL",0) Global("#L_EET","GLOBAL",1)~ BEGIN DUKES_BOUNTY_MINSC
		SAY @3007 /* ~What is that?  The Dukes of Baldur's Gate have put a price on your head?~ */
		= @3025	/* ~Did you see this, <CHARNAME>?  Listen!~ */
		= #%SCROLL_READ2%
		++ @3008 /* ~A rather high price, actually. This is becoming an annoyingly regular occurance.~ */ + AT_LEAST_KNOW_MINSC
	END

	// Left before Skie dead, Jaheira not available
	IF ~~ BEGIN	FRAMED_AGAIN_MINSC
		SAY @3002 /* ~Don't tell me you've been framed again!~ */
		+ ~!IsValidForPartyDialogue("IMOEN2")~ + @3003 /* ~It would appear so.  This is becoming an annoyingly regular occurance.~ */ + SORRY_SKIE_MINSC
		+ ~IsValidForPartyDialogue("IMOEN2")~ + @3003 /* ~It would appear so.  This is becoming an annoyingly regular occurance.~ */ EXTERN ~%IMOEN_JOINED%~ SORRY_SKIE_IMOEN
	END

	// Left before Skie dead via item, Imoen and Jaheira not available
	IF ~~ BEGIN SORRY_SKIE_MINSC
		SAY @3004 /* ~I am sorry to hear about Skie though.~ */
		++ @3005 /* ~Yeah, me too.~ */ + POOR_ENTAR_MINSC
	END

	// Entar put out bounty, Imoen and Jaheria not available
	IF ~~ BEGIN POOR_ENTAR_MINSC
		SAY @3011 /* ~Duke Entar must be about out of his mind, losing both of his children.~ */
		++ @3012 /* ~Yeah, I'd feel a lot sorrier for him if he hadn't put a 10,000 gold reward on my head.~ */ + AT_LEAST_KNOW_MINSC
	END	

	// Imoen not available
	IF ~~ BEGIN AT_LEAST_KNOW_MINSC
		SAY @3009 /* ~At least this time you know who wants you dead, and why.~ */
		+ ~!Global("bd_player_exiled","GLOBAL",2) !IsValidForPartyDialogue("JAHEIRA")~ + @3010 /* ~Oddly enough, that doesn't feel like much of an improvement.~ */ + WHERE_DAGGER_MINSC
		+ ~!Global("bd_player_exiled","GLOBAL",2) IsValidForPartyDialogue("JAHEIRA")~ + @3010 /* ~Oddly enough, that doesn't feel like much of an improvement.~ */ EXTERN ~JAHEIRAJ~ WHERE_DAGGER_JAHERIA
		+ ~Global("bd_player_exiled","GLOBAL",2) !IsValidForPartyDialogue("JAHEIRA")~ + @3010 /* ~Oddly enough, that doesn't feel like much of an improvement.~ */ + WHAT_DAGGER_MINSC
		+ ~Global("bd_player_exiled","GLOBAL",2) IsValidForPartyDialogue("JAHEIRA")~ + @3010 /* ~Oddly enough, that doesn't feel like much of an improvement.~ */ EXTERN ~JAHEIRAJ~ WHAT_DAGGER_JAHERIA
	END

	// Left before Skie dead via item, Imoen and Jaheira not available
	IF ~~ BEGIN WHAT_DAGGER_MINSC
		SAY @3013 /* ~What's this about a soul dagger?~ */
		++ @3014 /* ~Your guess is as good as mine.~ */ + WHY_YOU_MINSC
	END

	// Left before Skie dead via item
	IF ~~ BEGIN WHY_YOU_MINSC
		SAY @3024 /* ~Boo wonders why they think you did it.~ */
		+ ~!IsValidForPartyDialogue("JAHEIRA") !IsValidForPartyDialogue("IMOEN2")~ + @3016 /* ~I don't know.  Dopplegangers maybe?~ */ + LETS_GO_MINSC
		+ ~!IsValidForPartyDialogue("JAHEIRA") IsValidForPartyDialogue("IMOEN2")~ + @3016 /* ~I don't know.  Dopplegangers maybe?~ */ EXTERN ~%IMOEN_JOINED%~ LETS_GO_IMOEN
		+ ~IsValidForPartyDialogue("JAHEIRA")~ + @3016 /* ~I don't know.  Dopplegangers maybe?~ */ EXTERN ~JAHEIRAJ~ LETS_GO_JAHEIRA
	END

	// Left before Skie dead via item, Jaheira and Imoen not available
	IF ~~ BEGIN	LETS_GO_MINSC
		SAY @3017 /* ~Hmm, could be.  But let's worry about this once we're out of here.~ */
		IF ~~ DO ~SetGlobal("#L_PosterTalk","GLOBAL",9)~ EXIT
	END	

	// Left after trial, Imoen and Jaheiar not available
	IF ~~ BEGIN	WHERE_DAGGER_MINSC
		SAY @3018 /* ~I see they still haven't found that soul dagger.~ */
		IF ~PartyHasItem("#LScr02")~ GOTO DUKES_DAGGER_LEGS_MINSC
		IF ~PartyHasItem("#LScr03")~ GOTO ENTAR_DAGGER_LEGS_MINSC
	END

	// Exiled after trial
	IF ~~ BEGIN	ENTAR_DAGGER_LEGS_MINSC
		SAY @3019 /* ~What does he think?  The dagger sprouted legs and walked out on it's own?  It wasn't to be found in the entire area.~ */
		+ ~!IsValidForPartyDialogue("JAHEIRA") !IsValidForPartyDialogue("IMOEN2")~ + @3022 /* ~Who can say what they think.  But let's worry about this once we're out of here.~ */ + RIGHT_MINSC
		+ ~!IsValidForPartyDialogue("JAHEIRA") IsValidForPartyDialogue("IMOEN2")~ + @3022 /* ~Who can say what they think.  But let's worry about this once we're out of here.~ */ EXTERN ~%IMOEN_JOINED%~ RIGHT_IMOEN
		+ ~IsValidForPartyDialogue("JAHEIRA")~ + @3022 /* ~Who can say what they think.  But let's worry about this once we're out of here.~ */ EXTERN ~JAHEIRAJ~ RIGHT_JAHEIRA
	END

	// Escaped after trial, Minsc not available
	IF ~~ BEGIN	DUKES_DAGGER_LEGS_MINSC
		SAY @3020 /* ~What do they think?  The dagger sprouted legs and walked out on it's own?  It wasn't to be found in the entire area.~ */
		+ ~!IsValidForPartyDialogue("JAHEIRA") !IsValidForPartyDialogue("IMOEN2")~ + @3022 /* ~Who can say what they think.  But let's worry about this once we're out of here.~ */ + RIGHT_MINSC
		+ ~!IsValidForPartyDialogue("JAHEIRA") IsValidForPartyDialogue("IMOEN2")~ + @3022 /* ~Who can say what they think.  But let's worry about this once we're out of here.~ */ EXTERN ~%IMOEN_JOINED%~ RIGHT_IMOEN
		+ ~IsValidForPartyDialogue("JAHEIRA")~ + @3022 /* ~Who can say what they think.  But let's worry about this once we're out of here.~ */ EXTERN ~JAHEIRAJ~ RIGHT_JAHEIRA
	END

	IF ~~ BEGIN RIGHT_MINSC
		SAY @3023 /* ~Right!  First things first.~ */
		IF ~~ DO ~SetGlobal("#L_PosterTalk","GLOBAL",9)~ EXIT
	END
END

ALTER_TRANS IDJINNI
	BEGIN 9 END 
	BEGIN 0 END
	BEGIN
		"TRIGGER" ~OR(2) Global("#L_DestroyedDagger","GLOBAL",1) Global("#L_FramedQuest","GLOBAL",1) Global("bd_player_exiled","GLOBAL",2)~  //Skipped Trial
		"EPILOGUE" ~GOTO TRIAL_SKIPPED_NO_JOURNAL_1~
	END
EXTEND_BOTTOM IDJINNI 9
	IF ~OR(2) Global("#L_DestroyedDagger","GLOBAL",1) Global("#L_FramedQuest","GLOBAL",1) !Global("bd_player_exiled","GLOBAL",2)~ THEN GOTO TRIAL_NO_JOURNAL
	IF ~!Global("#L_DestroyedDagger","GLOBAL",1) Global("#L_FramedQuest","GLOBAL",0) Global("bd_player_exiled","GLOBAL",2)~ THEN GOTO NQ_NT_NJ
	IF ~!Global("#L_DestroyedDagger","GLOBAL",1) Global("#L_FramedQuest","GLOBAL",0) !Global("bd_player_exiled","GLOBAL",2)~ THEN GOTO NQ_T_NJ
END

// This one will end with a journal entry
ALTER_TRANS IDJINNI
	BEGIN 10 END 
	BEGIN 0 END
	BEGIN
		"TRIGGER" ~OR(2) Global("#L_DestroyedDagger","GLOBAL",1) Global("#L_FramedQuest","GLOBAL",1) Global("bd_player_exiled","GLOBAL",2)~  //Skipped Trial
		"EPILOGUE" ~GOTO TRIAL_SKIPPED_JOURNAL_1~
	END
EXTEND_BOTTOM IDJINNI 10
	IF ~OR(2) Global("#L_DestroyedDagger","GLOBAL",1) Global("#L_FramedQuest","GLOBAL",1) !Global("bd_player_exiled","GLOBAL",2)~ THEN GOTO TRIAL_JOURNAL
	IF ~Global("#L_DestroyedDagger","GLOBAL",0) Global("#L_FramedQuest","GLOBAL",0) Global("bd_player_exiled","GLOBAL",2)~ THEN GOTO NQ_NT_J
	IF ~Global("#L_DestroyedDagger","GLOBAL",0) Global("#L_FramedQuest","GLOBAL",0) !Global("bd_player_exiled","GLOBAL",2)~ THEN GOTO NQ_T_J
END

// Give the soul dagger when the genie is freed
EXTEND_BOTTOM IDJINNI 12
	IF ~Global("#L_DestroyedDagger","GLOBAL",1) Global("#L_FramedQuest","GLOBAL",0)~ DO ~EraseJournalEntry(34099) EraseJournalEntry(47514) AddexperienceParty(15000) GivePartyAllEquipment() GiveItemCreate("l#2sda1",Player1,1,0,0) TakePartyItem("misc4d")~ SOLVED_JOURNAL #47515 GOTO 19
END

APPEND IDJINNI
	IF ~~ BEGIN TRIAL_SKIPPED_NO_JOURNAL_1
		SAY @3027 /* ~To sweeten the deal, I will give you the dagger the master used to frame you.  I will have no use for it.~ */
		++ @3028 /* ~Are you saying this mad mage is the one who murdered Skie?~ */ + TRIAL_SKIPPED_NO_JOURNAL_2
	END

	IF ~~ BEGIN TRIAL_SKIPPED_NO_JOURNAL_2
		SAY @3029 /* ~Indeed, so he could separate you from those who protected you. */
		++ @3030 /* ~Is her soul trapped in this dagger?  Can we free her?~ */ + NO_JOURNAL
	END

	IF ~~ BEGIN TRIAL_NO_JOURNAL
		SAY @3027 /* ~To sweeten the deal, I will give you the dagger the master used to frame you.  I will have no use for it.~ */
		++ @3030 /* ~Is her soul trapped in this dagger?  Can we free her?~ */ + NO_JOURNAL
	END

	IF ~~ BEGIN NO_JOURNAL
		SAY @3031 /* ~I believe so on both accounts.~ */
		= @3032 /* ~I am protecting the dagger for the master.  If you free me, I will give you it and your weapon.~ */
		IF ~~ THEN EXIT
	END

	IF ~~ BEGIN TRIAL_SKIPPED_JOURNAL_1
		SAY @3027 /* ~To sweeten the deal, I will give you the dagger the master used to frame you.  I will have no use for it.~ */
		++ @3028 /* ~Are you saying this mad mage is the one who murdered Skie?~ */ + TRIAL_SKIPPED_JOURNAL_2
	END

	IF ~~ BEGIN TRIAL_SKIPPED_JOURNAL_2
		SAY @3029 /* ~Indeed, so he could separate you from those who protected you. */
		++ @3030 /* ~Is her soul trapped in this dagger?  Can we free her?~ */ + DO_JOURNAL
	END

	IF ~~ BEGIN TRIAL_JOURNAL
		SAY @3027 /* ~To sweeten the deal, I will give you the dagger the master used to frame you.  I will have no use for it.~ */
		++ @3030 /* ~Is her soul trapped in this dagger?  Can we free her?~ */ + DO_JOURNAL
	END

	IF ~~ BEGIN DO_JOURNAL
		SAY @3031 /* ~I believe so on both accounts.~ */
		= @3032 /* ~I am protecting the dagger for the master.  If you free me, I will you give it and your weapon.~ */
  		IF ~~ THEN DO ~SetGlobal("HelpDjinni","GLOBAL",1)~ UNSOLVED_JOURNAL #34099 EXIT
	END

	IF ~~ BEGIN NQ_NT_NJ
		SAY @3034 /* ~It is unfortunate that I no longer am the keeper of the dagger the master used to frame you, or I would be able to offer it to you to sweeten the deal.~ */
		++ @3028 /* ~Are you saying this mad mage is the one who murdered Skie?~ */ + NQ_NT_NJ_2
	END

	IF ~~ BEGIN NQ_NT_NJ_2
		SAY @3029 /* ~Indeed, so he could separate you from those who protected you. */
		= @3035 /* ~But unfortunately, I suspect it has been destroyed since he no longer had any use for it.~ */
		IF ~~ THEN EXIT
	END

	IF ~~ BEGIN NQ_T_NJ
		SAY @3034 /* ~It is unfortunate that I no longer am the keeper of the dagger the master used to frame you, or I would be able to offer it to you to sweeten the deal.~ */
		= @3035 /* ~But unfortunately, I suspect it has been destroyed since he no longer had any use for it.~ */
		IF ~~ THEN EXIT
	END

	IF ~~ BEGIN NQ_NT_J
		SAY @3034 /* ~It is unfortunate that I no longer am the keeper of the dagger the master used to frame you, or I would be able to offer it to you to sweeten the deal.~ */
		++ @3028 /* ~Are you saying this mad mage is the one who murdered Skie?~ */ + NQ_NT_J_2
	END

	IF ~~ BEGIN NQ_NT_J_2
		SAY @3029 /* ~Indeed, so he could separate you from those who protected you. */
		= @3035 /* ~But unfortunately, I suspect it has been destroyed since he no longer had any use for it.~ */
  		IF ~~ THEN DO ~SetGlobal("HelpDjinni","GLOBAL",1)~ UNSOLVED_JOURNAL #34099 EXIT
	END

	IF ~~ BEGIN NQ_T_J
		SAY @3034 /* ~It is unfortunate that I no longer am the keeper of the dagger the master used to frame you, or I would be able to offer it to you to sweeten the deal.~ */
		= @3035 /* ~But unfortunately, I suspect it has been destroyed since he no longer had any use for it.~ */
  		IF ~~ THEN DO ~SetGlobal("HelpDjinni","GLOBAL",1)~ UNSOLVED_JOURNAL #34099 EXIT
	END
END
