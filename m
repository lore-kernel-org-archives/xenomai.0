Subject: Re: [Xenomai-help] irq conflict
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45AFD3E2.8090200@domain.hid>
References: <45ADEDDC.5060407@domain.hid> <45AEA9A7.7000001@domain.hid>
	<45AFC392.5050705@domain.hid>  <45AFD3E2.8090200@domain.hid>
Content-Type: text/plain
Date: Thu, 18 Jan 2007 21:40:29 +0100
Message-Id: <1169152829.25556.25.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
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
Cc: Xenomai <xenomai@xenomai.org>

On Thu, 2007-01-18 at 21:09 +0100, Jan Kiszka wrote:
> Theo Veenker wrote:
> > Jan Kiszka wrote:
> >> Theo Veenker wrote:
> >>> Hi all,
> >>>
> >>> I need to run xenomai on a HP Compaq nc6320. I use kernel 2.6.17.14
> >>> and xenomai 2.2.5. The non-realtime kernel runs fine on this laptop,
> >>
> >> Means the same kernel with I-pipe (and Xenomai) disabled or the same
> >> kernel version and .config, but unpatched?
> > 
> > The latter.
> > 
> >>
> >>> but the xenomai pactched kernel gives several of these messages:
> >>>
> >>>   IRQ routing conflict for xxxx.xx.xx.x, have irq 11, want irq 10
> >>>
> >>> And some things (e.g. mouse, network) then don't work, not properly
> >>> anyway. The same kernel runs fine however on other systems.
> >>>
> >>> Any clue what I can do about it?
> >>
> >> Please provide bootlogs for both rt and non-rt kernel startup. And the
> >> .config.
> > 
> > I 'solved' it by enabling ACPI (without processor module and others).
> > Looks good. I don't see high latencies with the latency test. Under
> > what conditions might ACPI affect real-time behaviour?
> 
> CONFIG_ACPI_PROCESSOR, because it allows deep sleep states with
> significant wakeup latencies.
> 
> But back to your original issue: You mean your notebook booted fine
> under vanilla Linux with ACPI disabled? That would mean I-pipe relies on
> ACPI here without stating this anywhere. In that case /something/ needs
> fixing: code, config deps, or doc.
> 

It doesn't, at least, not willingly. Before drawing any conclusion,
please try 2.6.19 with the same configuration first: the generic irq
layer may have had a positive influence on the I-pipe in this area.

> Jan
> 
> 
> PS: Please take care to not drop the list from CC.
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



