MIME-Version: 1.0
In-Reply-To: <5317603D.5060602@xenomai.org>
References: <53174F44.6000309@sigmatek.at> <5317539C.5040700@xenomai.org>
 <5317603D.5060602@xenomai.org>
Date: Wed, 5 Mar 2014 20:59:52 +0100
Message-ID: <CAPRPZsCxBX95RfY1-3LFSMPpoRxHTw_Pj5TzrT-oX6PkrMhOQA@mail.gmail.com>
From: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] xenomai , irq and pci
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: johann.obermayr@sigmatek.at
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

>
> >> task0 is one high prior in primary domain on core0.
> >> this task wait for event, that is fired by fpga irq.
> >> than this task will make some pci accesses to the fpga.
>

A while ago (11/02) you wrote to this list ('[Xenomai] Xenomai and pci
access') because you had issues with PCI transfers. Did you fix those ? How
large are your transfers ?

>> the other task (task1) is a shadow task, but running in secondary domain
> >> on core 1.
> >> This task make many big memcpy to sram.
>

I remember having asked for the complete PCI bus layout and to try out
other memory access methods besides memcpy. Did this do anything ?

Since you mention you have an FPGA, I would now suggest instrumenting it
(add some logging) as to find out when and how (regular intervals or with
interruptions) your FPGA is accessed by the PCI bus.


J.

 >>
> >> in the ipipe_handler_irq we have a function callback.
> >> a small driver hooks to this callback add make some tracepoint into
> >> a shared memory.
> >>
> >> with the trace we see some time a very high jitter in the
> ipipe_handler_irq
> >> function (around 250 us).
> >> has anyone an explanation for this?
> >>
> >> and a 4 byte access from task0 to fpga need more than 300us,
> >>   while task1 is writing to sram.
> >
> > Maybe the problem is the size of the PCI burst when writing to the SRAM?
> > How large is it? If the sram is mapped with "write-combine", it will be
> > buffered and written in large bursts. Maybe you could try mapping the
> > sram area uncached?
> >
>
> Also, you do not tell us if your processor has two real cores, or if
> they are hyperthreaded?
>
> --
>                                                                 Gilles.
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>
