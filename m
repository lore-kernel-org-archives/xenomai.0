MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-type: text/plain; charset=us-ascii
From: Peter =?iso-8859-1?q?W=E4chtler?= <pwaechtler@domain.hid>
Date: Fri, 27 Mar 2009 15:38:10 +0100
Message-id: <200903271538.10434.pwaechtler@domain.hid>
Subject: [Xenomai-core] use case: possible to boot Posix subsystem in <50ms
	and then Linux?
Reply-To: pwaechtler@domain.hid
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

Hi Xenomai developers,

for automotive control units the boot time is essential. After power-up the 
first status message has to be sent in about 50ms. This is usually achieved 
by a RTOS with boot times far below.

Is it possible to construct a system with Xenomai that boots the POSIX (or 
whatever) subsystem first and then start Linux. Or is there a dependency that 
the subsystem can't run until Linux is up?

That's the question ;)

        Peter

