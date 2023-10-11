param([String]$fileName,[String]$folder) 
$test = $false
$allFilesProcessed = @(0..0)
$allFilesProcessed[0] = "All files processed:"
if ($folder) {
    $listOfPdfs = Get-ChildItem -Path $folder -Filter "*.pdf" -Name

    for ($i=0; $i -lt $listOfPdfs.Length; $i++) {
        $listOfPdfs[$i] = $folder+"\"+$listOfPdfs[$i]
    }
}

if ($fileName) {
    $test = Test-Path -Path $fileName
    if ($test) { 
        Write-Host "Path tested true, adding"$fileName" to listOfPdfs"
        $listOfPdfs += $fileName
    } else {
        Write-Host "Unable to find/access"$fileName
    }
}

if ($folder -and !$listOfPdfs) {
    Write-Host "Unable to find/access any pdfs at"$folder
}

if (!$fileName -and !$listOfPdfs -or $test -and !$listOfPdfs) {
    Write-Host "No files to process, ending script"
    return
}

foreach ($file in $listOfPdfs) {
    #$file = "C:\Users\JoeBob\Documents\jsonTest\Suri_11Oct.pdf"
    #powershell.exe -file combined.ps1 C:\Users\JoeBob\Documents\jsonTest\Suri_11Oct.pdf
    Write-Host "Fetching"$file
    $Lines = Get-Content $file
    $pairs = $null
    $pairs = [Ordered]@{ "title" = "value" }
    
    Write-Host "Parsing"$file
    foreach($line in $lines) {
        if ($line -match "^[0-9]{1,4}\s[0-9]\sobj$") {
            $obj = $true
        }

        if ($line -match "^endobj$") {
            if ($title -and $value) {
                $pairs.$T = $V
            }
            $obj = $false
            $T = $null
            $title = $false
            $V = $null
            $value = $false
        }

        $result = $line | select-string -pattern "^\/T\((.*?)\)$"
        if ($result -and $obj) {
            $title = $true
            $T = $result.Matches.Groups.Value[1]
        }

        $result = $line | select-string -pattern "^\/V\((.*?)\)$"
        if ($result -and $obj -and $title) {
            if ($result.Matches.Groups.Value[1].Length -gt 0) {
                $value = $true
                $V = $result.Matches.Groups.Value[1]
            }

        }

        $result = $line | select-string -pattern "^\/V\<(.*?)\>$"
        if ($result -and $obj -and $title) {
            if ($result.Matches.Groups.Value[1].Length -gt 0) {
                $value = $true
                $V = $result.Matches.Groups.Value[1]
            }

        }
    }

        
    Write-Host "Creating JSON for "$pairs.CharacterName
    $properties = $null
    $propertyValue = $null
    $TextInfo = (Get-Culture).TextInfo

    $propertyValue = @{
          "id" = 45855552
          "parentId" = $null
          "type" = "tab-section"
          "value" = "Character"
	      "rank" = 1000
    }

    $properties = $propertyValue

    $propertyValue = @{
          "id" = 45855553
          "parentId" = 45855552
          "type" = "horizontal-section"
	      "rank" = 1001
    }

    $properties = $properties, $propertyValue

    $propertyValue = @{
          "id" = 45855554
          "parentId" = 45855553
          "type" = "section"
	      "size" = 65
	      "rank" = 1010
    }
    $properties += $propertyValue
        $propertyValue = @{
          "id" = 45855555
          "parentId" = 45855554
          "type" = "title-section"
          "value" = "Abilities"
	      "rank" = 1
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855582
          "parentId" = 45855475
          "type" = "number"
          "name" = "initiative"
          "value" = $pairs.Init.Trim("+-")
	      "message" = "!r initiative = 1d20 + initiative"
	      "rank" = 0
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855473
          "parentId" = 45855555
          "type" = "ability"
          "name" = "strength"
          "value" = 1
	      "message" = "strength check = {1d20 + strength}"
          "formula" = "floor ((strength-score - 10) / 2)"
	      "rank"  = 1
        }

    $properties += $propertyValue
    $propertyValue = @{
          "id" = 45855474
          "parentId" = 45855473
          "type" = "number"
          "name" = "strength-score"
          "value" = [int]$pairs.STRmod
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855556
          "parentId" = 45855555
          "type" = "ability"
          "name" = "dexterity"
          "value" = 2
	      "message" = "dexterity check = {1d20 + dexterity}"
          "formula" = "floor ((dexterity-score - 10) / 2)"
	      "rank"  = 2
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855557
          "parentId" = 45855556
          "type" = "number"
          "name" = "dexterity-score"
          "value" = [int]$pairs.'DEXmod '
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855558
          "parentId" = 45855555
          "type" = "ability"
          "name" = "constitution"
          "value" = -3
	      "message" = "constitution check = {1d20 + constitution}"
          "formula" = "floor ((constitution-score - 10) / 2)"
	      "rank"  = 3
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855559
          "parentId" = 45855558
          "type" = "number"
          "name" = "constitution-score"
          "value" = [int]$pairs.CONmod
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855560
          "parentId" = 45855555
          "type" = "ability"
          "name" = "intelligence"
          "value" = 3
	      "message" = "intelligence check = {1d20 + intelligence}"
          "formula" = "floor ((intelligence-score - 10) / 2)"
	      "rank"  = 4
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855561
          "parentId" = 45855560
          "type" = "number"
          "name" = "intelligence-score"
          "value" = [int]$pairs.INTmod
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855562
          "parentId" = 45855555
          "type" = "ability"
          "name" = "wisdom"
          "value" = 2
	      "message" = "wisdom check = {1d20 + wisdom}"
          "formula" = "floor ((wisdom-score - 10) / 2)"
	      "rank"  = 5
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855563
          "parentId" = 45855562
          "type" = "number"
          "name" = "wisdom-score"
          "value" = [int]$pairs.WISmod
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855564
          "parentId" = 45855555
          "type" = "ability"
          "name" = "charisma"
          "value" = 0
	      "message" = "charisma check = {1d20 + charisma}"
          "formula" = "floor ((charisma-score - 10) / 2)"
	      "rank"  = 6
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855565
          "parentId" = 45855564
          "type" = "number"
          "name" = "charisma-score"
          "value" = [int]$pairs.CHAmod
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855482
          "parentId" = 45855555
          "type" = "health"
          "name" = "hit-points"
          "value" = [int]$pairs.MaxHP
	      "rank" = 11
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855483
          "parentId" = 45855482
          "type" = "number"
          "name" = "hit-points-maximum"
          "value" = [int]$pairs.MaxHP
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855484
          "parentId" = 45855482
          "type" = "number"
          "name" = "hit-points-temporary"
        }

    $properties += $propertyValue
        $propertyValue = @{
          "id" = 45855475
          "parentId" = 45855554
          "type" = "title-section"
          "value" = "Info"
	      "rank" = 2
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855478
          "parentId" = 45855475
          "type" = "text"
          "name" = "race"
          "value" = $pairs.RACE
	      "rank" = 1
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855476
          "parentId" = 45855475
          "type" = "number"
          "name" = "Level"
          "value" = $pairs.'CLASS  LEVEL' -replace '[a-zA-Z\s]',''
	      "rank" = 3
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855477
          "parentId" = 45855475
          "type" = "text"
          "name" = "class"
          "value" = $pairs.'CLASS  LEVEL'.Trim("0123456789")
	      "rank" = 2
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855581
          "parentId" = 45855475
          "type" = "number"
          "name" = "proficiency"
          "value" = 2
	      "formula" = "level <= 4 ? 2 : level <= 8 ? 3 : level <= 12 ? 4 : level <= 16 ? 5 : 6"
	      "rank" = 4
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855479
          "parentId" = 45855475
          "type" = "number"
          "name" = "armor-class"
          "value" = $pairs.AC
	      "rank" = 5
        }

    $properties += $propertyValue

    $speed = $pairs.Speed -replace "[a-zA-Z\s\.\\\(\)]",""
        $propertyValue = @{
          "id" = 45855480
          "parentId" = 45855475
          "type" = "number"
          "name" = "speed"
          "value" = [int]$speed
	      "rank" = 6
        }


        $propertyValue = @{
          "id" = 45855481
          "parentId" = 45855475
          "type" = "number"
          "name" = "experience"
	      "rank" = 8
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855579
          "parentId" = 45855554
          "type" = "title-section"
          "value" = "Details"
	      "rank" = 3
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855485
          "parentId" = 45855579
          "type" = "paragraph"
          "value" = "Stuff"
	      "rank" = 1
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855486
          "parentId" = 45855553
          "type" = "section"
	      "size" = 35
	      "rank" = 1011
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855487
          "parentId" = 45855486
          "type" = "title-section"
          "value" = "Saving Throws"
	      "rank" = 1
        }

    $properties += $propertyValue

    $statList = $null
    foreach ($Key in $pairs.Keys) {
        if ($Key -like "*mod*" -and $Key.Length -le 7) {
            $stat = $Key -replace "Mod",""
            $stat = $TextInfo.ToTitleCase($stat.Trim().ToLower())
            $statProf = $stat+"Prof"
            $statList += [Ordered]@{$stat = $statProf}
        }
    }

    $id = 45850500
    foreach ($Key in $statList.Keys) {
        $id++
        $prof = $statList.$Key

        $name = $Key+" save"
        $propertyValue = @{
            "id" = $id
            "parentId" = 45855487
            "type" = "saving-throw"
            "name" = $name
            "value" = 1
	        "message" = $Key+" save: {1d20 + "+$Key+"-save}"
            "formula" = $stat+" + ("+$Key+"-save-proficiency ? proficiency : 0)"
	        "rank" = 1
        }

        $properties += $propertyValue

        if ($pairs.$prof) {
            $statValue = $true
        } else {
            $statValue = $false
        }
        $name = $Key+"-save-proficiency"
        $propertyValue = @{
            "id" = 45855489
            "parentId" = $id
            "type" = "checkbox"
            "name" = $name
            "value" = $statValue
        }
        $properties += $propertyValue
    }
        $propertyValue = @{
          "id" = 45855587
          "parentId" = 45855486
          "type" = "title-section"
          "value" = "Senses"
	      "rank" = 2
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855498
          "parentId" = 45855587
          "type" = "number"
          "name" = "passive-perception"
          "value" = 14
	      "formula" = "10 + perception"
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855499
          "parentId" = 45855587
          "type" = "number"
          "name" = "passive-stealth"
          "value" = 12
	      "formula" = "10 + stealth"
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855497
          "parentId" = 45855587
          "type" = "number"
          "name" = "dark-vision"
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855588
          "parentId" = 45855486
          "type" = "title-section"
          "value" = "Skills"
	      "rank" = 3
        }

    $properties += $propertyValue

    $skillList = $null
    foreach ($Key in $pairs.Keys) {
        if ($Key -like "*mod" -and $Key.Length -gt 6) {
            $skill = $Key -replace "Mod",""
            $skillProf = $skill+"Prof"
            $skillMod = $skill+"mod"
            $skillEntry = @{
                $skillMod = $pairs.$skillMod
                $skillProf = $pairs.$skillProf
            }
            $skillList += [Ordered]@{$skill = $skillEntry}
        }
    }

    $id = 45850000
    foreach ($Key in $skillList.Keys) {
        $id++
        $skillName = $Key
        $prof = $Key+"Prof"
        $prof = $skillList.$Key.$prof
        $mod = $Key+"Mod"
        $mod = $TextInfo.ToTitleCase($skillList.$key.$mod.ToLower())
        $subJSON = @{"subtitle" = $mod}

        $propertyValue = @{
            "id" = $id
            "parentId" = 45855588
            "type" = "skill"
            "data" = $subJSON
            "name" = $skillName
            "value" = 2
            "message" = $skillName+" check: {1d20 + "+$Key+"}"
            "formula" = $mod+" + ("+$skillName+"-proficiency ? proficiency : jack-of-all-trades ? (floor (proficiency / 2)) : 0) + ("+$skillName+"-expertise ? proficiency : 0)"
        }
        $properties += $propertyValue

        $name = $skillName+"-proficiency"
        $eValue = $false
        $pValue = $false

        if ($prof -eq "E") {
            $eValue = $true
            $pValue = $true
        } elseif ($prof -eq "P") {
            $pValue = $true
        } 
        $propertyValue = @{
            "id" = 45855530
            "parentId" = $id
            "type" = "checkbox"
            "name" = $name
            "value" = $pValue
        }
        $properties += $propertyValue
    
        $name = $skillName+"-expertise"
        $propertyValue = @{
            "id" = 45855531
            "parentId" = $id
            "type" = "checkbox"
            "name" = $name 
            "value" = $eValue
        }
        $properties += $propertyValue
    }

        $propertyValue = @{
          "id" = 45855547
          "parentId" = 45855588
          "type" = "checkbox"
          "name" = "jack-of-all-trades"
	      "value" = 0
	      "rank" = 1000
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855548
          "parentId" = $null
          "type" = "tab-section"
          "value" = "Attacks"
	      "rank" = 2000
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855549
          "parentId" = 45855548
          "type" = "filter-list"
        }

    $properties += $propertyValue

    foreach ($Key in $pairs.Keys) {
        if ($Key -like "Wpn Name*") {
            $wpnName = $pairs.$Key
            $wpnPair = $Key, $wpnName
            $wpnList += $wpnPair
        }
    }

    foreach ($Key in $pairs.Keys) {
        if ($Key -like "Wpn* Damage*") {
            $wpnDmg = $pairs.$Key
            $wpnPair = $Key, $wpnDmg
            $dmgList += $wpnPair
        }
    }

    foreach ($Key in $pairs.Keys) {
        if ($Key -like "Wpn Notes*") {
            $wpnNotes = $pairs.$Key
            $wpnPair = $Key, $wpnNotes
            $notesList += $wpnPair
        }
    }

    for ($i = 1; $i -le $wpnList.Count; $i+= 2) { 
        $wpnName = $wpnList[$i]
        $wpnDmg = $dmgList[$i] -split " "
        $dmgDie = $wpnDmg[0] -replace "[+-][0-9]",""
    if ($notesList[$i] -match "Finesse|Range") {
            $message = $wpnList[$i] + ": {1d20 + prof + @:max(str,dex):} to hit, {" + $dmgDie + "+@:max(str,dex):} " + $wpnDmg[1]
        } else {
            $message = $wpnList[$i] + ": {1d20 + prof + str} to hit, {" + $dmgDie + "+str} " + $wpnDmg[1]
        }

        $propertyValue = @{
          "id" = 45000001
          "parentId" = 45855549
          "type" = "message"
          "name" = $wpnList[$i]
          "icon" = "/images/message.png"
	      "message" = $message
        }

        $properties += $propertyValue
        }

    $wpnList = $null
    $dmgList = $null
    $notesList = $null


    $properties += $propertyValue

    if ($pairs.spellAtkBonus0) {
            $propertyValue = @{
              "id" = 45855578
              "parentId" = 45855579
              "type" = "number"
              "name" = "spell-attack-modifier"
              "value" = [int]$pairs.spellAtkBonus0.Trim("+-")
	          "rank" = 7
            }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855539
          "parentId" = $null
          "type" = "tab-section"
          "value" = "Spells"
	      "rank" = 3000
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855546
          "parentId" = 45855545
          "type" = "section"
	      "size" = 59.671361502347374
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855542
          "parentId" = 45855546
          "type" = "checkboxes"
          "name" = "Level 1 spell slots"
          "local" = $true
          "value" = 0
	      "rank" = 1
        }

    $properties += $propertyValue


    $slots = $pairs.spellSlotHeader1 -split " "

        $propertyValue = @{
          "id" = 45855543
          "parentId" = 45855542
          "type" = "number"
          "name" = "level_1_spell_slots-max"
          "value" = [int]$slots[0]
	      "rank" = 1
        }

    $properties += $propertyValue

        $propertyValue = @{ 
          "id" = 45855544
          "parentId" = 45855542
          "type" = "number"
          "name" = "lvl1-spells-used"
          "value" = 0
	      "rank" = 2
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855500
          "parentId" = 45855546
          "type" = "title-section"
          "value" = "Prepared"
	      "rank" = 2
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855540
          "parentId" = 45855500
          "type" = "filter-list"
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855545
          "parentId" = 45855539
          "type" = "horizontal-section"
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855566
          "parentId" = 45855545
          "type" = "section"
	      "size" = 40.328638497652626
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855567
          "parentId" = 45855566
          "type" = "title-section"
          "value" = "Known"
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855570
          "parentId" = 45855567
          "type" = "title-section"
          "value" = "Level 1 spells"
        }

    $properties += $propertyValue

        $propertyValue = @{
          "id" = 45855572
          "parentId" = 45855570
          "type" = "filter-list"
        }

    $properties += $propertyValue
	
    foreach ($Key in $pairs.Keys) {
        if ($Key -like "spellHeader*") {
            if ($pairs.$key -like "*CANTRIPS*") {
                $spellLvl = 0
            } else {
                $spellLvl = $pairs.$key -replace "[a-zA-Z\s\=]",""
            }
        } elseif ($Key -like "spellName*") {
            $spellName = $pairs.$Key
        } elseif ($key -like "spellSaveHit*") {
            $spellHit = $pairs.$Key
        } elseif ($key -like "spellCastingTime*") {
            $spellCasting = $pairs.$Key
        } elseif ($key -like "spellRange*") {
            $spellRange = $pairs.$Key
        } elseif ($key -like "spellComponents*") {
            $spellComponents = $pairs.$Key
        } elseif ($key -like "spellDuration*") {
            $spellDuration = $pairs.$Key
        } elseif ($key -like "spellPage*") {
            $spellPage = $pairs.$Key
        } elseif ($key -like "spellNotes*") {
            if ($spellLvl -eq 0) {
                $parentId = 45855540
            } elseif ($spellLvl -eq 1) {
                $parentId = 45855572
            }
        
            if ($spellHit -eq "--") {
	            $message = $spellName+": Notes: "+$spellCasting+"; "+$spellRange+"; "+$spellComponents+"; "+$spellDuration+"; "+$spellPage
            } elseif ($spellHit -like "+*" -or $spellHit -like "-*") {
	            $message = $spellName+": Hit: {1d20 + prof + spell-attack-modifier} Damage: {}  Notes: "+$spellCasting+"; "+$spellRange+"; "+$spellComponents+"; "+$spellDuration
            } else {
	            $message = $spellName+": Hit: "+$spellHit.Trim(" 0123456789")+" save vs {8 + spell-attack-modifier} Damage: {}  Notes: "+$spellCasting+"; "+$spellRange+"; "+$spellComponents+"; "+$spellDuration
            }

            $propertyValue = @{
                "id" = 45855000
                "parentId" = $parentId
                "type" = "message"
                "name" = $spellName
                "icon" = "/images/message.png"
	            "message" = $message
            }
            $properties += $propertyValue
        }
    }
    }

        $propertyValue = @{
          "id" = 45855574
          "parentId" = $null
          "type" = "tab-section"
          "value" = "Inventory"
	      "rank" = 4000
        }

    $properties += $propertyValue

    $final = @{
        "properties" = $properties
        "private" = $false
        "type" = "tableplop-character-v2"
    }


    $classLevel = $pairs.'CLASS  LEVEL' -replace ' ','_'
    $charName = $pairs.CharacterName -replace ' ','_'
    $json = $final | ConvertTo-Json -Depth 99


    $newFileName = $file -replace "\.pdf",".json"
    $allFilesProcessed += $file

    $json | Set-Content -Path $newFileName
    Write-Host "Finished with "$charName"'s new JSON for TablePlop, check it out here: "$newFileName
}

Write-Host
Write-Host
$allFilesProcessed
Write-Host
Write-Host "All done! Now get out there and die in new and interesting ways!"