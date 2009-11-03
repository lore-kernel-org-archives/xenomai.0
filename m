Date: Tue, 3 Nov 2009 14:34:07 +0100
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20091103133407.GA9836@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai-core] [Xenomai core] Freeze on MPC8572 and P2020 with SMP
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


I have compiled and run ipipe-2.6.30.3-powerpc-2.7-02 and Xenomai
v2.4.9.1 (well, actually c4c3c82791951df998ac4dc463f79a76884577b6), on
two similar Freescale boards, the MPC8572DS and the P2020DS. Both are
dual core, and both run fine using vanilla Linux 2.6.30 with SMP.

If I enable ipipe only, I can still boot SMP. If Xenomai is enabled,
then the machine freezes as soon as Xenomai is started. (As a module,
Xenomai locks the machine when loading).

Without SMP, it seems to run fine (and latency numbers are excellent!)

I seem to recall having seen that Xenomai SMP was working on some
other Freescale powerpc chips. Looking for any advice...

Thanks,

Richard

