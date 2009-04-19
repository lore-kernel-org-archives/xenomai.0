Date: Sat, 18 Apr 2009 22:05:26 -0700 (PDT)
From: Martin Shepherd <mcs@domain.hid>
In-Reply-To: <1240077395.26554.169.camel@domain.hid>
Message-ID: <Pine.LNX.4.64.0904182148390.9176@domain.hid>
References: <1240077395.26554.169.camel@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Xenomai-core] [Xenomai-help] Xenomai v2.5-rc1
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, xenomai@xenomai.org


On Sat, 18 Apr 2009, Philippe Gerum wrote:
> Here is the first candidate release for the v2.5.x branch.

While preparing to compile the 2.6.29.1 kernel with the above release
candidate, I noticed that in the 2.6.29.1 kernel, CONFIG_CPU_IDLE is
now mandatory if one turns on ACPI support. This wasn't the case for
the 2.6.28.7 kernel, and in that kernel I had it switched off, due to
the warnings about idle handlers and the CONFIG_ACPI_PROCESSOR option.

Was I correct to have CONFIG_CPU_IDLE turned off previously, and if
so, is the new policy of making it mandatory a problem for Xenomai?

Thanks for the help,

Martin

