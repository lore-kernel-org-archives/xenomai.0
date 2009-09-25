Message-ID: <4ABCCFF8.1060607@domain.hid>
Date: Fri, 25 Sep 2009 16:13:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <26553515.371391253884926657.JavaMail.coremail@domain.hid>
In-Reply-To: <26553515.371391253884926657.JavaMail.coremail@domain.hid>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] Porting rtai/linux applications to xenomai/linux
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?6Z+p5a6I6LCm?= <hshouqian@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

韩守谦 wrote:
> 
> Hello everyone！ I'm Porting rtai/linux applications to xenomai/linux.
> I want to swith  RTAI API to  Xeno's native API. Now I have a
> problem:we know,rtai provides a kernel module: math.ko, so we can use
> math funtions in our kernel modules of our applications ,but xenomai
> doesn't provide the same functions. what should I do? My kernel
> module of application need  some math functions.

As we already told in former posts, we do not support the math module,
and do not intend to support it.

Using math functions in kernel-space is probably the sign of a design
which does too many things in kernel-space. Move the computations to
user-space. Besides, using hardware maths in kernel-space has become
harder, since the linux kernel compilation flags contain -msoft-float by
default.

-- 
                                          Gilles


