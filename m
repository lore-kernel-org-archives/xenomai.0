Message-ID: <BAY135-W17043C9D8D088770CB0748C6F40@domain.hid>
Content-Type: multipart/alternative;
	boundary="_a1f90a55-fd92-4eab-9998-74768e118531_"
From: Thomas Schaefer <thomas_schaefer_canada@domain.hid>
Date: Mon, 15 Dec 2008 08:13:35 -0700
MIME-Version: 1.0
Subject: [Xenomai-help] BUG: soft lockup
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--_a1f90a55-fd92-4eab-9998-74768e118531_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi=2C I am trying to use kernel version 2.6.27.8 and the latest stable vers=
ion of xenomai 2.4.6.1 on a quad core xeon 5400. The kernel seems to load O=
K.[    1.306673] I-pipe: Domain Xenomai registered.[    1.311242] Xenomai: =
hal/x86_64 started.[    1.316744] Xenomai: real-time nucleus v2.4.6 (Bamboo=
) loaded.[    1.322786] Xenomai: starting native API services.[    1.327580=
] Xenomai: starting POSIX services.[    1.331973] Xenomai: starting RTDM se=
rvices. But as soon as init starts the PC hangs in an endlass loop and I ge=
t:[   69.793501] BUG: soft lockup - CPU#3 stuck for 61s! [init:1][   69.793=
501] Modules linked in:[   69.793501] CPU 3:[   69.793501] Modules linked i=
n:[   69.793501] Pid: 1=2C comm: init Not tainted 2.6.27.8 #1[   69.793501]=
 RIP: 0010:[<ffffffff8021de25>]  [<ffffffff8021de25>] native_flush_tlb_othe=
rs+0xa5/0xe0[   69.793501] RSP: 0000:ffff88007f849c58  EFLAGS: 00000202[   =
69.793501] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000000000=
0[   69.793501] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000=
000000[   69.793501] RBP: ffff88007f840000 R08: 0000000000000000 R09: 00000=
00000000000[   69.793501] R10: 0000000000000000 R11: 0000000000000000 R12: =
0000000000000000[   69.793501] R13: 0000000000000000 R14: 0000000000000000 =
R15: 0000000000000000[   69.793501] FS:  00007fbcbf7486e0(0000) GS:ffff8800=
7f806a80(0000) knlGS:0000000000000000[   69.793501] CS:  0010 DS: 0000 ES: =
0000 CR0: 000000008005003b[   69.793501] CR2: 0000000000672b08 CR3: 0000000=
07eb84000 CR4: 00000000000006e0[   69.793501] DR0: 0000000000000000 DR1: 00=
00000000000000 DR2: 0000000000000000[   69.793501] DR3: 0000000000000000 DR=
6: 00000000ffff0ff0 DR7: 0000000000000400[   69.793501][   69.793501] Call =
Trace:[   69.793501]The kernel runs fine without the Xenomai patch.
I also tried the version in the current svn repository with the same result=
.
Please let me know you what I can do to help to fix this or what additional=
 info I should provide. Regards=2CThomas Schaefer
_________________________________________________________________


--_a1f90a55-fd92-4eab-9998-74768e118531_
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
Hi=2C<BR>&nbsp=3B<BR>I am trying to use kernel version 2.6.27.8 and the lat=
est stable version of xenomai 2.4.6.1 on a quad core xeon 5400.<BR>&nbsp=3B=
<BR>The kernel seems to load OK.<BR>[&nbsp=3B&nbsp=3B&nbsp=3B 1.306673] I-p=
ipe: Domain Xenomai registered.<BR>[&nbsp=3B&nbsp=3B&nbsp=3B 1.311242] Xeno=
mai: hal/x86_64 started.<BR>[&nbsp=3B&nbsp=3B&nbsp=3B 1.316744] Xenomai: re=
al-time nucleus v2.4.6 (Bamboo) loaded.<BR>[&nbsp=3B&nbsp=3B&nbsp=3B 1.3227=
86] Xenomai: starting native API services.<BR>[&nbsp=3B&nbsp=3B&nbsp=3B 1.3=
27580] Xenomai: starting POSIX services.<BR>[&nbsp=3B&nbsp=3B&nbsp=3B 1.331=
973] Xenomai: starting RTDM services.<BR>&nbsp=3B<BR>But as soon as init st=
arts the PC hangs in an endlass&nbsp=3Bloop and I get:<BR>[&nbsp=3B&nbsp=3B=
 69.793501] BUG: soft lockup - CPU#3 stuck for 61s! [init:1]<BR>[&nbsp=3B&n=
bsp=3B 69.793501] Modules linked in:<BR>[&nbsp=3B&nbsp=3B 69.793501] CPU 3:=
<BR>[&nbsp=3B&nbsp=3B 69.793501] Modules linked in:<BR>[&nbsp=3B&nbsp=3B 69=
.793501] Pid: 1=2C comm: init Not tainted 2.6.27.8 #1<BR>[&nbsp=3B&nbsp=3B =
69.793501] RIP: 0010:[&lt=3Bffffffff8021de25&gt=3B]&nbsp=3B [&lt=3Bffffffff=
8021de25&gt=3B] native_flush<BR>_tlb_others+0xa5/0xe0<BR>[&nbsp=3B&nbsp=3B =
69.793501] RSP: 0000:ffff88007f849c58&nbsp=3B EFLAGS: 00000202<BR>[&nbsp=3B=
&nbsp=3B 69.793501] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000=
0000000000<BR>[&nbsp=3B&nbsp=3B 69.793501] RDX: 0000000000000000 RSI: 00000=
00000000000 RDI: 0000000000000000<BR>[&nbsp=3B&nbsp=3B 69.793501] RBP: ffff=
88007f840000 R08: 0000000000000000 R09: 0000000000000000<BR>[&nbsp=3B&nbsp=
=3B 69.793501] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00000<BR>[&nbsp=3B&nbsp=3B 69.793501] R13: 0000000000000000 R14: 0000000000=
000000 R15: 0000000000000000<BR>[&nbsp=3B&nbsp=3B 69.793501] FS:&nbsp=3B 00=
007fbcbf7486e0(0000) GS:ffff88007f806a80(0000) knlGS:00000<BR>00000000000<B=
R>[&nbsp=3B&nbsp=3B 69.793501] CS:&nbsp=3B 0010 DS: 0000 ES: 0000 CR0: 0000=
00008005003b<BR>[&nbsp=3B&nbsp=3B 69.793501] CR2: 0000000000672b08 CR3: 000=
000007eb84000 CR4: 00000000000006e0<BR>[&nbsp=3B&nbsp=3B 69.793501] DR0: 00=
00000000000000 DR1: 0000000000000000 DR2: 0000000000000000<BR>[&nbsp=3B&nbs=
p=3B 69.793501] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000=
000400<BR>[&nbsp=3B&nbsp=3B 69.793501]<BR>[&nbsp=3B&nbsp=3B 69.793501] Call=
 Trace:<BR>[&nbsp=3B&nbsp=3B 69.793501]<BR><BR>The kernel runs fine without=
 the Xenomai patch.<BR>
I also tried the version in the current svn repository with the same result=
.<BR>
Please let me know&nbsp=3Byou what I can do to help to fix this or what add=
itional info&nbsp=3BI should provide.<BR>&nbsp=3B<BR>Regards=2C<BR>Thomas S=
chaefer<BR><BR><RTE_TEXT></RTE_TEXT><br /><hr />Visit messengerbuddies.ca t=
o find out how you could win. <a href=3D'http://www.messengerbuddies.ca/?oc=
id=3DBUDDYOMATICENCA20' target=3D'_new'>Enter today.</a></body>
</html>=

--_a1f90a55-fd92-4eab-9998-74768e118531_--

