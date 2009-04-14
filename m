From: Vikesh Rambaran <vikesh.rambaran@domain.hid>
In-Reply-To: <49E4793D.2010105@domain.hid>
References: <b131c9f0903230100x1b2aa2fet9e2b0efe68a7a77f@domain.hid>
	<b131c9f0903240037q446193f5hbfdd3ade40ea2af4@domain.hid>
	<49C91B24.2020304@domain.hid>
	<b131c9f0903241437s661b9bd3v504b14f83b1b9c86@domain.hid>
	<49C95A76.4020802@domain.hid>
	<b131c9f0903250636o85af46au240a04ab33ebb599@domain.hid>
	<b131c9f0904060126n12158c5dqd37d71769cc8aff5@domain.hid>
	<49D9E000.4070009@domain.hid>
	<1239099594.9869.65.camel@domain.hid>
	<49DB3717.4090402@domain.hid>
	<b131c9f0904080057v49b2caf3s5c2096827dd1576d@domain.hid>
	<49DC6612.40802@domain.hid>
	<1239696760.5780.12.camel@domain.hid>
	<49E45473.4050409@domain.hid>
	<1239708396.5780.34.camel@domain.hid>
	<49E4750B.6060602@domain.hid>
	<1239709765.5780.40.camel@domain.hid>
	<49E4793D.2010105@domain.hid>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 14 Apr 2009 15:55:22 +0200
Message-Id: <1239717322.5780.62.camel@domain.hid>
Mime-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai LTTng support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Tue, 2009-04-14 at 13:53 +0200, Jan Kiszka wrote:
> Vikesh Rambaran wrote:
> > On Tue, 2009-04-14 at 13:35 +0200, Jan Kiszka wrote:
> >>>> NMI watchdog, see Xenomai machine kconfig menu, use nmi_watchdog=2 to
> >>>> finally enable it at the kernel command line.
> >>>>
> >>> There are build issues with NMI enabled.
> >>>
> >>> Would you prefer testing with the latest git updates, or can i just 
> >>> replace the following in hal32.c (line 139)
> >>>
> >>> - die_nmi(regs, buf); 
> >>> + die_nmi(buf, regs, 1);
> >> If your CPU is not too new, this may suffice. Otherwise you should
> >> switch over to the development head (upcoming 2.5) as there we have
> >> up-to-date NMI support.
> >> BTW, trying 2.5-devel might be useful anyway to check if the picture
> >> changes (maybe we even see a clearer error with that branch...).
> >>
> > 
> > Ok, thanx. I have a Core Duo and a Core 2. Will try the 'short' approach
> > first as our external git access at work is blocked. 
> 

Tried the test with NMI enabled and die_nmi(buf, regs, 1);
No additional Xenomai / IPIPE info is displayed on the serial console.

What type of response were we hoping for ? Reset ?

There is occasionally the following message that appears on the serial
console after logging into the gnome desktop (not sure if it's relevant
to this issue) :

evdev.c(EVIOCGBIT): Suspicious buffer size 511, limiting output to 64
bytes. See http://userweb.kernel.org/~dtor/eviocgbit-bug.html



> Doesn't
> 
> http://git.xenomai.org/?p=xenomai-head.git;a=snapshot;sf=tgz
> 
> or
> 
> git clone http://...
> work for you?
> 

The first option to retrieve the snapshot works ! Thanx !
Will try this branch out next.

> > 
> > Will pull the 2.5-devel branch at home.
> 
> Yeah, I'm glad that we have SOCKS here @CT. My poor colleagues in the
> field without it face similar issues like you.

Have a good evening
Vicki



