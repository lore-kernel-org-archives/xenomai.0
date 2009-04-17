Message-ID: <49E89830.90501@domain.hid>
Date: Fri, 17 Apr 2009 16:54:40 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <37f89760904170156l79103ccsbae12062a839ceeb@domain.hid>
In-Reply-To: <37f89760904170156l79103ccsbae12062a839ceeb@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RTDM_EXCLUSIVE
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Marcel Soulot <msoulot@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Marcel Soulot wrote:
> Hi,
> 
> I tested my driver with and without the device_flags RTDM_EXCLUSIVE.
> My test application wrote in C++ and compiled with gcc 4.3.2, crashs the
> kernel at the first called function "rt_dev_open" without RTDM_EXCLUSIVE and
> works fine if RTDM_EXCLUSIVE is set.
> Nothing use the driver except this test application.
> 
> does anyone have an idea of the reason of this problem ?

As we already told you: send us everything that will allow us to
reproduce the problem, that is at least a working (I mean something that
will not need anything else) kernel-space driver and user-space program.

-- 
					    Gilles.

