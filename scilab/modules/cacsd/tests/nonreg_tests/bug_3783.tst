// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2008 - DIGITEO - Vincent Couvert
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- Non-regression test for bug 3783 -->
//
// <-- Bugzilla URL -->
// http://bugzilla.scilab.org/show_bug.cgi?id=3783
//
// <-- Short Description -->
//    Using the command trfmod in version 5.0.3 (at least) in windows (at least) the program is blocked.


// <-- INTERACTIVE TEST -->

h=syslin('c',1/%s);
// Please click the 'OK' button, the program must return
trfmod(h)
