Message-ID: <48EC5C57.8090909@domain.hid>
Date: Wed, 08 Oct 2008 09:08:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OF18FABCEE.31B1EBFE-ONC12574DC.001E5390-C12574DC.001F8407@domain.hid>
In-Reply-To: <OF18FABCEE.31B1EBFE-ONC12574DC.001E5390-C12574DC.001F8407@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] question concerning xeno-test, latency, cyclic
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: juergen.lanner@domain.hid
Cc: xenomai@xenomai.org

juergen.lanner@domain.hid wrote:
> Wed Sep 3 11:01:54 CEST 2008
> running: md5sum /proc/cpuinfo # cpuinfo fingerprint
> 16c62e2579214d8da356a8085a11bac1 /proc/cpuinfo
> CONFIG_PREEMPT_NOTIFIERS=y
> # CONFIG_PREEMPT_NONE is not set
> CONFIG_PREEMPT_VOLUNTARY=y
> # CONFIG_PREEMPT is not set
> CONFIG_IPIPE=y
> CONFIG_IPIPE_DOMAINS=4
> CONFIG_IPIPE_COMPAT=y
> CONFIG_PM=y
> CONFIG_PM_LEGACY=y

You should disable PM and PM_LEGACY.

> CONFIG_PM_DEBUG=y
> # CONFIG_PM_VERBOSE is not set
> # CONFIG_PM_TRACE_RTC is not set
> CONFIG_PM_SLEEP_SMP=y

Give its name, you should really disable PM_SLEEP_SMP

> CONFIG_PM_SLEEP=y
> CONFIG_PM_STD_PARTITION=""
> # CONFIG_ACPI is not set

You should enable ACPI (but not ACPI_PROCESSOR)

> # CONFIG_CPU_FREQ is not set
> # CONFIG_IPIPE_DEBUG is not set
> # CONFIG_DEBUG_SPINLOCK is not set
> # CONFIG_DEBUG_SPINLOCK_SLEEP is not set

-- 
					    Gilles.

