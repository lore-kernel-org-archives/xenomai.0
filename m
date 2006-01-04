Message-ID: <43BBE1A4.1080902@domain.hid>
Date: Wed, 04 Jan 2006 15:54:28 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <43BBDA7D.3020600@domain.hid>
In-Reply-To: <43BBDA7D.3020600@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: "xenomai" prefix in RTDM userspace includes
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
> Hi,
> 
> the current RTDM profile headers (so far only rtserial.h and
> rtbenchmark.h) suffer from the "xenomai" prefix in the include path.
> This was introduced with 2.1. An example: rtserial.h contains "#include
> <xenomai/rtdm/rtdm.h>" which is fine in kernel space but requires that -
> in my eyes - ugly "xenomai"->"." link in the installation include dir.
> Moreover, it makes the RTDM profile headers Xenomai-specific (what they
> are not).
> 
> The orginal (but nowhere stated - yeah) idea was to always have a
> "rtdm/" dir in the include path whenever writing a RTDM driver or
> application for some supported environment. So I would rather like to
> see the Makefiles for Xenomai's RTDM drivers fixed in this regard,
> simply by adding
> 
> EXTRA_CFLAGS += -Iinclude/xenomai
> 
> This would allow to use the generic "#include <rtdm/rtdm.h>" in the
> profile headers again. Tweaking the Makefiles instead of the headers is
> also the way we handled this for drivers outside Xenomai (RTnet,
> rt_sja1000, ...).
> 
> Objections?
> 

None, provided we always keep on preventing naming conflicts. Prefixing 
with rtdm/ or xenomai/ does the job equally well.

> Jan
> 
> 
> PS: A cleanup of the RTDM userspace header installation is scheduled -
> only rtdm.h + the profile header will survive this.


-- 

Philippe.

