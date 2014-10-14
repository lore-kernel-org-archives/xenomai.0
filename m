MIME-Version: 1.0
In-Reply-To: <CABVE6k1FMjKKskUnBO-pDg1O6KnEU0xQrEXkkO7RZwAZtCxkJg@mail.gmail.com>
References: <CABVE6k0wMQ-qzuvgueGY0AVOdRJZ5Vgq2JX8q=w_WG65GD5CRw@mail.gmail.com>
 <20141014045037.GA10453@sisyphus.hd.free.fr>
 <CABVE6k1FMjKKskUnBO-pDg1O6KnEU0xQrEXkkO7RZwAZtCxkJg@mail.gmail.com>
Date: Tue, 14 Oct 2014 10:06:56 +0200
Message-ID: <CAPRPZsCMZTGSLZ62n0qqwGjejQ+KudrgD=NbbFx_e9p6J2MicQ@mail.gmail.com>
From: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Xenomai: /dev/rtheap is missing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Hasret_Sar=C4=B1yer?= <hsrtsryr@gmail.com>
Cc: Xenomai <Xenomai@xenomai.org>

> There are below i-pipe verison under Xenomai 2.6.4 patches folder. So, I
> installed kernel 3.14.17.
>
> ipipe-core-3.10.32-x86-4.patch
> ipipe-core-3.8.13-x86-4.patch
> ipipe-core-3.14.17-x86-4.patch
>


The point the previous posters are trying to make is that you did _*build_*
the 3.14 kernel, but you apparently aren't _*running_* it (which is what
'uname' tells you, BTW the build date is there as well, Aug. 3, a dead
giveaway). You are just rebooting into your original 3.16 kernel which has
no Xenomai support of course.

If you can't spot this right away, I'm afraid you may not be ready for this
yet and I would advise you to get acquainted with building a Linux kernel
from kernel.org first (and selecting that kernel to boot) before even
attempting to patch it.

Most importantly, by 'getting acquainted' I mean that you should thoroughly
understand what you are doing and not just follow steps from an online
guide.


J.

_______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>
