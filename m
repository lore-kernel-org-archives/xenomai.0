Message-ID: <296208.73890.qm@domain.hid>
Date: Mon, 4 May 2009 23:36:33 -0700 (PDT)
From: luan dinh <dinhluanbmt@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1631689489-1241505393=:73890"
Subject: [Xenomai-help] shared library in xenomai ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thomas Lockhart <Thomas.Lockhart@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


--0-1631689489-1241505393=:73890
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

hi.
this is my problem :
i write a program which use raw socket and rteth0 NIC card to send data. wh=
en i build=A0 as application it run well. then i build this program as shar=
ed libarary named=A0 libctest.so support send() function to send data
the command to build shared lib similar to :
    gcc -shared -Wl,-soname,libctest.so.1 -o libctest.so.1.0   *.o
    mv libctest.so.1.0 /opt/lib
    ln -sf /opt/lib/libctest.so.1.0 /opt/lib/libctest.so
    ln -sf /opt/lib/libctest.so.1.0 /opt/lib/libctest.so.1=20
i write a TEST program use the send() function which supported by=A0 my lib=
rary.
the command to build TEST program similar to :
gcc <xenomai options> prog.c -lctest -o TEST
when i execute by command ./TEST
the TEST program still run. the send() function seem to be right but no dat=
a sent to network adapter

Luan Dinh





=0ADid you try running ldd on your built library to make sure that the=0Ali=
nking is finding all of the dependencies? Or please clarify what does=0Anot=
 seem to be working for you...
=0A
=0Ahth
=0A
=0A=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - Tom
=0A
=0A--=20
=0AThomas Lockhart
=0ASupervisor, Distributed and Real-time Group
=0AInstrument Software and Science Data Systems
=0ACaltech/JPL
=0A
=0A =0A=0A=0A=0A      
--0-1631689489-1241505393=:73890
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">hi.<br>this is my problem :<br>i write a prog=
ram which use raw socket and rteth0 NIC card to send data. when i build&nbs=
p; as application it run well. then i build this program as shared libarary=
 named&nbsp; libctest.so support send() function to send data<br>the comman=
d to build shared lib similar to :<br><pre>    gcc -shared -Wl,-soname,libc=
test.so.1 -o libctest.so.1.0   *.o<br>    mv libctest.so.1.0 /opt/lib<br>  =
  ln -sf /opt/lib/libctest.so.1.0 /opt/lib/libctest.so<br>    ln -sf /opt/l=
ib/libctest.so.1.0 /opt/lib/libctest.so.1 <br></pre>i write a TEST program =
use the send() function which supported by&nbsp; my library.<br>the command=
 to build TEST program similar to :<br><pre>gcc &lt;xenomai options&gt; pro=
g.c -lctest -o TEST<br></pre>when i execute by command ./TEST<br>the TEST p=
rogram still run. the send() function seem to be right but no data sent to
 network adapter<br><br>Luan Dinh<br><br><pre><br></pre><br><br><blockquote=
 style=3D"border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; paddin=
g-left: 5px;"><div id=3D"yiv1527271202"><br>=0ADid you try running ldd on y=
our built library to make sure that the=0Alinking is finding all of the dep=
endencies? Or please clarify what does=0Anot seem to be working for you...<=
br>=0A<br>=0Ahth<br>=0A<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; - Tom<br>=0A<br>=0A-- <br>=0AThomas Lockhart<br>=0ASupervisor, Di=
stributed and Real-time Group<br>=0AInstrument Software and Science Data Sy=
stems<br>=0ACaltech/JPL<br>=0A<br>=0A =0A</div></blockquote></td></tr></tab=
le><br>=0A=0A      
--0-1631689489-1241505393=:73890--

