Message-ID: <2ff1a98a0710020246n77193f6djf5d36af6630c36a0@domain.hid>
Date: Tue, 2 Oct 2007 11:46:07 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <200710020940.l929ep0p021831@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2ff1a98a0710020211r15932aafheffb53d55a7d1691@domain.hid>
	<200710020940.l929ep0p021831@domain.hid>
Subject: Re: [Xenomai-core] [Xenomai-help] rt_task crash kernel
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Patrick <kpa_info@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On 10/2/07, Patrick <kpa_info@domain.hid> wrote:
>
>
>
>
> Yes, I have tried with bin/latency user space application and the system
> crashes.

latency appears to crash on ARM when launched with the default 100us
period, the system is just too busy. Do you observe the crash with a 1
ms period ?

-- 
                                               Gilles Chanteperdrix

