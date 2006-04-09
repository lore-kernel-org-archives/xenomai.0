Message-ID: <f48df4840604091304k5d66a8c9mb02c5de8c4ddb624@domain.hid>
Date: Sun, 9 Apr 2006 22:04:04 +0200
From: "Bruno Rouchouse" <brouchouse@domain.hid>
Subject: Re: [Xenomai-core] GDB 6.x + simulator
In-Reply-To: <443941A3.20909@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_8812_12297492.1144613044021"
References: <443941A3.20909@domain.hid>
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

------=_Part_8812_12297492.1144613044021
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Works fine here now with gdb 6.3 and svn trunk version.

Thanks !

--
Bruno


On 4/9/06, Philippe Gerum <rpm@xenomai.org> wrote:
>
>
> The following patch enables GDB 6.x for the simulator. Please give this
> a try if you happen to use the Xenosim. TIA,
>
> --- sim/scope/gdbhelper.cc      (revision 904)
> +++ sim/scope/gdbhelper.cc      (working copy)
> @@ -423,6 +423,8 @@
>
>       char *ibuf =3D gdb_ibuf.gets(), *estart =3D gdb_ibuf.gets();
>
> +    Tcl_ResetResult(tclInterp);
> +
>       for (;;)
>         {
>         if (*ibuf =3D=3D '\0' || *ibuf =3D=3D '\n')
> @@ -504,7 +506,7 @@
>                 // the contents of the log did not match anything known t=
o
>                 // the caller. We cannot return -1, which value is
> reserved
>                 // to indicate that the connection with GDB has been lost=
.
> -
> +
>                 Tcl_AppendElement(tclInterp,CString(rc2 ? rc2 :
> nre).gets());
>                 Tcl_AppendElement(tclInterp,matched);
>                 Tcl_AppendElement(tclInterp,Tcl_DStringValue(&gdb_ilog));
> Index: sim/scope/tcl/gdb.tcl
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- sim/scope/tcl/gdb.tcl       (revision 904)
> +++ sim/scope/tcl/gdb.tcl       (working copy)
> @@ -850,8 +850,10 @@
>         regexp "\[^\"\]+.(\[^\"\]+).*" $matched mvar curfocus
>       }
>
> -    # query stack information
> -    set rl [gdb:command where ls]
> +    # query stack information -- auto-limit to the inner last 32
> +    # frames in order to work-around the issue GDB 6.x has with
> +    # ucontext(2) driven co-routines.
> +    set rl [gdb:command "where 32" ls]
>       set stackinfo [lindex $rl 2]
>
>       if {$stackinfo =3D=3D {}} {
>
> --
>
> Philippe.
>
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
>

------=_Part_8812_12297492.1144613044021
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Works fine here now with gdb 6.3 and svn trunk version.<br>
<br>
Thanks !<br>
<br>
--<br>
Bruno<br>
<br><br><div><span class=3D"gmail_quote">On 4/9/06, <b class=3D"gmail_sende=
rname">Philippe Gerum</b> &lt;<a href=3D"mailto:rpm@xenomai.org">rpm@xenomai.org=
i.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"borde=
r-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-le=
ft: 1ex;">
<br>The following patch enables GDB 6.x for the simulator. Please give this=
<br>a try if you happen to use the Xenosim. TIA,<br><br>--- sim/scope/gdbhe=
lper.cc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(revision 904)<br>+++ sim/scope/=
gdbhelper.cc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(working copy)
<br>@@ -423,6 +423,8 @@<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;char *ib=
uf =3D gdb_ibuf.gets(), *estart =3D gdb_ibuf.gets();<br><br>+&nbsp;&nbsp;&n=
bsp;&nbsp;Tcl_ResetResult(tclInterp);<br>+<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;for (;;)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{<br>&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (*ibuf =3D=3D '\0' || *ibuf=
 =3D=3D '\n')<br>@@ -504,7 +506,7 @@
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;//
the contents of the log did not match anything known to<br>&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;//
the caller. We cannot return -1, which value is reserved<br>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;//
to indicate that the connection with GDB has been lost.<br>-<br>+<br>&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;Tcl_AppendElement(tclInterp,CString(rc2 ? rc2 : nre).gets())=
;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;Tcl_AppendElement(tclInterp,matched);<br>&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;Tcl_AppendElement(tclInterp,Tcl_DStringValue(&amp;gdb_ilog));
<br>Index: sim/scope/tcl/gdb.tcl<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D<br>--- sim/scope/tcl/gdb.tcl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; (revision 904)<br>+++ sim/scope/tcl/gdb.tcl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (working copy)<br>@@ -850,8 +850,10 @@
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;regexp &quot;\[^\&quot;=
\]+.(\[^\&quot;\]+).*&quot; $matched mvar curfocus<br>&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;}<br><br>-&nbsp;&nbsp;&nbsp;&nbsp;# query stack information<=
br>-&nbsp;&nbsp;&nbsp;&nbsp;set rl [gdb:command where ls]<br>+&nbsp;&nbsp;&=
nbsp;&nbsp;# query stack information -- auto-limit to the inner last 32
<br>+&nbsp;&nbsp;&nbsp;&nbsp;# frames in order to work-around the issue GDB=
 6.x has with<br>+&nbsp;&nbsp;&nbsp;&nbsp;# ucontext(2) driven co-routines.=
<br>+&nbsp;&nbsp;&nbsp;&nbsp;set rl [gdb:command &quot;where 32&quot; ls]<b=
r>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;set stackinfo [lindex $rl 2]<br><br>&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if {$stackinfo =3D=3D {}} {
<br><br>--<br><br>Philippe.<br><br>________________________________________=
_______<br>Xenomai-core mailing list<br><a href=3D"mailto:Xenomai-core@domain.hid.=
org">Xenomai-core@domain.hid</a><br><a href=3D"https://mail.gna.org/listinfo/x=
enomai-core">
https://mail.gna.org/listinfo/xenomai-core</a><br></blockquote></div><br>

------=_Part_8812_12297492.1144613044021--

