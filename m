MIME-Version: 1.0
Message-ID: <OF246A2543.EA63CD8F-ONC12571EA.002E004F@uk.marconicomms.com>
From: "Thomas Necker" <Thomas.Necker@domain.hid>
Date: Fri, 15 Sep 2006 11:46:27 +0200
Content-Type: text/plain; charset="us-ascii"
Subject: [Xenomai-help] pSOS skin questions
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

I started to experiment with Xenomai's pSOS skin. I'm running Xenomai 
2.2.2 on
a 2.4 kernel. So far I managed to get some tasks running and some messages 
sent.
Now I'm stuck with some timer issues. So here are my questions:
- Is somebody out there actually using the pSOS skin? Who should I send 
patches to?
- While tm_wkafter finally works, I had no success with tm_evafter. It 
seems that the
  timeout doesn't work - no event is sent after the specified time. 
Setting the timer to
  periodic also doesn't have any effect (well, rt_start_timer is 
deprecated as I understand,
  at least the vxworks skin sets the timer mode as needed, but what about 
the pSOS skin?)
- I compiled the pSOS, UVM and Native support as kernel modules. The 
program runs
  when loading xeno_native and xeno_uvm. I cannot load xeno_psos though 
("unresolved
  symbol print_backtrace"). Do I need that module?

Thanks,
Thomas


