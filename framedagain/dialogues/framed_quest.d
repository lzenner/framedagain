//////////////////////////////////////////////////////////
// Dialogue required for the quest to free Skie         //
// Compiled via framed_quest.tpa using framed_quest.tra //
//////////////////////////////////////////////////////////

// Give the soul dagger when the genie is freed
EXTEND_BOTTOM IDJINNI 12
	IF ~Global("#L_DestroyedDagger","GLOBAL",1) Global("#L_FramedQuest","GLOBAL",1)~ DO ~EraseJournalEntry(34099) EraseJournalEntry(47514) AddexperienceParty(15000) GivePartyAllEquipment() GiveItemCreate("l#2sda1",Player1,1,0,0) TakePartyItem("misc4d")~ SOLVED_JOURNAL #47515 UNSOLVED_JOURNAL @3100 GOTO 19
	IF ~Global("#L_DestroyedDagger","GLOBAL",0) Global("#L_FramedQuest","GLOBAL",1)~ DO ~EraseJournalEntry(34099) EraseJournalEntry(47514) AddexperienceParty(15000) GivePartyAllEquipment() GiveItemCreate("#LDGSoul",Player1,1,0,0) TakePartyItem("misc4d")~ SOLVED_JOURNAL #47515 UNSOLVED_JOURNAL @3100 GOTO 19
END

