Message-ID: <4C2F94F1.5080002@domain.hid>
Date: Sat, 03 Jul 2010 21:52:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1278071353-13836-1-git-send-email-wolfgang.mauerer@domain.hid>
	<1278071353-13836-5-git-send-email-wolfgang.mauerer@domain.hid>
	<4C2F25C1.3050801@domain.hid> <4C2F9028.7010406@domain.hid>
In-Reply-To: <4C2F9028.7010406@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 4/7] nucleus: Add CLOCK_HOST_REALTIME
 bits to	nkvdso
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Cc: "Kiszka, Jan" <jan.kiszka@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Wolfgang Mauerer wrote:
> Gilles Chanteperdrix wrote:
>> Wolfgang Mauerer wrote:
>>> Augment the shared vdso page with all data required to
>>> implement a clock CLOCK_HOST_REALTIME that provides time
>>> information synchronised with the NTP-corrected time
>>> in the Linux kernel.
>>>
>>> The definition of the hostrt data is placed in a separate
>>> head file so that we can use it irregardless of pervasive
>>> rt support is compiled in or not.
>> Ok. Would not it be more simple to define the nkvdso even without
>> pervasive support?
> 
> Thought about that, but having a shared kernel/userland object
> without pervasive RT support seemed a bit unnatural to me.

The idea would be to have a static nkvdso in the non-pervasive case, we
do not need the mapping stuff. But at least, if we do this once and for
all for nkvdso, we will not have to repeat the code which handles the
non-pervasive case for all the data in nkvdso which need to exist in
that case.

-- 
					    Gilles.

