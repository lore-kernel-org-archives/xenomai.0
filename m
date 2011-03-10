Message-ID: <4D78CC23.5030302@domain.hid>
Date: Thu, 10 Mar 2011 14:03:31 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTim6O4XMWav05C5LRKN3snqeicZbCzqB-czkx2sW@mail.gmail.com>
	<4D787DB7.2020503@domain.hid>
In-Reply-To: <4D787DB7.2020503@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rtdm_printk
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Weber <jwamsc@domain.hid>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Jeff Weber wrote:
>> When writing a RTDM kernel module driver, when must rtdm_printk() be used
>> instead of printk() ?
> 
> If RTDM was, one day, ported over something else than a Linux
> kernel-space based solution (for instance, over a port of Xenomai
> without Linux, or in Linux user-space), then you would not have to
> change your driver codeto have it compile over that new port.
> 
> Until then, printk and rtdm_printk are identical.
> 
> Note that the first paragraph is something very hypothetical, because in
> an RTDM driver, you generally have some other Linux kernel-space
> specific code, such as for instance the registration as a PCI driver,
> though the necessary parts of the Linux API could be implemented for
> that hypothetical port. But in that case, so could printk.
> 
> So...

I guess the real reason for rtdm_printk is that at some point in the
past (probably before the Adeos era), printk was not safe to be called
from the real-time domain. In that case, rtdm_printk would be safe to be
called from the real-time domain. So, the answer is that you should use
rtdm_printk if you are calling from a Xenomai domain interrupt handler,
or from the context of a thread running in primary mode.

-- 
					    Gilles.

