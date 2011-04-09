Message-ID: <4DA01784.3080201@domain.hid>
Date: Sat, 09 Apr 2011 10:23:32 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <68A9C7E0-33D0-4039-88AF-A1B62F1889BD@edu.hefr.ch>
In-Reply-To: <68A9C7E0-33D0-4039-88AF-A1B62F1889BD@edu.hefr.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] ioremap domain
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Doninelli Davide <Davide.Doninelli@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Doninelli Davide wrote:
> Hi,
> ioremap and related function like readw/l or writew/l are executed in which domain?

The notion of "service X is executed in domain Y", only applies to
user-space services, because such services go through syscalls, and
Xenomai is able to switch automatically the calling thread domain.

For kernel-space services, what matter are the contexts from which
calling the function is valid. By default, you should consider that all
Linux services can only be called from Linux domain. After all, Linux
services were not written with the Xenomai kernel in mind.

This applies to ioremap.

There are, however, some exceptions:
- some services are modified to work in non-Linux domain, this is the
case of printk, or the spinlock services (but only for ipipe spinlocks).
- some services do not rely on the integrity of any data in the Linux
kernel, these ones are naturally safe to be called from Xenomai domain
even though they were not modified in any way. memcpy is an example of
such service on most architectures, and so are readl and writel.

-- 
                                                                Gilles.

