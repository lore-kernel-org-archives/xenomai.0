Message-ID: <4400B369.4000509@domain.hid>
Date: Sat, 25 Feb 2006 20:43:37 +0100
From: Hannes Mayer <h.mayer@domain.hid>
MIME-Version: 1.0
References: <200602141114.23856.lbocseg@domain.hid>	<200602161514.44451.lbocseg@domain.hid>	<1140707273.8504.27.camel@domain.hid>	<200602231443.05861.lbocseg@domain.hid>
	<43FE4785.90204@domain.hid>
In-Reply-To: <43FE4785.90204@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] RTDM w/MMAP demo online (was: Re: [Xenomai-help]
	rtdm_mmap_to_user()
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
Cc: xenomai@xenomai.org, xenomai@xenomai.org

Ciao Jan et al.!

Jan Kiszka wrote:
[...]
> ClearPageReserved analogously to SetPageReserved.

Yeah, that did the trick! If one opens a door, a polite guy
also close it again ;-)

My RTDM demo driver is now online at:
http://www.captain.at/xenomai-real-time-driver-example.php

I've also modified user.c - now I'll check if the user has
interrupted the user-app (i.e. the device was closed) to
avoid segfaulting when accessing the MMAP pointer after the
dev was closed.

Comments, corrections, exhancements etc. very welcome!

Thanks and best regards,
Hannes.

