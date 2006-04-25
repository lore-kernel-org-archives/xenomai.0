Message-ID: <3e9157940604250015oace0df7wed795eabb6a49da0@domain.hid>
Date: Tue, 25 Apr 2006 12:45:50 +0530
From: "Deepak Joglekar" <joglekar.deepak@domain.hid>
Subject: Re: [Xenomai-help] Error while running test suit (required="sep tsc",
	present="sep", missing="tsc").
In-Reply-To: <444D0C45.1040300@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_37090_16450382.1145949350697"
References: <3e9157940604240829u22307f54v2108ff8744c4ebeb@domain.hid>
	<444D0C45.1040300@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jim Cromie <jim.cromie@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_37090_16450382.1145949350697
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

For record complete results.

1. Initally I chose i686 processor family in kernel config. and followed
instructions for kernel and xenomai compile and install.
My processor is Pentium IV on build system. My Target processor will be AMD
Geode.

I was getting following error message while running xeno-test.
-----------------------------------------------------------
Xenomai: incompatible feature set
(required=3D"sep tsc", present=3D"sep", missing=3D"tsc").
-----------------------------------------------------------

I checked /proc/cpuinfo
--------------------------------
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm pni
monitor ds_cpl est cid cx16 xtpr
--------------------------------

Then I was bit confused.

Gilles Chanteperdrix correctly pointed out error.

You should have "CONFIG_X86_TSC=3Dy" in kernel ".config" file.  It will be
selected automatically based on the Processor selected for kernel
compilation.

If you don't have this line in ".config" then one should configure the
Xenomai as
-----------------------------------
./configure --disable-tsc
-----------------------------------

When CONFIG_X86_TSC is available in kernel then on "./configure" will work
for Xenomai.

Thanks.


On 4/24/06, Jim Cromie <jim.cromie@domain.hid> wrote:
>
> Deepak Joglekar wrote:
> > Hi,
> >
> hi.
>
> For the Record, can you post your actual error messages, in context,
> so that folks who search the ML (gasp) for the "exact error message
> string"
> will find it in your post ?
>
> And it would be good to post the answer youve recieved also.
>
> tia
>

------=_Part_37090_16450382.1145949350697
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>
<br>
For record complete results.<br>
<br>
1. Initally I chose i686 processor family in kernel config. and
followed instructions for kernel and xenomai compile and install.<br>
My processor is Pentium IV on build system. My Target processor will be AMD=
 Geode. <br>
<br>
I was getting following error message while running xeno-test.<br>
-----------------------------------------------------------<br>
Xenomai: incompatible feature set<br>
(required=3D&quot;sep tsc&quot;, present=3D&quot;sep&quot;,=20
missing=3D&quot;tsc&quot;).<br>
-----------------------------------------------------------<br>
<br>
I checked /proc/cpuinfo<br>
--------------------------------<br>
flags&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : fpu vme=
 de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov=20
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm pni monitor=
=20
ds_cpl est cid cx16 xtpr <br>
--------------------------------<br>
<br>
Then I was bit confused.<br>
<br>
Gilles Chanteperdrix correctly pointed out error.<br>
<br>
You should have &quot;CONFIG_X86_TSC=3Dy&quot; in kernel &quot;.config&quot=
; file.&nbsp; It will
be selected automatically based on the Processor selected for kernel&nbsp;
compilation. <br>
<br>
If you don't have this line in &quot;.config&quot; then one should configur=
e the Xenomai as<br>
-----------------------------------<br>
./configure --disable-tsc<br>
-----------------------------------<br>
<br>
When CONFIG_X86_TSC is available in kernel then on &quot;./configure&quot; =
will work for Xenomai.<br>
<br>
Thanks.<br>
<br><br><div><span class=3D"gmail_quote">On 4/24/06, <b class=3D"gmail_send=
ername">Jim Cromie</b> &lt;<a href=3D"mailto:jim.cromie@domain.hid">jim.crom=
ie@domain.hid</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">
Deepak Joglekar wrote:<br>&gt; Hi,<br>&gt;<br>hi.<br><br>For the Record, ca=
n you post your actual error messages, in context,<br>so that folks who sea=
rch the ML (gasp) for the &quot;exact error message string&quot;<br>will fi=
nd it in your post ?
<br><br>And it would be good to post the answer youve recieved also.<br><br=
>tia<br></blockquote></div><br>

------=_Part_37090_16450382.1145949350697--

