Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B411FCC
	for <xenomai@lists.linux.dev>; Thu, 27 Apr 2023 08:15:08 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id B80A724000B;
	Thu, 27 Apr 2023 08:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1682583300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4VAPWhLAsHnc547jo+u2jQo3kVgzCM01lYOSvdW2fms=;
	b=ZKW1OdCek74Si0XBv169JQFmZkGCGKQNvResztqr3y4Uj0jPmaFRCwrQ/ZLZGuccJvJca4
	ixN5bsefXLtYqXyPIg/PR8TbVdUWl0M68A+Fhvj8HFJqO9rqf/EHkHKwEm5S72TeiloZ7M
	hDqpuRt7Moq93jmzWVVIxSZMP+VsrUveVWW/bSuly53WdQpVUzuaisDhd8Qfr4qpBfwJBP
	eeZQWXCjlNtuXWbAUfjrT/7Z6sMyH2jSpHJXibkf1VT/B2y4a9MENHkkFyWjaZlz2Uyr0Z
	Kg7zZZwwVbNN5gNPCmuFDE+VlxTKC1jhOcKeXdaA3D6r7QSs8xiyBN2gfXaeyA==
References: <PH1P110MB1050E3792D231FD98FD707B7E2659@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, Dave Rolenc
 <Dave.Rolenc@kratosdefense.com>
Subject: Re: EVL Kernel Debugging
Date: Thu, 27 Apr 2023 09:58:28 +0200
In-reply-to: <PH1P110MB1050E3792D231FD98FD707B7E2659@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <871qk5zqpp.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> Has there been any successful use of kdb or kgdb with the evl kernel?
>
> We are currently using 5.15.98evl-g1541335eef8b, and have not had much luck
> in getting kdg or kgdb to work. We see the start of a kdb session, but the
> serial port eventually hangs.
>
> We are connecting the unit under test (running evl kernel) over a serial
> port to a secondary machine. 
>
> I think we have all the necessary settings n the kernel config for GDB/KDB:
>
> [root@localhost boot]# cat config-5.15.98evl-g1541335eef8b-dirty|grep GDB
> CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
> CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
> # CONFIG_SERIAL_KGDB_NMI is not set
> # CONFIG_GDB_SCRIPTS is not set
> CONFIG_HAVE_ARCH_KGDB=y
> CONFIG_KGDB=y
> CONFIG_KGDB_HONOUR_BLOCKLIST=y
> CONFIG_KGDB_SERIAL_CONSOLE=y
> CONFIG_KGDB_TESTS=y
> # CONFIG_KGDB_TESTS_ON_BOOT is not set
> CONFIG_KGDB_LOW_LEVEL_TRAP=y
> CONFIG_KGDB_KDB=y
>
> Our command line is as follows:
> BOOT_IMAGE=/vmlinuz-5.15.98evl-g1541335eef8b-dirty
> root=UUID=8748ad87-3ef2-48fe-8d3d-fb2ef72a8f13 ro crashkernel=auto fips=1
> kgdboc=ttyS0,115200
>
> On the secondary machine, we connect with minicom or screen over the serial
> port. 
>
> The first issue is that  magic sysrq over serial (ctrl-a f g with minicom,
> for example) doesn't work even with the proper mask written to
> /proc/sys/kernel/sysrq (we tried "1", which should enable all magic-sysrq
> features). Doing   echo g > /proc/sysrq-trigger from the evl system does
> seem to work, but that isn't ideal. We'd rather break in from the secondary
> system when the system is hung. We think we have the correct kernel config
> for Magic-Sysrq over serial:
>
> [root@localhost boot]# cat config-5.15.98evl-g1541335eef8b-dirty|grep
> MAGIC_SYS
> CONFIG_MAGIC_SYSRQ=y
> CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
> CONFIG_MAGIC_SYSRQ_SERIAL=y
> CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
>
> After the magic sysrq g is issued, the connection via serial port seems to
> have kdb content, but the connection is not stable, usually hanging but
> sometimes giving a kdb prompt once or twice. One time we were able to issue
> the "kgdb" command within kdb and attempt to connect via gdb, but after the
> target remote /dev/ttyS0 within gdb, the gdb process just hung.
>

This is more of a Dovetail issue than an EVL one. I don't use kernel
debuggers, so I must admit that Dovetail + KGDB support did not get much
attention and certainly no testing from my side.

> Do you have any suggestions on debugging a hard hang in the evl environment?
> We get a CPU STUCK when restarting an evl-enabled app multiple times, and
> one way to get more insight into this problem is with a kernel debugger.
> With the kernel debugger not working, it seems difficult to get any
> kernel-level insight. 
>

With x86, you could try passing nmi_watchdog=1 via the kernel cmdline to
enable the APIC watchdog on the CPUs, _only for the purpose of
debugging_ because this is likely going to make the latency figures
skyrocket (setting nmi_watchdog=0 is a common recommendation on x86 for
a real-time configuration). But if the application logic can bear with
degraded response time, with luck you might get a kernel backtrace
exposing the culprit.

-- 
Philippe.
