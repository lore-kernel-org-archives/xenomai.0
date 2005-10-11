Message-ID: <434BD253.5060800@domain.hid>
Date: Tue, 11 Oct 2005 17:55:15 +0300
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] PATCH: fix ppc64 calibration
References: <1CFEB358338412458B21FAA0D78FE86D4F0E16@domain.hid>
In-Reply-To: <1CFEB358338412458B21FAA0D78FE86D4F0E16@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Fillod Stephane <stephane.fillod@domain.hid>
Cc: xenomai@xenomai.org

Fillod Stephane kirjoitti:
> Heikki Lindholm wrote:
> 
>>The old calibration value was from some ancient ppc32 embedded board,
> 
> I 
> 
>>guess. This reflects the awesome power of them ppc64 boxen better :)
> 
> 
> Actually, the ppc32 calibration value was from some ancient x86 machine,

Damn, that has been heretic from the processor wars POV, then! Some 
swift action IS necessary.

> I 
> guess. The same patch could be applied to asm-ppc/calibration.h. This 
> reflects the awesome power of them ppc32 boxen better :)

Probably, but there are less than awesome 4xx boards around and I'd 
guess they might even be more likely targets than G4 based machines, for 
example. Some tuning might be needed.

-- Heikki Lindholm



