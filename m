Message-ID: <47C93C30.8030307@domain.hid>
Date: Sat, 01 Mar 2008 12:21:20 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <47C92740.9000203@domain.hid>
In-Reply-To: <47C92740.9000203@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] fix initial rpi_push
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-core@domain.hid

Jan Kiszka wrote:
> [My favorite again... :->]
> 
> The initial rpi_push in xnshadow_start takes place for the caller's CPU,
> instead of the thread's target CPU.
> 
> I haven't fully made up my mind about the practical impact of this bug,

This would leave the kernel spuriously run at a boosted priority level
on the source CPU.

> I just came across it the hard way (rpi_push worked on uninitialized
> data) while kicking CPUs out of the set that Xenomai shall support. At
> least it should cause quite some RPI "confusion" for a while on both
> involved CPUs.
>

Merged, thanks.

> Jan
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 
Philippe.

