From: Nitin Kulkarni <nitink@kth.se>
Date: Tue, 11 Jul 2017 16:09:20 +0000
Message-ID: <1499789361790.71907@kth.se>
References: <1499675553334.21481@kth.se>,
 <1674e595-4155-488f-64a0-3017bb4cb994@xenomai.org>
In-Reply-To: <1674e595-4155-488f-64a0-3017bb4cb994@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Kernel Warning : I-pipe: Detected illicit call from
 head domain 'Xenomai'
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Philippe,=0A=
Thanks for the answer. Can you refer me to any DMA driver that you integrat=
ed with ipipe ?=0A=
I found out that the DMA driver running is that idam64 and as you mentioned=
 it hooks to the generic DMA engine frame work=0A=
with the handlers implemented in idma64.c .=0A=
=0A=
I still have one question though, Do we adda real-time irq handler or  keep=
 the existing non-realtime interrupt (through request_irq) for the DMA ? We=
 need the callback to be in real-time, so how is that possible without addi=
ng a realtime irq ?=0A=
=0A=
I think a reference will help me understand how to port the dma driver. =0A=
=0A=
Thanks a lot for the guidance. =0A=
=0A=
- Nitin =0A=
=0A=
  =0A=
=0A=
________________________________________=0A=
From: Philippe Gerum <rpm@xenomai.org>=0A=
Sent: Monday, July 10, 2017 8:25 PM=0A=
To: Nitin Kulkarni; xenomai@xenomai.org=0A=
Subject: Re: [Xenomai] Kernel Warning : I-pipe: Detected illicit call from =
head domain 'Xenomai'=0A=
=0A=
On 07/10/2017 10:32 AM, Nitin Kulkarni wrote:=0A=
> Hi,=0A=
>=0A=
> I am getting this message from I-Pipe trace when I enabled the I-pipe deb=
ug option.=0A=
>=0A=
> Does this affect the performance of my driver in terms of execution time =
? and does this mean it switches mode from primary to=0A=
>=0A=
> secondary mode ?=0A=
=0A=
This message basically means that your system is no more in a reliable=0A=
state, you just can't ignore it.=0A=
=0A=
>=0A=
> Background:=0A=
>=0A=
> I am trying to port the linux spi-driver to rtdm driver and instead of go=
ing all the way from scratch=0A=
>=0A=
> I thought of just trying to remove all the linux related scheduling and t=
ry to initiate the transfer directly in=0A=
>=0A=
> real-time domain. I think I have done that partially (dma completion inte=
rrupt is still in non-real time domain) but I get this message the first ti=
me when I send some data over spi. I know that it is because of some memory=
 allocation for setting the dma buffers=0A=
>=0A=
> but the transmission is successful and quite quick now because I removed =
the mechanism used by linux which used tasklets=0A=
>=0A=
> and work queues to schedule the transfer.  I just want the transfer to st=
art as soon as possible triggered by an interrupt.=0A=
>=0A=
Sharing the DMA engine between the regular Linux kernel and the Cobalt=0A=
co-kernel would require significant adjustments to the DMA engine code,=0A=
you can't do that by simply calling the DMA API from primary mode, this=0A=
would be fundamentally unsafe.=0A=
=0A=
Bottom line: both kernels run asynchronously for the most part, with=0A=
Cobalt preempting the Linux kernel in sections that are otherwise deemed=0A=
atomic, from Linux's standpoint. The interrupt pipeline machinery makes=0A=
this possible. The price to pay for this is that you may not re-enter=0A=
the regular Linux kernel code from a context which might have preempted=0A=
it in the middle of nowhere, so to speak.=0A=
=0A=
Some hints about a working approach I've used a couple of times already=0A=
for sharing a DMA engine. Assuming the DMA chip on this board is driven=0A=
by the generic dmaengine framework, it is possible to extend the latter=0A=
with a couple of (per-chip) handlers allowing to prepare and monitor=0A=
transfers from a real-time  context (i.e. Cobalt primary mode). Those=0A=
handlers are defined in the dma_device structure, and implemented in the=0A=
DMA backend code which is DMA engine-specific.=0A=
=0A=
Cobalt would then use a dedicated set of DMA channels obtained via=0A=
dma_request_slave_channel() as usual, but controlled exclusively from=0A=
these new handlers, for running real-time SPI transfers.=0A=
=0A=
Typically, you would have a handler to prepare a transfer, maybe another=0A=
one to wait for an ongoing transfer to finish, all from/to a real-time=0A=
Cobalt context, instead of a plain Linux context. You would have to make=0A=
 sure that your implementation never attempts to synchronize/serialize=0A=
on  regular Linux spinlocks/mutexes/sema4 etc.=0A=
=0A=
Interfacing with the IRQ subsystem for asynchronous handling of the DMA=0A=
completion may be the main issue here if you need to, because the normal=0A=
linux activities would still expect to receive end-of-transfer IRQs in=0A=
the "root" domain as usual (request_irq interface) in parallel to the=0A=
real-time activities, which would then be incompatible with assigning=0A=
the DMA IRQ to the head/Cobalt domain (rtdm_irq_request()) exclusively.=0A=
If you can live with receiving end-of-transfer IRQs without rt=0A=
guarantees in the Linux domain though, then you don't have to deal with=0A=
this problem.=0A=
=0A=
--=0A=
Philippe.=0A=

