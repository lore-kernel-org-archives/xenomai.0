MIME-Version: 1.0
In-Reply-To: <5045AD78.3090904@ebus.com>
References: <50405C4F.5030301@ebus.com> <50406A3D.4080801@xenomai.org>
	<5043F063.2020302@ebus.com> <50444008.4000109@xenomai.org>
	<5045AD78.3090904@ebus.com>
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 4 Sep 2012 02:53:05 -0600
Message-ID: <CAJfuBxyq9QqkNW_1823tDwh7yCBfr2tk+5=y6JKrXc1x49-SMQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Upgrading to Xenomai 2.6.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Doug Brunner <dbrunner@ebus.com>
Cc: xenomai@xenomai.org

> and IPv6), the system experiences ATA faults such as the following
> immediately upon trying to boot:
>
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> ata1.00: failed command: READ DMA
> ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
>

FWIW, I have a soekris 4801 (with a Geode sc1100) that gets the same errs.
IIUC, its a board problem with CF, but it could have a deeper (more
common) cause.

Ive added libata.dma=3 to my boot options in grub menu.lst,
which fixes it reliably.
older kernels might want all_generic_ide or libata.nodma=0.0 ( for sda1 )


> Finally, after several of these with long delays in between, it panics
> because it can't find the root filesystem on the ATA device it's trying to
> access (CF card via the CS5536 controller).
>
> The same config minus the ipipe stuff, fed to an unpatched kernel tree,
> produces a binary that will boot the system with no error messages; this is
> true for both 3.2.21 and 3.4.6. Any idea what could be doing this, or what
> else I can do to debug? I've attached my configs for reference, except the
> 3.4.6 ipipe which I forgot to save.
>
> Thanks,
>     --Doug Brunner

