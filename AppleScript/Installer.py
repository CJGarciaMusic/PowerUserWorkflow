import xml.etree.ElementTree as ET
import xml.etree as etree

def replace_xml_string(path):
    tree = ET.parse(path)

    root = tree.getroot()

    has_used_JW_Lua = True
    has_jetstream = False

    if root.find("JWLua") == None:
        has_used_JW_Lua = False
        print("You don't seem to have used JW Lua yet, you'll have to do the install manually, but then all subsiquent installs should be automatic.")
        # alert about installing the Lua Script manually

    if has_used_JW_Lua == True:

        for child in root.iter("ManualPlugins"):
            if ("/JetStream.lua" in child.attrib["FullPath"]):
                child.set("FullPath", "/Library/Application Support/MakeMusic/Finale 26/Plug-ins/JW Lua/JetStream.lua")
                has_jetstream = True
                # tree.write(path)
                print("JW Lua has been used, JetStream was in there at some point, but now it has a new location. Install Succesful. Please quit and reopen Finale to see the changes.")
    
        if has_jetstream == False:
            new_index = sum(1 for x in root.iter("ManualPlugins"))
            print("You have JW Lua, but not JetStream, let's take care of that.")
            tag_count = 0
            for item in root.iter():
                if item.tag == "JWLua":
                    break
                tag_count = tag_count + 1
            new = ET.Element("ManualPlugins", {"CollectionIdx": str(new_index+1), "Enabled":"1", "FullPath": "/Library/Application Support/MakeMusic/Finale 26/Plug-ins/JW Lua/JetStream.lua"})
            newsub1 = ET.SubElement(new, "UserValues", count = "0")
            newsub1.tail = "\n                "
            new.tail = "\n                "
            new.text="\n                        "
            root[tag_count-1][0][0].insert(new_index-1, new)
            tree.write(path)
            


replace_xml_string("/Users/cgarcia/Library/Application Support/MakeMusic/Finale 26/jwpluginstorage.xml")