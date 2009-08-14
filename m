Date: Fri, 14 Aug 2009 12:26:45 +0200 (CEST)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <1250244831.3019.17.camel@domain.hid>
Message-ID: <Pine.LNX.4.62.0908141226340.14595@domain.hid>
References: <Pine.LNX.4.62.0908141030170.14595@domain.hid>
	<4A853707.10509@domain.hid>
	<Pine.LNX.4.62.0908141206480.14595@domain.hid>
	<1250244831.3019.17.camel@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] T_WARNSW ignored?
Reply-To: xenoka09@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org


> What does /proc/xenumai/faults say? Does any counter value increase
> while the app is running?

faults displays nothing. stat shows increasing MSW/CSW count for the
thread in question:

/ # cat /proc/xenomai/faults 
TRAP         CPU0
/ # cat /proc/xenomai/stat 
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
   0  0      0          2392559    0     00400080   82.8  ROOT
   0  274    38         652599     0     00300186   11.0  main
   0  276    12         71461      0     00300186    1.4  logger
> 0  277    10210      20412      0     00320186    2.5  Head_UDP_Thread
   0  0      0          3824071    0     00000000    1.9  IRQ6: [timer]
   0  0      0          10040      0     00000000    0.1  IRQ14: rmiisport_rx
   0  0      0          0          0     00000000    0.0  IRQ15: rmiisport_tx
   0  0      0          159        0     00000000    0.0  IRQ46: rmiisport_err




