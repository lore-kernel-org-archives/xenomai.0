From: Bart Jonkers <jonkersbart@domain.hid>
Content-Type: text/plain
Date: Thu, 25 May 2006 12:59:17 +0200
Message-Id: <1148554757.9498.19.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai on PXA255
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

Hey,

I'm trying to run Xenomai enabled kernel on the PXA255 (arm). When I
compile the patched kernel, I get some undefined references errors.
When I search through the patched kernel, I found the functions an
variables defined for the integrator architecture.

Which functions and variables need I to define for the PXA255 and what
are there purpose, so I can add support for the PXA255 processor.
Or are there some patches around to support the PXA255.

Thanks,
Bart


