Message-ID: <4CB552F2.90500@domain.hid>
Date: Wed, 13 Oct 2010 08:34:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTik6p=tM+JWHhsp8McPo+ZydtTZZk6ay-Ot_pgRk@domain.hid>
In-Reply-To: <AANLkTik6p=tM+JWHhsp8McPo+ZydtTZZk6ay-Ot_pgRk@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] HELP: Real-time Drivers
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Warner <xenomai.start@domain.hid>
Cc: xenomai@xenomai.org

Peter Warner wrote:
> Dear Xenomai Users,
> 
> I want to develop the real-time driver for my UART(RS-232) can any one
> please Suggest How can I develop it.
> Can I get Example Code and what are the different API I need to use.

Hi Peter,

the API used to write drivers is the RTDM API, you will find an overview
of this API here:

http://www.xenomai.org/documentation/branches/v2.3.x/pdf/RTDM-and-Applications.pdf

And its documentation here:
http://www.xenomai.org/documentation/xenomai-2.5/html/api/group__rtdm.html

A serial driver would be an RDM driver implementing the "Serial devices"
profile.

An example of such driver is the driver for the 16550A driver in Xenomai
sources.

> What are the Different Compilation and Linker flag I need to use.

A driver is implemented in kernel-space, so, you do not care about these
details, you just use the Linux kernel build system to compile the
driver module. You can look at the 16550A driver Makefile.

-- 
                                                                Gilles.

