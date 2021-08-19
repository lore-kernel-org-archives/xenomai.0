References: <CAHk=vNFHsSE5iaJd30tSxEDiNBD+w2hmuhnY7CD7Rz6EyjqtJg@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: xenomai-4 on raspberry-pi-4
In-reply-to: <CAHk=vNFHsSE5iaJd30tSxEDiNBD+w2hmuhnY7CD7Rz6EyjqtJg@mail.gmail.com>
Date: Thu, 19 Aug 2021 15:04:34 +0200
Message-ID: <87a6ldy49p.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Hans Petersen <hpetersenlg@googlemail.com>
Cc: xenomai@xenomai.org


Hans Petersen via Xenomai <xenomai@xenomai.org> writes:

> Hi, everyone,
>
> I'm trying to get XENOMAI-4 to run on the Raspberry-PI-4.
>
> For this I downloaded the source files '*v5.10.y-evl-rebase*' and compiled
> them with 'bcm2711_defconfig'.
>
> Unfortunately, the image does not work because many specific files, such as
> the device tree and the broadcom drivers and serveral config-flags, are
> missing in the source tree.
> However, these are also missing in the mainline kernel.
>

Xenomai targets mainline kernels exclusively.

> I can load a kernel version *'5.10.52*' from the *Raspbian repository*.
>
> *Now my question*:
>
> Is there a possibility to patch XENOMAI4 into the Raspbian sources, or any
> other way to install a Xenomai-4 on the Raspberry-PI-4?
>

Unlike its predecessors, Xenomai 4 does not use the patch model, it is
directly developed into the target kernel.

FWIW, I have been running EVL based on the mainline kernel on the rpi4
for more than a year now (headless system though), and this is actually
one of my workhorses for testing it. If you really need to run a vendor
kernel, then you are pretty much on your own unfortunately; you might
try to apply the 5.10.y..5.10.y-evl-rebase diff set to a Raspbian kernel
based on the same mainline version.

-- 
Philippe.

