Message-ID: <2ff1a98a0801280551v60bc61b4y122989f9c8904e12@domain.hid>
Date: Mon, 28 Jan 2008 14:51:22 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <479DDCBF.5050901@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20080123065221.GB6573@domain.hid> <20080124094150.GA7503@domain.hid>
	<2ff1a98a0801240202g83ca10esd2f7fc928946e3c1@domain.hid>
	<20080125100404.GA8833@domain.hid>
	<2ff1a98a0801250900if03294epded12290544d5480@domain.hid>
	<20080128085123.GA7297@domain.hid>
	<2ff1a98a0801280519m62768928x5e5fa40123abe9cd@domain.hid>
	<479DD9D7.5010207@domain.hid>
	<2ff1a98a0801280535g24e8fa4fi2c033856eee7e8cb@domain.hid>
	<479DDCBF.5050901@domain.hid>
Subject: Re: [Xenomai-help] AT91SAM9260 latency
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: jagarcia@domain.hid, xenomai@xenomai.org

On Jan 28, 2008 2:46 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Gilles Chanteperdrix wrote:
> > On Jan 28, 2008 2:34 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> >> Gilles Chanteperdrix wrote:
> >>> ...
> >>> The behaviour you get may be due, for instance, to the fact that the
> >>> processor goes into some sleep mode when idle and to a wake-up
> >>> latency; if you run some load, there is no wake-up latency. It is hard
> >>> to say anything. In order to investigate, I would instrument the
> >>> kernel to trace the irq masking sections.
> >> Don't we have the I-pipe tracer on this platform?
> >
> > Unfortunately, the tracer on arm has too much overhead to give
> > meaningful results.
>
> Hmm. Unless the system becomes unusable while running the tracer, I
> don't see the show-stopper yet. We are looking for an increase of the
> latency when triggering a certain event. That should remain measurable
> even if the base latency is far higher than usually.
>
> Do you know what makes the tracer so slow?
>

I suspected the fact that we disabled and enabled hardware irqs in
ipipe_get_tsc, but I reimplemented ipipe_get_tsc to not shut
interrupts off and the overhead of the tracer remains high.

-- 
                                               Gilles Chanteperdrix

