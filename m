Message-ID: <5317539C.5040700@xenomai.org>
Date: Wed, 05 Mar 2014 17:41:00 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <53174F44.6000309@sigmatek.at>
In-Reply-To: <53174F44.6000309@sigmatek.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 03/05/2014 05:22 PM, Johann Obermayr wrote:
> Hello,
> 
> celeron dual core with PCIe - PCI bridge
> we use kernel 3.10.xx smp with  (isolcpus=0)
> smi is disabled.
> xenomai 2.6.3
> 
> we have a pci card with a fpga (with irq) and sram.
> 
> we have 2 task running.
> 
> task0 is one high prior in primary domain on core0.
> this task wait for event, that is fired by fpga irq.
> than this task will make some pci accesses to the fpga.
> 
> the other task (task1) is a shadow task, but running in secondary domain 
> on core 1.
> This task make many big memcpy to sram.
> 
> in the ipipe_handler_irq we have a function callback.
> a small driver hooks to this callback add make some tracepoint into
> a shared memory.
> 
> with the trace we see some time a very high jitter in the ipipe_handler_irq
> function (around 250 us).
> has anyone an explanation for this?
> 
> and a 4 byte access from task0 to fpga need more than 300us,
>   while task1 is writing to sram.

Maybe the problem is the size of the PCI burst when writing to the SRAM?
How large is it? If the sram is mapped with "write-combine", it will be
buffered and written in large bursts. Maybe you could try mapping the
sram area uncached?

-- 
                                                                Gilles.

