MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18448.49233.523862.911803@domain.hid>
Date: Thu, 24 Apr 2008 19:16:01 +0200
In-Reply-To: <51B669A8A7D2914E9AB2B3F40AC6553E646F2A@afsexc01.aurora.aero>
References: <51B669A8A7D2914E9AB2B3F40AC6553E646F13@domain.hid>
	<2ff1a98a0804230730t44382de9i813b23d235ece2e3@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F19@domain.hid>
	<18447.31623.723753.421351@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F1D@afsexc01.aurora.aero>
	<18447.43488.713144.166771@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F21@domain.hid>
	<18448.11276.526008.229326@domain.hid>
	<48103103.7020005@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F23@domain.hid>
	<2ff1a98a0804240730w36d69599q8ed98c1657365cb@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F2A@afsexc01.aurora.aero>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] serial port overrun problem RT TASK
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Karch, Joshua" <jkarch@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Karch, Joshua wrote:
 > 
 > Gilles, Jan,
 > 
 > I tried idle=poll and disabling smi in a new kernel, and that brought the error rate down to once every 30 seconds  Worst case latency dropped to 1763 uS

A worst case latency of 1ms is way too high. You still have an hardware
issue. How do you disable SMI ? Do you use the outbs from the link I
sent ? Maybe they are for Geode GX1, and you have a Geode GX2. You
should look for the proper outb in a geode GX2 datasheet.

Have you kept away from the CPUFREQ and ACPI_PROCESSOR options ? Did you
check the BIOS settings ?

Also, what about the graphical problem ? Did you switch to framebuffer ?

 > 
 > This Geode GX500 (GX2) seems to have some compatibility problems with the Xenomai system.

These are just problems due to power saving, but there should hopefully
be workarounds. Also notes that these problems are not specific to
Xenomai, they also happen with Linux. Only, they are not considered
abnormal. There are people actually using happily Xenomai on Geode
processors.

 > 
 > I'm still unable to open the benchmark device code -19 when running latency -t 2

Have you enabled the timerbench driver in xenomai configuration ?

-- 


					    Gilles.

