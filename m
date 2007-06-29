From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain
Date: Fri, 29 Jun 2007 21:14:25 +0200
Message-Id: <1183144465.6574.99.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: [Xenomai-core] Support for 2.6.22/x86
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


Our development trunk now contains the necessary support for running
Xenomai over 2.6.22/x86. This work boils down to enabling Xenomai to use
the generic clock event device abstraction that comes with newest
kernels. Other archs / kernel versions still work the older way, until
all archs eventually catch up with clockevents upstream.

This support won't be backported to 2.3.x, because it has some
significant impact on the nucleus. Tested as thoroughly as possible here
on low-end and mid-range x86 boxen, including SMP.

Please give this hell.

http://download.gna.org/adeos/patches/v2.6/i386/adeos-ipipe-2.6.22-rc6-i386-1.9-00.patch

-- 
Philippe.



