Date: Mon, 11 Apr 2005 12:57:07 +0300 (EEST)
From: "Rus V. Brushkoff" <rus@domain.hid>
In-Reply-To: <4257C2C3.7030906@domain.hid>
Message-ID: <Pine.LNX.4.53.0504111247180.7909@domain.hid>
References: <200504011643.38582.lbocseg@domain.hid> <200504061337.16492.lbocseg@domain.hid>
 <Pine.LNX.4.53.0504070825020.17256@domain.hid>
 <200504081512.16320.lbocseg@domain.hid> <4257C2C3.7030906@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Adeos-main] adeos-linux-2.6.11-i386-r10c2.patch [Some progress]
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
Cc: rtai@domain.hid, adeos-main@gna.org

	Hi.
[...]

:o APIC, no IO-APIC, Adeos built into the kernel, ACPI disabled

 Well with ACPI totally disabled Adeos-10rc2 works on my intel m/b ! I
have working all peripheria connected to ICH chipset. X11 over nvidia kernel
driver is works too. Now it is doesn't matter if adeos compiled as module
or not.
 Can't run rtai tests (latency/shm/etc) because of 2.6.11 incompability of
the current vulcano cvs (2.6.11 changed used_math definition /
cpu_online_map only exported in SMP mode / etc).

:
:

		Rus

