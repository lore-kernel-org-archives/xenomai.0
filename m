MIME-Version: 1.0
References: <CAPEvDeA7NmYqVwMwkwTnKJAKubqdREYZo+myHxkpDADu4_-q4w@mail.gmail.com>
 <CAFLxGvwvESJZ8kouFumFoQr3Q6mZ__GQ8rzprGPV4xZ+GzAHfw@mail.gmail.com>
In-Reply-To: <CAFLxGvwvESJZ8kouFumFoQr3Q6mZ__GQ8rzprGPV4xZ+GzAHfw@mail.gmail.com>
From: FanJun Kong <bh1scw@gmail.com>
Date: Fri, 15 Apr 2022 09:11:35 +0800
Message-ID: <CAPEvDeBYjSHmZHJbiG8KuCtcWwmpq1MgZbrf54_Qzb6iyqjtrQ@mail.gmail.com>
Subject: Re: 'make bzImage' compile error at x86_64 platform: FAILED
 unresolved symbol udp_sock
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

I met some error when I was building kernel 5.10

FAILED unresolved symbol udp_sock
make: *** [Makefile:1179: vmlinux] Error 255

and when I make some changes to .config, another error shows up

FAILED unresolved symbol udp6_sock
make: *** [Makefile:1179: vmlinux] Error 255

If I disable CONFIG_NET no error any more,

and I found another bug exactly same with mine:
https://www.mail-archive.com/xenomai@xenomai.org/msg21778.html

but, when I using prepare-kernel.sh to apply patch from fresh and build all
again, it works

I found a similar bug here:
https://www.mail-archive.com/netdev@vger.kernel.org/msg358778.html

Thanks very much.

Kong

On Thu, Apr 14, 2022 at 6:37 PM Richard Weinberger <
richard.weinberger@gmail.com> wrote:

> On Thu, Apr 14, 2022 at 9:24 AM FanJun Kong via Xenomai
> <xenomai@xenomai.org> wrote:
> >
> > Hi, developer
> > I met this on Arm64 and I am using 5.10.89 + xenomai3.2.1
>
> Can you please share the full error message you get?
> I'd like to know which function/object needs udp_sock.
>
> --
> Thanks,
> //richard
>
