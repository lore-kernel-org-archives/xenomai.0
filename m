Message-ID: <BAY101-W14267D7B841C080C30386DEAD70@domain.hid>
Content-Type: multipart/alternative;
	boundary="_87266f3b-b829-4bbd-a048-a41099f78f52_"
From: Stephen Davies <steve_davies61@domain.hid>
Date: Thu, 15 Jan 2009 12:38:07 +0000
In-Reply-To: <496F2281.2000102@domain.hid>
References: <BAY101-W2825402A319CC124388542EAD70@domain.hid>
	<496F2281.2000102@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Debugger Support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

--_87266f3b-b829-4bbd-a048-a41099f78f52_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi Jan=2C
=20
Thanks for your quick reply.  Just to be clear I would be able to debug har=
d real time threads using GDB with no patches applied to it?  That would be=
 a massive step forward for me!
=20
Thanks again=2C
=20
Stevee> Date: Thu=2C 15 Jan 2009 12:48:17 +0100> From: jan.kiszka@domain.hid=
om> To: steve_davies61@domain.hid> CC: xenomai@xenomai.org> Subject: Re: =
Debugger Support> > Stephen Davies wrote:> > Hi All=2C> > > > I currently h=
ave an application that runs under RTAI however I am now> > having problems=
 that I wish to debug. Debugger support for RTAI is> > limited at best (cur=
rently the only option we have is to use> > rt_printk() or printf() to the =
console). I've been looking back at> > Xenomai and I see a lot of reference=
s to LTTng support which would be> > ideal and would mean I would port my R=
TAI app to Xenomai. However> > these references seem to all die out around =
2007. Is there still> > support for a "proper" debugger (stepping through c=
ode=2C variable> > values etc...) in the current release of Xenomai?> > LTT=
ng is actively supported over Xenomai=2C we just still need additional> fid=
dling with the patch series as LTTng is not yet mainline. We are> using it =
here over 2.6.26 ATM=2C I think I just missed to post the (rather> simple) =
update from the published 2.6.24 version. And I'm about to port> them to th=
e next kernel base (either 2.6.27 or .28).> > Beside the LTTng tracer there=
 is also source-level debugging=2C of course.> gdb for the apps=2C kgdb for=
 the kernel (x86) - or via KVM=2C ie. kernel> source-level debugging inside=
 a virtual x86 machine. kgdb just needs> some extra patches which I didn't =
update to 2.6.27 yet because I'm using> KVM now.> > Jan> > -- > Siemens AG=
=2C Corporate Technology=2C CT SE 26> Corporate Competence Center Embedded =
Linux
_________________________________________________________________
Imagine a life without walls.=A0 See the possibilities
http://clk.atdmt.com/UKM/go/122465943/direct/01/=

--_87266f3b-b829-4bbd-a048-a41099f78f52_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Verdana
}
</style>
</head>
<body class=3D'hmmessage'>
Hi Jan=2C<BR>
&nbsp=3B<BR>
Thanks for your quick reply.&nbsp=3B Just to be clear I would be able to de=
bug hard real time threads using GDB with no patches applied to it?&nbsp=3B=
 That would be a massive step forward for me!<BR>
&nbsp=3B<BR>
Thanks again=2C<BR>
&nbsp=3B<BR>
Stevee<BR><BR>&gt=3B Date: Thu=2C 15 Jan 2009 12:48:17 +0100<BR>&gt=3B From=
: jan.kiszka@domain.hid<BR>&gt=3B To: steve_davies61@domain.hid<BR>&gt=3B=
 CC: xenomai@xenomai.org<BR>&gt=3B Subject: Re: Debugger Support<BR>&gt=3B=
 <BR>&gt=3B Stephen Davies wrote:<BR>&gt=3B &gt=3B Hi All=2C<BR>&gt=3B &gt=
=3B <BR>&gt=3B &gt=3B I currently have an application that runs under RTAI =
however I am now<BR>&gt=3B &gt=3B having problems that I wish to debug. Deb=
ugger support for RTAI is<BR>&gt=3B &gt=3B limited at best (currently the o=
nly option we have is to use<BR>&gt=3B &gt=3B rt_printk() or printf() to th=
e console). I've been looking back at<BR>&gt=3B &gt=3B Xenomai and I see a =
lot of references to LTTng support which would be<BR>&gt=3B &gt=3B ideal an=
d would mean I would port my RTAI app to Xenomai. However<BR>&gt=3B &gt=3B =
these references seem to all die out around 2007. Is there still<BR>&gt=3B =
&gt=3B support for a "proper" debugger (stepping through code=2C variable<B=
R>&gt=3B &gt=3B values etc...) in the current release of Xenomai?<BR>&gt=3B=
 <BR>&gt=3B LTTng is actively supported over Xenomai=2C we just still need =
additional<BR>&gt=3B fiddling with the patch series as LTTng is not yet mai=
nline. We are<BR>&gt=3B using it here over 2.6.26 ATM=2C I think I just mis=
sed to post the (rather<BR>&gt=3B simple) update from the published 2.6.24 =
version. And I'm about to port<BR>&gt=3B them to the next kernel base (eith=
er 2.6.27 or .28).<BR>&gt=3B <BR>&gt=3B Beside the LTTng tracer there is al=
so source-level debugging=2C of course.<BR>&gt=3B gdb for the apps=2C kgdb =
for the kernel (x86) - or via KVM=2C ie. kernel<BR>&gt=3B source-level debu=
gging inside a virtual x86 machine. kgdb just needs<BR>&gt=3B some extra pa=
tches which I didn't update to 2.6.27 yet because I'm using<BR>&gt=3B KVM n=
ow.<BR>&gt=3B <BR>&gt=3B Jan<BR>&gt=3B <BR>&gt=3B -- <BR>&gt=3B Siemens AG=
=2C Corporate Technology=2C CT SE 26<BR>&gt=3B Corporate Competence Center =
Embedded Linux<BR><BR><br /><hr />Choose the perfect PC or mobile phone for=
 you. <a href=3D'http://clk.atdmt.com/UKM/go/130777504/direct/01/' target=
=3D'_new'>Click here</a></body>
</html>=

--_87266f3b-b829-4bbd-a048-a41099f78f52_--

