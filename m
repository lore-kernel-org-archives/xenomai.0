Message-ID: <453C877B.7000307@domain.hid>
Date: Mon, 23 Oct 2006 11:12:27 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] x86 FPU switches routines.
References: <453C7C48.30602@domain.hid> <453C84FE.3050508@domain.hid>
In-Reply-To: <453C84FE.3050508@domain.hid>
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
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
> 
>>Hi,
>>
>>As once discussed with Heikki, and after a first missed attempt, here
>>is a patch for x86 which attempts to cope correctly with Linux (non
>>real-time) drivers using FPU in kernel-space.
>>
>>I tested it on my laptop without drivers using FPU, and it appears to
>>work correctly, but it would be nice if people that had problems with
>>the previous attempt (if I remember correctly, on old pentiums and on
>>AMD processors) could test this patch.
> 
> 
> Just fired up on a Pentium MMX which used to have problems with the
> first approad. Switchtest reports no problems.
> 
> What about writing a simple test case for the non-RT in-kernel FPU usage?

I plan to add it to the switchtest driver, but I wanted to make sure
that the new support already works in the usual case.

-- 
                                                  Gilles Chanteperdrix

