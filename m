MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18164.5365.820554.634410@domain.hid>
Date: Fri, 21 Sep 2007 21:01:09 +0200
In-Reply-To: <OF3EF80531.231E36EB-ONC125735D.002FAC4D-C125735D.0032AD8D@datacon.at>
References: <OF3EF80531.231E36EB-ONC125735D.002FAC4D-C125735D.0032AD8D@datacon.at>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] POSIX skin or CONFIG_XENO_OPT_PERVASIVE disabled
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: juergen.lanner@domain.hid
Cc: xenomai@xenomai.org

juergen.lanner@domain.hid wrote:
 > 
 > 
 > Hi there!
 > 
 > Sorry for the newbie question, but I am stuck here ...
 > I get this message every time I try to run e.g. latency test on my system.
 > 
 > What do I wrong?
 > 
 > I use
 > Ubuntu 7.04 desktop
 > Kernel 2.6.20.19 from www.kernel.org
 > Xenomai 2.3.3
 > adeos-ipipe-2.6.20-i386-1.8-08.patch
 > 
 > I already saw
 > (...)
 > running: cat /proc/interrupts
 >            CPU0
 >   0:    7243712    XT-PIC-XT        timer, rthal_broadcast_timer
 >   1:         30    XT-PIC-XT        i8042
 >   2:          0    XT-PIC-XT        cascade
 >   5:     544285    XT-PIC-XT        uhci_hcd:usb1, eth3,
 > i915@domain.hid
 >   7:      18259    XT-PIC-XT        ehci_hcd:usb3
 >   8:          3    XT-PIC-XT        rtc
 >   9:   17584667    XT-PIC-XT        eth0
 >  12:        196    XT-PIC-XT        i8042
 >  14:      10992    XT-PIC-XT        ide0
 >  15:       7236    XT-PIC-XT        uhci_hcd:usb2, eth1, eth2
 > NMI:       3198
 > LOC:    7243618
 > ERR:          0
 > MIS:          0

The conclusion of vicki problem was that he had the APIC enabled in
kernel configuration whereas his hardware had no APIC. Are you sure you
are not running into the same issue ? From /proc/interrupts contents, it
looks like you are not using APIC, so, check that it is not enabled in
kernel configuration.

-- 


					    Gilles Chanteperdrix.

