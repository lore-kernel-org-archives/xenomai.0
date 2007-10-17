From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain
Date: Wed, 17 Oct 2007 19:18:12 +0200
Message-Id: <1192641492.5973.67.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: [Xenomai-core] Xenomai/Blackfin upgrade
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


Our Blackfin port has just been upgraded to the latest 2.6.23. The other
good news is that we have now rebased this work over mainline kernels.
The I-pipe patch below is an all-in-one, supporting the bf533, bf537 and
bf561 dual core boards. Any Xenomai version from 2.3.2 and on can be
used (albeit pre 2.4-rc4 will require to fix the default calibration
value by hand for the bf561).

If you happen to have any of these boards at hand, and really don't know
how to spend geek time these days, please give this a try and send some
feedback.

http://download.gna.org/adeos/patches/v2.6/blackfin/adeos-ipipe-2.6.23-bf5xx-1.7-00.patch

-- 
Philippe.



