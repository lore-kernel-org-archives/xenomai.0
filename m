Message-Id: <E6592CDB-2673-43B9-ABB9-24A8630319DD@suddenlink.net>
From: Steven Seeger <steven.seeger@domain.hid>
In-Reply-To: <4A7B3DD9.4030000@domain.hid>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v935.3)
Date: Thu, 6 Aug 2009 17:01:53 -0400
References: <8b216e9e0908050557s3789edcdq5b8b6b88bf52861b@domain.hid>
	<4A7B3DD9.4030000@domain.hid>
Subject: Re: [Xenomai-help] Slow boot with Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org


On Aug 6, 2009, at 4:32 PM, Gilles Chanteperdrix wrote:

> The Geode is a very very bad choice:
> - it is going to disappear any time soon
> - its performances in many domains are far from the average x86
> performances.

Agreed.

>
> Ok. I guess your Geode does not have an APIC. I have a Geode and just
> checked, it has the same issue, so, you should turn of apic in kernel
> configuration. Maybe something is needed in the BIOS to enable it
> (because the AMD specs say that the Geode has an APIC).

I've also tried to figure out how to get it to work with both a GX1  
and an LX-800 and cannot get it to work. I have read on other lists  
that there is no APIC.

> Probably an issue induced by power management disabling the tsc. So  
> the
> usual advices apply, please be sure to disable any smart power
> management issue in the bios configuration and to boot with ACPI  
> enabled
> (except ACPI_PROCESSOR). Someone, a long time ago, posted on the RTAI
> mailing list a way to disable this tsc thing by running an outb at a
> well defined address, but I never was able to test it since my Geode
> does not have this issue. Another workaround reported to work is to  
> boot
> with idle=poll passed on the command line. Yet another workaround is  
> to
> avoid using the tsc (by selecting in the kernel configuration a
> processor without tsc), but this means a lot of overhead.

We use TSC with idle=poll and things work correctly. However, the  
power saving mode will not run. However, gx1 is efficient and does not  
require a heatsink or fan, so it will not hurt your hardware. If you  
are running off a battery then you might want to use another approach.

The big issue with geode is the SMI overhead. It's terrible, and it  
will be a thorn in your side as you try to minimize jitter. I suggest  
you consider another board. Someday when I get some time, I may try  
and look into an smi disable function for geode. I think Gilles was  
going to look into it at some point, too. I've not really had a chance  
to work with Xenomai since May as the company I assist part time has  
been working on other things lately.

Steven


