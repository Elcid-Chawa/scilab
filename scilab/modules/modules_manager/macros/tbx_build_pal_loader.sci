// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2013 - INRIA - Serge STEER
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution. The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2.1-en.txt

function tbx_build_pal_loader(palettename,interfacefunctions,module_path,script_path)
    if argn(2) < 3 then
        error(msprintf(gettext("%s: Wrong number of input arguments: At least %d expected.\n"),"tbx_build_blocks",3));
    end
    // checking palettename argument
    if type(palettename) <> 10 then
        error(msprintf(gettext("%s: Wrong type for input argument #%d: A string expected.\n"),"tbx_build_blocks",1));
    end
    if size(palettename,"*") <> 1 then
        error(msprintf(gettext("%s: Wrong size for input argument #%d: A string expected.\n"),"tbx_build_blocks",1));
    end

    // checking module_path argument
    if type(module_path) <> 10 then
        error(msprintf(gettext("%s: Wrong type for input argument #%d: A string expected.\n"),"tbx_build_blocks",3));
    end
    if size(module_path,"*") <> 1 then
        error(msprintf(gettext("%s: Wrong size for input argument #%d: A string expected.\n"),"tbx_build_blocks",3));
    end
    if ~isdir(module_path) then
        error(msprintf(gettext("%s: The directory ''%s'' doesn''t exist or is not read accessible.\n"),"tbx_build_blocks",module_path));
    end

    // checking interfacefunctions argument
    if type(interfacefunctions) <> 10 then
        error(msprintf(gettext("%s: Wrong type for input argument #%d: A string array expected.\n"),"tbx_build_blocks",2));
    end

    // checking optional script_path argument
    if argn(2)==4 then
        if type(script_path) <> 10 then
            error(msprintf(gettext("%s: Wrong type for input argument #%d: A string expected.\n"),"tbx_build_blocks",4));
        end
        if size(script_path,"*") <> 1 then
            error(msprintf(gettext("%s: Wrong size for input argument #%d: A string expected.\n"),"tbx_build_blocks",4));
        end
    else
        script_path=module_path + "/macros"
    end
    if ~isdir(script_path) then
        error(msprintf(gettext("%s: The directory ''%s'' doesn''t exist or is not read accessible.\n"),"tbx_build_blocks",script_path));
    end


    t=["function loaderpal()"
    "  xpal = xcosPal("""+palettename+""");"
    "  images_path = "+sci2exp(module_path+"/images/");
    "  interfacefunctions ="+sci2exp(interfacefunctions);
    "  for i=1:size(interfacefunctions,""*"")"
    "    h5_instances  = ls(images_path + ""h5/""  + interfacefunctions(i) + "".sod"");"
    "    if h5_instances==[] then"
    "      error(msprintf(_(""%s: block %s has not been built.\n""),""loader_pal.sce"",interfacefunctions(i)))"
    "    end"
    "    pal_icons     = ls(images_path + ""gif/"" + interfacefunctions(i) + ""."" + [""png"" ""jpg"" ""gif""]);"
    "    if pal_icons==[] then"
    "      error(msprintf(_(""%s: block %s has no palette icon.\n""),""loader_pal.sce"",interfacefunctions(i)))"
    "    end"
    "    graph_icons   = ls(images_path + ""svg/"" + interfacefunctions(i) + ""."" + [""svg"" ""png"" ""jpg"" ""gif""]);"
    "    if graph_icons==[] then"
    "      error(msprintf(_(""%s: block %s has no editor icon.\n""),""loader_pal.sce"",interfacefunctions(i)))"
    "    end"
    "    xpal = xcosPalAddBlock(xpal, h5_instances(1), pal_icons , graph_icons(1));"
    "  end"
    "  xcosPalAdd(xpal);"
    "endfunction"
    "loaderpal(),clear loaderpal"]
    mputl(t,script_path+"loader_pal.sce")
endfunction
