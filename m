Message-ID: <947771.75970.qm@domain.hid>
References: <528683.58306.qm@domain.hid>
	<4DE5D869.9040307@domain.hid>
Date: Wed, 1 Jun 2011 00:04:23 -0700 (PDT)
From: sanjay anvekar <sanjayanvekar@domain.hid>
In-Reply-To: <4DE5D869.9040307@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-444113069-1306911863=:75970"
Subject: Re: [Xenomai-help] help-IntelAtom
Reply-To: sanjay anvekar <sanjayanvekar@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

--0-444113069-1306911863=:75970
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Gilles,=0A=A0=A0=A0=A0 Thank you very much for your quick reply. I tried=
 replacing latest 'lib' files into my 'Initramfs' and Xenomai=0Aclocktest w=
orked fine. I will start my RTOS porting now.=0A=0AThanks again.=0A=0ABest =
Regards,=0ASanjay=0A=0A=0A=0A________________________________=0AFrom: Gille=
s Chanteperdrix <gilles.chanteperdrix@xenomai.org>=0ATo: sanjay anvekar <sa=
njayanvekar@domain.hid>=0ACc: "xenomai@xenomai.org" <xenomai@xenomai.org>=
=0ASent: Wednesday, 1 June 2011 11:42 AM=0ASubject: Re: [Xenomai-help] help=
-IntelAtom=0A=0AOn 06/01/2011 07:35 AM, sanjay anvekar wrote:=0A> Hi,=0A>=
=A0 =A0 =A0 I am facing problem running Xenomai test programs and it gives =
me following error.=0A>> clocktest=0A>> /usr/xenomai/bin/clocktest: error w=
hile loading shared libraries: /usr/xenomai/lib/libpthread_rt.so.1: ELF fil=
e OS ABI invalid=0A> =0A> similar error is seen when I try to run latency o=
r any other Xenomai test program.=0A=0AThere is no need to try 100 differen=
t things. First try to compile=0AXenomai and run the tests it contains. If =
that does not work, no need to=0Ago further.=0A=0AThe problem you have seem=
s to be a toolchain problem: the toolchain you=0Ause does not seem to corre=
spond to the libraries installed. Where does=0Athe libc you use come from? =
Where does the toolchain you use come from?=0A=0A-- =0A=A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Gilles.
--0-444113069-1306911863=:75970
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ti=
mes new roman, new york, times, serif;font-size:12pt"><div><span>Hi Gilles,=
</span></div><div><span>&nbsp;&nbsp;&nbsp;&nbsp; Thank you very much for yo=
ur quick reply. I tried replacing latest 'lib' files into my 'Initramfs' an=
d Xenomai</span></div><div><span>clocktest worked fine. I will start my RTO=
S porting now.<br></span></div><div><span>Thanks again.</span></div><div><b=
r><span></span></div><div><span>Best Regards,</span></div><div><span>Sanjay=
<br></span></div><div><br></div><div style=3D"font-family: times new roman,=
new york,times,serif; font-size: 12pt;"><div style=3D"font-family: times ne=
w roman,new york,times,serif; font-size: 12pt;"><font face=3D"Arial" size=
=3D"2"><hr size=3D"1"><b><span style=3D"font-weight: bold;">From:</span></b=
> Gilles Chanteperdrix &lt;gilles.chanteperdrix@xenomai.org&gt;<br><b><span=
 style=3D"font-weight: bold;">To:</span></b> sanjay anvekar
 &lt;sanjayanvekar@domain.hid&gt;<br><b><span style=3D"font-weight: bold;">C=
c:</span></b> "xenomai@xenomai.org" &lt;xenomai@xenomai.org&gt;<br><b><sp=
an style=3D"font-weight: bold;">Sent:</span></b> Wednesday, 1 June 2011 11:=
42 AM<br><b><span style=3D"font-weight: bold;">Subject:</span></b> Re: [Xen=
omai-help] help-IntelAtom<br></font><br>On 06/01/2011 07:35 AM, sanjay anve=
kar wrote:<br>&gt; Hi,<br>&gt;&nbsp; &nbsp; &nbsp; I am facing problem runn=
ing Xenomai test programs and it gives me following error.<br>&gt;&gt; cloc=
ktest<br>&gt;&gt; /usr/xenomai/bin/clocktest: error while loading shared li=
braries: /usr/xenomai/lib/libpthread_rt.so.1: ELF file OS ABI invalid<br>&g=
t; <br>&gt; similar error is seen when I try to run latency or any other Xe=
nomai test program.<br><br>There is no need to try 100 different things. Fi=
rst try to compile<br>Xenomai and run the tests it contains. If that does n=
ot work, no need to<br>go further.<br><br>The problem you have seems to be
 a toolchain problem: the toolchain you<br>use does not seem to correspond =
to the libraries installed. Where does<br>the libc you use come from? Where=
 does the toolchain you use come from?<br><br>-- <br>&nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Gilles.<br><br><br></di=
v></div></div></body></html>
--0-444113069-1306911863=:75970--

