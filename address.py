import re
def shorten_rd(address):
    '''Completes the road type. I.e. Rd becomes Road, st becomes Street as per Google etc.'''
    address = address.title()
    import re

    s = """WEST ST
           MOUNT PEBBLE RD"""

    toReplace = {"ST": 'STREET', "RD": "ROAD", "ave": "avenue"}
    for k, v in toReplace.items():
        s = re.sub(r"\b" + k + r"\b", v, s)
    print(s)
    address = re.sub(r" Street(?=$| [NE(So|S$)(We|W$)])", ' st', address)
    address = re.sub(r" Road(?=$| [NE(So|S$)(We|W$)])", ' Rd', address)
    address = re.sub(r"(?<!The) Avenue(?=$| [NE(So|S$)(We|W$)])", ' Ave', address)
    address = re.sub(r" Close(?=$| [NE(So|S$)(We|W$)])", ' Cl', address)
    address = re.sub(r" Court(?=$| [NE(So|S$)(We|W$)])", ' Ct', address)
    address = re.sub(r"(?<!The) Crescent(?=$| [NE(So|S$)(We|W$)])", ' Cres', address)
    address = re.sub(r" Boulevarde?(?=$| [NE(So|S$)(We|W$)])", ' Blvd', address)
    address = re.sub(r" Drive(?=$| [NE(So|S$)(We|W$)])", ' Dr', address)
    address = re.sub(r" Lane(?=$| [NE(So|S$)(We|W$)])", ' Ln', address)
    address = re.sub(r" Place(?=$| [NE(So|S$)(We|W$)])", ' Pl', address)
    address = re.sub(r" Square(?=$| [NE(So|S$)(We|W$)])", ' Sq', address)
    address = re.sub(r"(?<!The) Parade(?=$| [NE(So|S$)(We|W$)])", ' Pde', address)
    address = re.sub(r" Circuit(?=$| [NE(So|S$)(We|W$)])", ' Cct', address)
    return address
def lengthen_rd(address):
    address = address.title()
    address = re.sub(r" St(?=$| [NE(So|S$)(We|W$)])", " Street", address)
    address = re.sub(r" Rd(?=$| [NE(So|S$)(We|W$)])", " Road", address)
    address = re.sub(r" Ave(?=$| [NE(So|S$)(We|W$)])", " Avenue", address)
    address = re.sub(r" Cl(?=$| [NE(So|S$)(We|W$)])", " Close", address)
    address = re.sub(r" Ct(?=$| [NE(So|S$)(We|W$)])", " Court", address)
    address = re.sub(r" Cres(?=$| [NE(So|S$)(We|W$)])", " Crescent", address)
    address = re.sub(r" Blvd(?=$| [NE(So|S$)(We|W$)])", " Boulevard", address)
    address = re.sub(r" Dr(?=$| [NE(So|S$)(We|W$)])", " Drive", address)
    address = re.sub(r" Ln(?=$| [NE(So|S$)(We|W$)])", " Lane", address)
    address = re.sub(r" Pl(?=$| [NE(So|S$)(We|W$)])", " Place", address)
    address = re.sub(r" Sq(?=$| [NE(So|S$)(We|W$)])", " Square", address)
    address = re.sub(r" Pde(?=$| [NE(So|S$)(We|W$)])", " Parade", address)
    address = re.sub(r" Cct(?=$| [NE(So|S$)(We|W$)])", " Circuit", address)
    return address

def standard_addr(address):
    '''Checks for unit numbers and street addresses and puts them in the standard format'''
    #print("################################")
    #print("### Address: ", address)
    unit_nums = re.findall(r"(?<=Unit )\w?\d+\w?|(?<=U)\d+\w?|\w?\d+\w?(?=\s*/)", address)
    unit_num = unit_nums[0] if len(unit_nums)==1 else ""
    #print("Unit Number: ", unit_num)
    proc_addr = re.sub(r"Unit \w?\d+\w?/?|U\d+\w?/?|\w?\d+\w?\s*/", "", address)
    proc_addr = re.sub(r"^[,\- ]+|[,\- ]+$", "", proc_addr)
    #print("Unitless address: ", proc_addr)
    type_opts = r"Terrace|Way|Walk|St|Rd|Ave|Cl|Ct|Cres|Blvd|Dr|Ln|Pl|Sq|Pde|Cct"
    road_attrs_pattern = r"(?P<rd_no>\w?\d+(\-\d+)?\w?\s+)(?P<rd_nm>[a-zA-z \d\-]+)\s+(?P<rd_tp>" + type_opts + ")"
    #print("Road Attr Pattern: ", road_attrs_pattern)
    road_attrs = re.search(road_attrs_pattern, proc_addr)
    try:
        road_num = road_attrs.group('rd_no').strip()
    except AttributeError:
        road_num = ""
    #print("Road number: ", road_num)
    try:
        road_name = road_attrs.group('rd_nm').strip()
    except AttributeError:
        road_name = ""
    #print("Road name: ", road_name)
    try:
        road_type = road_attrs.group('rd_tp').strip()
    except AttributeError:
        road_type = ""
    #print("Road type: ", road_type)
    proc_addr = shorten_rd(re.sub(r"^[,\- ]+|[,\- ]+$", "", re.sub(road_attrs_pattern, "", proc_addr)))
    #print("Leftover: ", proc_addr)

    unit_seg = (unit_num + "/" if unit_num!="" else "") if road_num != "" else ("Unit " + unit_num + ", " if unit_num!="" else "")
    road_seg = ((road_num + " " if road_num!="" else "") + road_name + " " + road_type).strip()
    post_road_seg = " " + proc_addr if proc_addr != "" else ""
    proc_addr = (unit_seg + road_seg) + post_road_seg
    print("### Processed Address: ", proc_addr)
    return proc_addr



(standard_addr("1  Newyork west st 2000"))