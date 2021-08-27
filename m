From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <87v93rjb2o.fsf@xenomai.org>
Content-Type: text/plain; charset="utf-8"
Date: Fri, 27 Aug 2021 15:44:42 +0200
MIME-Version: 1.0
Message-ID: <1202-6128ec80-1e5-1ab27320@266372968>
Subject: =?utf-8?q?Re=3A?= Doing DMA from peripheral to userland memory
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Le Vendredi, Ao=C3=BBt 27, 2021 15:01 CEST, Philippe Gerum <rpm@xenomai=
.org> a =C3=A9crit: 
 
> 
> Fran=C3=A7ois Legal via Xenomai <xenomai@xenomai.org> writes:
> 
> > Hello,
> >
> > working on a zynq7000 target (arm cortex a9), we have a peripheral =
that generates loads of data (many kbytes per ms).
> >
> > We would like to move that data, directly from the peripheral memor=
y (the OCM of the SoC) directly to our RT application user memory using=
 DMA.
> >
> > For one part of the data, we would like the DMA to de interlace tha=
t data while moving it. We figured out, the PL330 peripheral on the SoC=
 should be able to do it, however, we would like, as much as possible, =
to retain the use of one or two channels of the PL330 to plain linux no=
n RT use (via dmaengine).
> >
> > My first attempt would be to enhance the dmaengine API to add RT AP=
I, then implement the RT API calls in the PL330 driver.
> >
> > What do you think of this approach, and is it achievable at all (DM=
A directly to user land memory and/or having DMA channels exploited by =
xenomai and other by linux) ?
> >
> > Thanks in advance
> >
> > Fran=C3=A7ois
> 
> As a starting point, you may want to have a look at this document:
> https://evlproject.org/core/oob-drivers/dma/
> 
> This is part of the EVL core documentation, but this is actually a
> Dovetail feature.
> 

Well, that's quite what I want to do, so this is very good news that it=
 is already available in the future. However, I need it through the ipi=
pe right now, but I guess the process stays the same (through patching =
the dmaengine API and the DMA engine driver).

I would guess the modifications to the DMA engine driver would be then =
easily ported to dovetail ?

Fran=C3=A7ois 

> -- 
> Philippe.


