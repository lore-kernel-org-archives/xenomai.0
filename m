Message-ID: <43B9711A.1070609@domain.hid>
Date: Mon, 02 Jan 2006 19:29:46 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCHES] various fixes
References: <43B92C73.6080004@domain.hid>
In-Reply-To: <43B92C73.6080004@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi again,
> 
> I would like to remind of the following three patches:
> 
>  * rtdm-excl-dev.patch - RTDM fix for bug in opening of exclusive
>    devices (both 2.0 and 2.1)

Merged.

>  * rtdm-nrt-close.patch - don't permit RTDM devices without NRT closure
>    handlers

Merged.

>  * maxlat_proc.patch - export NMI watchdog threshold via /proc, trigger
>    trace freezing instead of die_nmi() if CONFIG_IPIPE_TRACE is enabled

Merged.

> 
> Moreover, here are two minor fixes:
> 
>  * accuracy.patch - add missing define to let this posix demo compile

Discarded.

>  * rtdm-license.patch - add missing COPYING files to RTDM skin and lib
>    (or go for just a single file for ksrc/skins and src/skins if this is
>    applicable)
> 

Applied, thanks.

-- 

Philippe.

