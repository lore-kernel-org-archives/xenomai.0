Date: Thu, 31 Mar 2005 09:42:52 +0300 (EEST)
From: "Rus V. Brushkoff" <rus@domain.hid>
In-Reply-To: <Pine.LNX.4.53.0503281333010.21926@domain.hid>
Message-ID: <Pine.LNX.4.53.0503310916460.8592@domain.hid>
References: <Pine.LNX.4.53.0503281139180.20969@domain.hid>
 <Pine.LNX.4.53.0503281237020.21474@domain.hid>
 <4247DCE9.8070407@domain.hid> <Pine.LNX.4.53.0503281333010.21926@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Adeos-main] Adeos-2.6.11-r10c1 report
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main@gna.org

	Hi.

 Booted r10c1, on my P4 ICH system, with adeos compiled in statically is
behaved the same way as r9 - no interrupts in the ICH chipset occured.
If I pass "pci=routeirq" kernel parameter - the systems is deadlocked in
the same place (rc.hotplug scripts) but printed on the console something :

..................................
------cut here -------
kernel BUG at kernel/sched.c:2666!
invalid operand: 0000 [#1]
..................................

 If Adeos is compiled as module and not inserted - the system is working ok.
After inserting module I've got solid lockup while starting X on the AGP
nvidia card (tried original Xorg "nv" driver and proprietary "nvidia" one).



		Rus

