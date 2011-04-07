Date: Thu, 7 Apr 2011 19:08:55 +0200
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20110407170855.GA22659@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai-core] ARM IXP: ipipe regression from 2.6.31 to .33 and .35
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: adeos-main@gna.org
Cc: Xenomai-core@domain.hid


I have been trying to bring my IXP425 based system up to date, and I
have found an apparent regression. Everything worked fine with ipipe
2.6.30 and Xenomai 2.4. With 2.6.31 an ipipe kernel still boots, but
starting with 2.6.33 the trouble begins (see below).

I see that Gilles refactored the TSC emulation starting with
2.6.33. I wonder whether this could be the cause?

I did not immediately see any obvious bug, but I don't fully
understand the newer TSC code. I would appreciate any hints.

Thanks,
Richard

** ipipe-2.6.31-arm-1.16-01

   Seems to boot fine.

** ipipe-2.6.33-arm-1.18-01

   Boots, but runs very slowly. FCSE on/off makes no difference.
   After a few seconds, it seem to hand, but it might just be very
   slow. Once I saw this on the console:

      hrtimer: interrupt took 1414795601278721 ns

   coming from kernel/hrtimer.c:1363

      printk_once(KERN_WARNING "hrtimer: interrupt took %llu ns\n", ...)

** ipipe-2.6.35.9-arm-1.18-01

   Does not boot with ipipe. FCSE on/off makes no difference.
   It *does* boot without ipipe enabled.

