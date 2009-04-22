From: Joshua Lamorie <jpl@domain.hid>
Content-Type: text/plain
Date: Wed, 22 Apr 2009 15:35:03 -0400
Message-Id: <1240428903.3403.8.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] powerpc and fastsync
Reply-To: jpl@domain.hid
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

Gidday there,

I am using Xenomai-trunk on a Virtex-II Pro (PowerPC 405) using a
patched version of DENX-2.6.28.5 (using
adeos-ipipe-2.6.28.5...2.4-04.patch as a base).

This was working fine up until the beginning of April when it appears
that the configure.in and configure scripts were changed for powerpc.
The SVN revision(commit) 4681 removed CONFIG_XENO_FASTSYNCH=y.  However,
in ksrc/arch/powerpc/Kconfig, XENO_FASTSYNCH is still set to 'y'.

Is this normal?

I'm not involved with development of Xenomai, so I don't actually have a
clue about what this means.  On my 'post March 11' build I get
'(userland requires "nofastsynch nosmp", kernel provides "fastsynch
nosmp"....)'.

I have searched the mailing list archives and I can't find much mention
of this issue occurring previously.

Thanks in advance for any advice/recommendations.

Joshua

-- 
Xiphos Technologies Inc.
T: 514.847.9474 x 227
F: 514.847.9474

________________________________________________________________________
The information transmitted is intended only for the person or entity to
which it is addressed and may contain confidential and/or privileged
material. If you have received this in error, please contact the sender
and delete this communication and any copy immediately. Thank you.


