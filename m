Date: Wed, 28 Mar 2018 17:40:28 +0300 (EEST)
From: =?windows-1251?B?2OXi9+Xt6u4g0uDw4PEgw/Do4+7w/OXi6Pc=?=
 <shevchenko.taras@triolcorp.com.ua>
Message-ID: <606498428.8491423.1522248028355.JavaMail.zimbra@triolcorp.com.ua>
In-Reply-To: <1320247074.8207767.1522165874048.JavaMail.zimbra@triolcorp.com.ua>
References: <q17d41v98jmvc5qofdfiipjs.1522164993072@embeddedgreg.com>
 <289250163.8206221.1522165279222.JavaMail.zimbra@triolcorp.com.ua>
 <1221098029.8207596.1522165832579.JavaMail.zimbra@triolcorp.com.ua>
 <1320247074.8207767.1522165874048.JavaMail.zimbra@triolcorp.com.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] 4.9 for x86 issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: xenomai <xenomai@xenomai.org>

Hi!
I found in boot log=20
failed to start lsb apparmor initialization
could it be the problem ?

=D1 =F3=E2=E0=E6=E5=ED=E8=E5=EC =E8 =ED=E0=E4=E5=E6=E4=EE=E9 =ED=E0 =F1=EE=
=F2=F0=F3=E4=ED=E8=F7=E5=F1=F2=E2=EE,
=D8=E5=E2=F7=E5=ED=EA=EE =D2.=C3.

----- Original Message -----
From: "=D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1 =C3=F0=E8=E3=EE=F0=FC=E5=E2=
=E8=F7" <shevchenko.taras@triolcorp.com.ua>
To: "Greg Gallagher" <greg@embeddedgreg.com>
Sent: Tuesday, March 27, 2018 6:51:14 PM
Subject: Re: [Xenomai] 4.9 for x86 issue

Maybe you need some additional output ?

=D1 =F3=E2=E0=E6=E5=ED=E8=E5=EC =E8 =ED=E0=E4=E5=E6=E4=EE=E9 =ED=E0 =F1=EE=
=F2=F0=F3=E4=ED=E8=F7=E5=F1=F2=E2=EE,
=D8=E5=E2=F7=E5=ED=EA=EE =D2.=C3.

----- Original Message -----
From: "=D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1 =C3=F0=E8=E3=EE=F0=FC=E5=E2=
=E8=F7" <shevchenko.taras@triolcorp.com.ua>
To: "Greg Gallagher" <greg@embeddedgreg.com>
Sent: Tuesday, March 27, 2018 6:50:32 PM
Subject: Re: [Xenomai] 4.9 for x86 issue

yeti@yeti-UDOO-x86:~$ uname -a
Linux yeti-UDOO-x86 4.9.90 #1 SMP Tue Mar 27 12:22:27 EEST 2018 x86_64 x86_=
64 x86_64 GNU/Linux
yeti@yeti-UDOO-x86:~$ lsb_release -a
No LSB modules are available.
Distributor ID:=09Ubuntu
Description:=09Ubuntu 16.04.4 LTS
Release:=0916.04
Codename:=09xenial

yeti@yeti-UDOO-x86:~$ lsmod |grep sd    - nothing
yeti@yeti-UDOO-x86:~$=20



I enable mmc debug option at kernel   - get many messages like below  dmesg=
 output
ipipe patch apply, xenomai not installed , without sdcard inserted

[sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   58.591263] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   58.591280] mmc0: req done <CMD23>: 0: 00000000 00000000 00000000 000000=
00
[   58.591284] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 000000=
00
[   58.591287] mmc0:     4096 bytes transferred: 0
[   58.591291] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   58.591319] mmc0: starting CMD13 arg 00010000 flags 00000195
[   58.591352] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   58.591367] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 000000=
00
[   58.594591] <mmc0: starting CMD23 arg 00000008 flags 00000015>
[   58.594597] mmc0: starting CMD18 arg 000bba38 flags 000000b5
[   58.594601] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac=
 0
[   58.594604] mmc0:     CMD12 arg 00000000 flags 00000095
[   58.594640] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   58.594882] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   58.594898] mmc0: req done <CMD23>: 0: 00000000 00000000 00000000 000000=
00
[   58.594902] mmc0: req done (CMD18): 0: 00000900 00000000 00000000 000000=
00
[   58.594905] mmc0:     4096 bytes transferred: 0
[   58.594908] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   58.624730] <mmc0: starting CMD23 arg 00000020 flags 00000015>
[   58.624735] mmc0: starting CMD18 arg 018be070 flags 000000b5
[   58.624740] mmc0:     blksz 512 blocks 32 flags 00000200 tsac 100 ms nsa=
c 0
[   58.624743] mmc0:     CMD12 arg 00000000 flags 00000095
[   58.624777] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[   58.625185] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[   58.625211] mmc0: req done <CMD23>: 0: 00000000 00000000 00000000 000000=
00
[   58.625216] mmc0: req done (CMD18): 0: 00000900 00000000 00000000 000000=
00
[   58.625219] mmc0:     16384 bytes transferred: 0
[   58.625222] mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
[   58.625749] <mmc0: starting CMD23 arg 00000058 flags 00000015>
[   58.625753] mmc0: starting CMD18 arg 018be090 flags 000000b5
[   58.625757] mmc0:     blksz 512 blocks 88 flags 00000200 tsac 100 ms nsa=
c 0
[   58.625760] mmc0:     CMD12 arg 00000000 flags 00000095



=D1 =F3=E2=E0=E6=E5=ED=E8=E5=EC =E8 =ED=E0=E4=E5=E6=E4=EE=E9 =ED=E0 =F1=EE=
=F2=F0=F3=E4=ED=E8=F7=E5=F1=F2=E2=EE,
=D8=E5=E2=F7=E5=ED=EA=EE =D2.=C3.

----- Original Message -----
From: "=D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1 =C3=F0=E8=E3=EE=F0=FC=E5=E2=
=E8=F7" <shevchenko.taras@triolcorp.com.ua>
To: "Greg Gallagher" <greg@embeddedgreg.com>
Sent: Tuesday, March 27, 2018 6:41:19 PM
Subject: Re: [Xenomai] 4.9 for x86 issue

ok

yes, UDOO x86 ULTRA
https://www.udoo.org/docs-x86/Introduction/Introduction.html
gpio   https://github.com/torvalds/linux/blob/master/drivers/pinctrl/intel/=
pinctrl-cherryview.c

=D1 =F3=E2=E0=E6=E5=ED=E8=E5=EC =E8 =ED=E0=E4=E5=E6=E4=EE=E9 =ED=E0 =F1=EE=
=F2=F0=F3=E4=ED=E8=F7=E5=F1=F2=E2=EE,
=D8=E5=E2=F7=E5=ED=EA=EE =D2.=C3.

----- Original Message -----
From: "Greg Gallagher" <greg@embeddedgreg.com>
To: "=D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1 =C3=F0=E8=E3=EE=F0=FC=E5=E2=
=E8=F7" <shevchenko.taras@triolcorp.com.ua>
Sent: Tuesday, March 27, 2018 6:36:33 PM
Subject: Re: [Xenomai] 4.9 for x86 issue

For now I'll just see what is the scope of the work. The gpio I'm pretty fa=
miliar with, the sdcard shouldn't be too bad. I'm not familiar with RTNET t=
hat much but I'll see what I can do.

Sent via the BlackBerry Hub for Android

=A0 Original Message =A0
From: shevchenko.taras@triolcorp.com.ua
Sent: March 27, 2018 11:34 AM
To: greg@embeddedgreg.com
Subject: Re: [Xenomai] 4.9 for x86 issue

do you mean remote access ? teamwiever ?

=D1 =F3=E2=E0=E6=E5=ED=E8=E5=EC =E8 =ED=E0=E4=E5=E6=E4=EE=E9 =ED=E0 =F1=EE=
=F2=F0=F3=E4=ED=E8=F7=E5=F1=F2=E2=EE,
=D8=E5=E2=F7=E5=ED=EA=EE =D2.=C3.

----- Original Message -----
From: "Greg Gallagher" <greg@embeddedgreg.com>
To: "=D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1 =C3=F0=E8=E3=EE=F0=FC=E5=E2=
=E8=F7" <shevchenko.taras@triolcorp.com.ua>
Sent: Tuesday, March 27, 2018 6:31:04 PM
Subject: Re: [Xenomai] 4.9 for x86 issue

Probably be closer to the weekend since I work full time on non Xenomai thi=
ngs lol okay let me look into this and see what is there and what's not.

Sent via the BlackBerry Hub for Android

=A0 Original Message =A0
From: shevchenko.taras@triolcorp.com.ua
Sent: March 27, 2018 11:27 AM
To: greg@embeddedgreg.com
Subject: Re: [Xenomai] 4.9 for x86 issue

Perfect !!
I need by priority=20
1)- RtNet driver to use UDP
2)- Handle gpio interrupt
3)- working card-reader
if you have time today, can we use skype or viber or telegramm to communica=
te faster


=D1 =F3=E2=E0=E6=E5=ED=E8=E5=EC =E8 =ED=E0=E4=E5=E6=E4=EE=E9 =ED=E0 =F1=EE=
=F2=F0=F3=E4=ED=E8=F7=E5=F1=F2=E2=EE,
=D8=E5=E2=F7=E5=ED=EA=EE =D2.=C3.

----- Original Message -----
From: "Greg Gallagher" <greg@embeddedgreg.com>
To: "=D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1 =C3=F0=E8=E3=EE=F0=FC=E5=E2=
=E8=F7" <shevchenko.taras@triolcorp.com.ua>
Sent: Tuesday, March 27, 2018 6:21:28 PM
Subject: Re: [Xenomai] 4.9 for x86 issue

Do you have a list of things that you need working on the board? I may have=
 some time to help.

Greg

Sent via the BlackBerry Hub for Android

=A0 Original Message =A0
From: shevchenko.taras@triolcorp.com.ua
Sent: March 27, 2018 9:30 AM
To: rpm@xenomai.org
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai] 4.9 for x86 issue

Sorry, but no
I install 4.9.90 and new patch
Ive the same problems=A0=A0 - no responce with=A0 my LKM=A0 and SD card rea=
der
I can add logs

with sd discover new details:
=A0 if boot with sd-card inserted in reader=A0=A0 - sd-card can read , if I=
 remove card=A0 - get no responce=20

difference with lsmod command output (when inserted card and not) is nls_is=
o8859_1=A0=20
this module is absent without sd-card

I try boot without sd card and do modprobe nls_iso8859_1=A0 after insert sd=
card=A0=A0 -=A0 get no responce=20




----- Original Message -----
From: "Philippe Gerum" <rpm@xenomai.org>
To: "Jan Kiszka" <jan.kiszka@web.de>
Cc: "xenomai" <xenomai@xenomai.org>
Sent: Tuesday, March 27, 2018 4:12:32 PM
Subject: Re: [Xenomai] 4.9 for x86 issue

On 03/10/2018 11:06 PM, Jan Kiszka wrote:
> On 2018-03-09 08:51, Jan Kiszka wrote:
>> 4.9 requires more work, I've pushed the beginning to wip/4.9 in the same
>> repo.
>=20
> I started to patch further on this during my flight (wip/4.9 updated),
> noticed that the 4.14-wip queue will need a little bit sysentry tweaking
> as well (missing 64-bit syscall dispatching), and then had to find 4.9
> in a rather unfortunate state /wrt x86-64: CPUs are no longer idling
> properly. I went back to ipipe-core-4.9.24-x86-2, without a difference.
>=20
> If you should look into 4.9-x86 as you indicated, please check this.

Both issues fixed in 4.9.90/x86 as pushed lately. The result has run
overnight in 64bit mode, and for a couple of hours in ia32emu mode. So
far so good.

--=20
Philippe.

_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
https://xenomai.org/mailman/listinfo/xenomai

_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
https://xenomai.org/mailman/listinfo/xenomai

