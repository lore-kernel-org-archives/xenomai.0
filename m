MIME-Version: 1.0
In-Reply-To: <4FCF0FD5.1050201@mail.polimi.it>
References: <4FCF0FD5.1050201@mail.polimi.it>
Date: Wed, 6 Jun 2012 10:51:27 +0200
Message-ID: <CA+eKTkb6m22yqmckZusuG+zdzx8pSn1To_hOcgXdEF7ini48sw@mail.gmail.com>
From: Hadrien Caron <hadrienstegosaure@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] analogy attach failed NI-6220
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Danilo De Lorenzo <danilo.delorenzo@mail.polimi.it>
Cc: Xenomai@xenomai.org

Hello Danilo,

I am no expert, but I had a similar issue when I forgot to enable the
analogy driver
in the kernel configuration (through menuconfig for example).

hope it helps,

Hadrien

On Wed, Jun 6, 2012 at 10:07 AM, Danilo De Lorenzo <
danilo.delorenzo@mail.polimi.it> wrote:

> Hi,
> I'm trying to make a NI-6220 acquisition board working with xenomai on a
> x86_64 patched kernel, but I'm getting the following error when I try to
> attach the device with the command:
>
> /usr/xenomai/sbin/analogy_**config analogy0 analogy_ni_pcimio 0xc,5
>
> The error is:
> analogy_config: attach failed err=-2
>
> I know that Xenomai is working well since I can run all the examples
> (latency, etc...).
>
> The dmesg command gave me only this error:
> [   69.926138] Analogy: a4l_assign_driver: call(drv->attach) failed
> (ret=-2)
>
>
> Thi is the lspci output for the board:
>
> 0c:05.0 Unassigned class [ff00]: National Instruments PCI-6220
>
> I also checked for shared IRQ, it seems there is no IRQ sharing with other
> devices and I also tried to change the PCI slot without success.
>
> Any help is appreciated
>
>
>
> ______________________________**_________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/**mailman/listinfo/xenomai<http://www.xenomai.org/mailman/listinfo/xenomai>
>
