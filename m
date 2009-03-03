MIME-Version: 1.0
In-Reply-To: <OFEBB322C4.DB1D01E7-ON6525756E.00403279-6525756E.003FD3E1@domain.hid>
References: <OF2344306C.C261A830-ON6525756E.003F50BB-6525756E.003E8F43@domain.hid>
	<f48df4840903030338r6c10d610i5b6a6cddc7e9163b@domain.hid>
	<OFEBB322C4.DB1D01E7-ON6525756E.00403279-6525756E.003FD3E1@domain.hid>
Date: Tue, 3 Mar 2009 15:21:54 +0100
Message-ID: <f48df4840903030621r74920230oa2b292631ce6db33@domain.hid>
From: Bruno Rouchouse <brouchouse@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6409b342d68f3046437a8b1
Subject: Re: [Xenomai-help] [Xenomai-core] (no subject)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Vandana Sasidharan <vandana.sasidharan@domain.hid>
Cc: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

--0016e6409b342d68f3046437a8b1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

the simulator README tells you how to build it:

Building the simulator

You will need the libelf, libpng, tcl8.x/tk8.x and tix41 _development
packages_ in order to build the simulator and its companion tools.
[...]
Since v2.1, the simulator is available as a separate tarball, distinct
from the main Xenomai archive. To build the simulator, you will also
need the latter; the simulator archive should be extracted in
Xenomai's main source tree under the sim/ sub-directory. The following
steps should be followed in order to build and install the simulation
system:

# $xenomai_tar: Main Xenomai tarball
# $xenosim_tar: Simulator tarball
# $xenomai_src: Root of Xenomai's source tree after extraction
# $sim_builddir: Build root for the simulator
# $sim_installdir: Installation directory for the simulator;
# (usually, the same place than used for Xenomai's main system).
# gcc_tarball: Path to a GCC 2.95.3 source archive.

$ tar jxf $xenomai_tar
$ cd xenomai-2.X.Y
$ tar jxf $xenosim_tar
$ mkdir $sim_builddir && cd $sim_builddir
$ $xenomai_src/xenosim-X.Y.Z/configure --prefix=$sim_installdir
--with-gcc-tarball=$gcc_tarball
$ make install

Note that I haven't built it for a long time but I know core developers use
it to implement and debug skins.

Please keep the mailing-list in the loop and note that xenomai-help is
probaby more suitable in this case.

--BR

2009/3/3 Vandana Sasidharan <vandana.sasidharan@domain.hid>

>
>
> hi bruno
>
> thanks but i have gone through these docs.
> I want to know how can i make this xenosim or MVM run on a fedora core?
>
> =====-----=====-----=====
> Notice: The information contained in this e-mail
> message and/or attachments to it may contain
> confidential or privileged information. If you are
> not the intended recipient, any dissemination, use,
> review, distribution, printing or copying of the
> information contained in this e-mail message
> and/or attachments to it are strictly prohibited. If
> you have received this communication in error,
> please notify us by reply e-mail or telephone and
> immediately and permanently delete the message
> and any attachments. Thank you
>
>
>
>

--0016e6409b342d68f3046437a8b1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>the simulator README tells you how to build it: <br><pre style=
=3D"font-family: arial,helvetica,sans-serif;"><font size=3D"2">Building the=
 simulator<br><br>You will need the libelf, libpng, tcl8.x/tk8.x and tix41 =
_development<br>
packages_ in order to build the simulator and its companion tools.<br>[...]=
<br>Since v2.1, the simulator is available as a separate tarball, distinct<=
br>from the main Xenomai archive. To build the simulator, you will also<br>
need the latter; the simulator archive should be extracted in<br>Xenomai&#3=
9;s main source tree under the sim/ sub-directory. The following<br>steps s=
hould be followed in order to build and install the simulation<br>system:<b=
r>
<br># $xenomai_tar: Main Xenomai tarball<br># $xenosim_tar: Simulator tarba=
ll<br># $xenomai_src: Root of Xenomai&#39;s source tree after extraction<br=
># $sim_builddir: Build root for the simulator<br># $sim_installdir: Instal=
lation directory for the simulator;<br>
# (usually, the same place than used for Xenomai&#39;s main system).<br># g=
cc_tarball: Path to a GCC 2.95.3 source archive.<br><br>$ tar jxf $xenomai_=
tar<br>$ cd xenomai-2.X.Y<br>$ tar jxf $xenosim_tar<br>$ mkdir $sim_builddi=
r &amp;&amp; cd $sim_builddir<br>
$ $xenomai_src/xenosim-X.Y.Z/configure --prefix=3D$sim_installdir --with-gc=
c-tarball=3D$gcc_tarball<br>$ make install<br></font></pre>Note that I have=
n&#39;t built it for a long time but I know core developers use it to imple=
ment and debug skins.<br>
<br>Please keep the mailing-list in the loop and note that xenomai-help is =
probaby more suitable in this case.<br><br>--BR<br><br><div class=3D"gmail_=
quote">2009/3/3 Vandana Sasidharan <span dir=3D"ltr">&lt;<a href=3D"mailto:=
vandana.sasidharan@domain.hid">vandana.sasidharan@domain.hid</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br><font size=3D"2" face=3D"sans-serif"><br>
hi bruno</font>
<br>
<br><font size=3D"2" face=3D"sans-serif">thanks but i have gone through the=
se
docs.</font>
<br><font size=3D"2" face=3D"sans-serif">I want to know how can i make this=
 xenosim
or MVM run on a fedora core?</font><div><div></div><div class=3D"h5"><pre>=
=3D=3D=3D=3D=3D-----=3D=3D=3D=3D=3D-----=3D=3D=3D=3D=3D
Notice: The information contained in this e-mail
message and/or attachments to it may contain=20
confidential or privileged information. If you are=20
not the intended recipient, any dissemination, use,=20
review, distribution, printing or copying of the=20
information contained in this e-mail message=20
and/or attachments to it are strictly prohibited. If=20
you have received this communication in error,=20
please notify us by reply e-mail or telephone and=20
immediately and permanently delete the message=20
and any attachments. Thank you


</pre></div></div></blockquote></div><br>

--0016e6409b342d68f3046437a8b1--

