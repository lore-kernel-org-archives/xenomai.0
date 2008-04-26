Date: Sat, 26 Apr 2008 12:58:55 -0700 (PDT)
From: George Pitich <george_pitich@domain.hid>
In-Reply-To: <18450.13958.813644.217977@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <952621.63539.qm@domain.hid>
Subject: Re: [Xenomai-help] xenomai installation
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


> Please do the following in Linux kernel
> configuration:
> 
>  > 
>  > -- NOTE: Xenomai conflicts with PC speaker
> support.   
>  > --- (menu Device Drivers/Input device
>  > support/Miscellaneous devices)
> 
> disable PC speaker support (you will find it in the
> Device Drivers/Input
> device support/Miscellaneous devices menu).
> 
>  > --- NOTE: Xenomai needs either X86_LOCAL_APIC
> enabled
>  > or HPET_TIMER disabled.               &#9474;
> &#9474;
>  > --- (menu Processor type and features)).
> 
> Enable Local APIC option (if your box has a local
> APIC, but anything
> recent probably has an APIC), or disable HPET timer
> option (you will find
> these options in the Processor type and features
> menu).
> 

Thanks for the help, now I made a progress and
installed xenomai. I had to compile it with
--enable-x86-tsc=no flag since my testsuite won't run
without a TSC support and I don't know where to
configure this flag during the initial kernel config
process (make menuconfig)? Is it a processor family
specific?

Interestingly enough after a boot, klatency test runs,
but if i stop it (ctrl-c) and run it again it
segfaults:

/usr/xenomai/bin/xeno-load: line 180: 22756
Segmentation fault      $suflag $* $cmdargs

irqbench also won't run:

irqloop: error starting test: Inappropriate ioctl for
device

Regards,

g.


      ____________________________________________________________________________________
Be a better friend, newshound, and 
know-it-all with Yahoo! Mobile.  Try it now.  http://mobile.yahoo.com/;_ylt=Ahu06i62sR8HDtDypao8Wcj9tAcJ

