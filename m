Message-ID: <846584.44873.qm@domain.hid>
Date: Mon, 4 May 2009 22:45:42 -0700 (PDT)
From: luan dinh <dinhluanbmt@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1107557562-1241502342=:44873"
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
To: "xenomai@xenomai.org" <xenomai@xenomai.org>


--0-1107557562-1241502342=:44873
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Dear all.
i finished build a program and run it in xenomai. now i want to build it as=
 shared library.
i use following commands=A0 to create library file (.so ) from object file =
(.o)   =20
    gcc -shared -Wl,-soname,libctest.so.1 -o libctest.so.1.0   *.o
    mv libctest.so.1.0 /opt/lib
    ln -sf /opt/lib/libctest.so.1.0 /opt/lib/libctest.so
    ln -sf /opt/lib/libctest.so.1.0 /opt/lib/libctest.so.1
after that i write TEST program and use fuctions which my library
support. i can build and run TEST program but some functions in
my library doen't work ....
how to build and use my shared library in xenomai?
Thanks for any help.
Luan Dinh

=0A=0A=0A      
--0-1107557562-1241502342=:44873
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;"><font size=3D"3"><span style=3D"font-family: =
times new roman,new york,times,serif;">Dear all.</span><br style=3D"font-fa=
mily: times new roman,new york,times,serif;"><span style=3D"font-family: ti=
mes new roman,new york,times,serif;">i finished build a program and run it =
in xenomai. now i want to build it as shared library.</span><br style=3D"fo=
nt-family: times new roman,new york,times,serif;"></font><span style=3D"fon=
t-family: times new roman,new york,times,serif;"><font size=3D"3">i use fol=
lowing commands&nbsp; to create library file (.so ) from object file (.o</f=
ont>)    </span><br style=3D"font-family: times new roman,new york,times,se=
rif;"><pre>    gcc -shared -Wl,-soname,libctest.so.1 -o libctest.so.1.0   *=
.o<br>    mv libctest.so.1.0 /opt/lib<br>    ln -sf /opt/lib/libctest.so.1.=
0 /opt/lib/libctest.so<br>    ln -sf /opt/lib/libctest.so.1.0 /opt/lib/libc=
test.so.1<br><font
 size=3D"4"><span style=3D"font-family: times new roman,new york,times,seri=
f;">after that i write TEST program and use fuctions which my library</span=
><br style=3D"font-family: times new roman,new york,times,serif;"><span sty=
le=3D"font-family: times new roman,new york,times,serif;">support. i can bu=
ild and run TEST program but some functions in</span><br style=3D"font-fami=
ly: times new roman,new york,times,serif;"><span style=3D"font-family: time=
s new roman,new york,times,serif;">my library doen't work ....</span><br st=
yle=3D"font-family: times new roman,new york,times,serif;"><span style=3D"f=
ont-family: times new roman,new york,times,serif;">how to build and use my =
shared library in xenomai?</span><br style=3D"font-family: times new roman,=
new york,times,serif;"><span style=3D"font-family: times new roman,new york=
,times,serif;">Thanks for any help.</span><br style=3D"font-family: times n=
ew roman,new york,times,serif;"><span style=3D"font-family: times new roman=
,new
 york,times,serif;">Luan Dinh</span><br style=3D"font-family: times new rom=
an,new york,times,serif;"></font></pre><br></td></tr></table><br>=0A=0A=0A=
=0A      
--0-1107557562-1241502342=:44873--

