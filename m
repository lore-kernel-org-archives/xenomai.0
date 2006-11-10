Message-ID: <BAY101-F30C0E46939D0872C16547AE2F70@domain.hid>
From: "Marco Rossi" <cicciobombo123@domain.hid>
Subject: Re: [Xenomai-help] Problem with multiport serial board
Date: Fri, 10 Nov 2006 17:33:45 +0100
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
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

Yes, I  haven't switched on shared edge-triggered IRQ support. When i 
compiled the kernel i missed to set this option, I'm not yet practical in 
xenomai.
Thanks again.
Marco


>From: Jan Kiszka <jan.kiszka@domain.hid>
>To: Marco Rossi <cicciobombo123@domain.hid>
>CC: xenomai@xenomai.org
>Subject: Re: [Xenomai-help] Problem with multiport serial board
>Date: Fri, 10 Nov 2006 17:11:19 +0100
>
>Marco Rossi wrote:
> >
> >
> >
> > Hi every body. I'm testing my multiport serial board (2 extra serial
> > port) with shared interrupt using the program found at
> > http://www.rts.uni-hannover.de/rtaddon/rt_serial_uprog.tar.bz2 .
> >
> > I insert the module xeno_16550A.ko in the follow way:
> > insmod /.../xeno_16550A.ko ioaddr=0x3f8, 0x2f8, 0xd800, 0xdc00
> > irq=4,3,5,5 start_index=0
> >
> > When I use only a extra port the program works, but when I try to write
> > in the first extra port and to read in the second extraport I got an
> > error opening the second extraport.
> >
> > For example if I write in ttS0 and I read from ttyS2 all work; if   I
> > write in ttS2 and I read from ttyS3 i get :
> > can't open rtser3 (the rt_dev_open return a negative file descriptor).
>
>The negative number is the error code (see documentation). It likely
>says -EBUSY, meaning here that the IRQ line is already in use. Check
>your Xenomai kernel configuration, I guess you haven't switched on
>shared edge-triggered IRQ support yet, have you?
>
>Jan
>


><< signature.asc >>

_________________________________________________________________
Chiama gratis con Windows Live Messenger  
http://imagine-msn.com/messenger/launch80/?locale=it-it&TAB=2


