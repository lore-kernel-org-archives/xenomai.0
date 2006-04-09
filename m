Message-ID: <443941A3.20909@domain.hid>
Date: Sun, 09 Apr 2006 19:17:23 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] GDB 6.x + simulator
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


The following patch enables GDB 6.x for the simulator. Please give this
a try if you happen to use the Xenosim. TIA,

--- sim/scope/gdbhelper.cc	(revision 904)
+++ sim/scope/gdbhelper.cc	(working copy)
@@ -423,6 +423,8 @@

      char *ibuf = gdb_ibuf.gets(), *estart = gdb_ibuf.gets();

+    Tcl_ResetResult(tclInterp);
+
      for (;;)
  	{
  	if (*ibuf == '\0' || *ibuf == '\n')
@@ -504,7 +506,7 @@
  		// the contents of the log did not match anything known to
  		// the caller. We cannot return -1, which value is reserved
  		// to indicate that the connection with GDB has been lost.
-		
+
  		Tcl_AppendElement(tclInterp,CString(rc2 ? rc2 : nre).gets());
  		Tcl_AppendElement(tclInterp,matched);
  		Tcl_AppendElement(tclInterp,Tcl_DStringValue(&gdb_ilog));
Index: sim/scope/tcl/gdb.tcl
===================================================================
--- sim/scope/tcl/gdb.tcl	(revision 904)
+++ sim/scope/tcl/gdb.tcl	(working copy)
@@ -850,8 +850,10 @@
  	regexp "\[^\"\]+.(\[^\"\]+).*" $matched mvar curfocus
      }

-    # query stack information
-    set rl [gdb:command where ls]
+    # query stack information -- auto-limit to the inner last 32
+    # frames in order to work-around the issue GDB 6.x has with
+    # ucontext(2) driven co-routines.
+    set rl [gdb:command "where 32" ls]
      set stackinfo [lindex $rl 2]

      if {$stackinfo == {}} {

-- 

Philippe.

