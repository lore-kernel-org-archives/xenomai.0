Message-ID: <5318C49E.8070703@sigmatek.at>
Date: Thu, 06 Mar 2014 19:55:26 +0100
From: Johann Obermayr <johann.obermayr@sigmatek.at>
MIME-Version: 1.0
References: <53174F44.6000309@sigmatek.at>	<5317539C.5040700@xenomai.org>	<5317603D.5060602@xenomai.org>
 <CAPRPZsCxBX95RfY1-3LFSMPpoRxHTw_Pj5TzrT-oX6PkrMhOQA@mail.gmail.com>
In-Reply-To: <CAPRPZsCxBX95RfY1-3LFSMPpoRxHTw_Pj5TzrT-oX6PkrMhOQA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai , irq and pci
Reply-To: johann.obermayr@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Am 05.03.2014 20:59, schrieb Jeroen Van den Keybus:
>
>     >> task0 is one high prior in primary domain on core0.
>     >> this task wait for event, that is fired by fpga irq.
>     >> than this task will make some pci accesses to the fpga.
>
>
> A while ago (11/02) you wrote to this list ('[Xenomai] Xenomai and pci 
> access') because you had issues with PCI transfers. Did you fix those 
> ? How large are your transfers ?
The old part we have fixed. (but not very beautyful). But it work.

Our write transfer has 10kByte, and this need 1,8 ms. And our system 
work with
1ms ticks. That  mean , our rt-task will start every 1ms.

>
>     >> the other task (task1) is a shadow task, but running in
>     secondary domain
>     >> on core 1.
>     >> This task make many big memcpy to sram.
>
>
> I remember having asked for the complete PCI bus layout and to try out 
> other memory access methods besides memcpy. Did this do anything ?
>
We can't change the memcpy function.

> Since you mention you have an FPGA, I would now suggest instrumenting 
> it (add some logging) as to find out when and how (regular intervals 
> or with interruptions) your FPGA is accessed by the PCI bus.
>
Now we will measure all available hardware points.
FPGA output, PCI bus, PCIe ??,  and than the interrupt line to the core.
