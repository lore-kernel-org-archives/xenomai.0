Message-ID: <2ff1a98a0709260208t5dfb04aen70e0781404fb868@domain.hid>
Date: Wed, 26 Sep 2007 11:08:07 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <22562.97598.qm@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <22562.97598.qm@domain.hid>
Subject: Re: [Xenomai-help] (no subject)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "sysace@domain.hid" <sysace@domain.hid>
Cc: xenomai@xenomai.org

On 9/26/07, sysace@domain.hid <sysace@domain.hid> wrote:
> Hello,
>
> I'm working on a Xenomai kernel module and I need to
> use mathematical functions (like those included in
> math.h).
>
> Is there a way to use this kind of functions in the
> kernel or shall I switch to an user space application
> ?
>
> Thank you for your answer.

There was a recent discussion on this subject. The answer is that if
you want the mathematical functions in kernel-space, which means
compiling the math functions of a libc in kernel space, it is possible
because Xenomai supports using FPU in kernel-space, but you are on
your own, such a math support will never be added to Xenomai sources.

The supported way is to use mathematical functions in user-space.

-- 
                                               Gilles Chanteperdrix

