MIME-Version: 1.0
In-Reply-To: <4CB41FF2.9030602@domain.hid>
References: <4CB41FF2.9030602@domain.hid>
Date: Wed, 13 Oct 2010 08:31:10 +0200
Message-ID: <AANLkTi=kR0fT-NFOuC_z=Y8HNVaXu1j5f76VG1TVoFD5@domain.hid>
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai-core] Analogy regressions in xenomai 2.5.5.1
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Daniele Nicolodi <daniele@domain.hid>
Cc: xenomai@xenomai.org

Hi,

On Tue, Oct 12, 2010 at 10:44 AM, Daniele Nicolodi <daniele@domain.hid> wrote:
> Hello, I just installed xenomai 2.5.5 on a 2.6.35.7 kernel and I'm
> noticing serious regressions on analogy basic features:
>
> 1. Buffer management is badly broken. It is not possible to run any
> acquisition command that wraps around in the ring buffer. That can be
> simply reproduced with:
>
> cmd_read -v d analogy0 -s 0 -S 0
>
> after a while it will fail with: "cmd_read: a4l_read failed (ret=-32)".
> In dmesg the driver reports: "Analogy: MITE: DME overwrite of free area".

OK. Maybe, it is not Analogy's buffer management; it may be specific
to the NI driver. Did you try to reproduce the bug with another driver
(analogy_fake for example)? It may be due to some fix I made this
summer (which is surprising, I thought I tested the change quite
exhaustively... Sorry for that).

>
> 2. Buffer is kept memory mapped after the mapping process dies. If a
> process mapping a device buffer dies before un-mapping the buffer, it is
> not possible to reconfigure the bnuffer. a4l_set_bufsize fails with
> error code 32 and dmesg read "Analogy: a4l_ioctl_bufcfg: please unmap
> before configuring buffer". Sinche the mapping process died I do not
> know how to do this.
>
With a 2.4.x release, did you manage to reproduce the bug?

> When I proposed some easy changes to the analogy API, to make it much
> less confusing with trivial changes, Alexis expressed concerns about API
> stability. What about functional stability? I think the reported ones
> are major problems easily catch with simple pre-release tests...
>
> Cheers,
> Daniele
>
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
>

Alexis.

