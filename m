Message-ID: <4B1684D7.2080501@domain.hid>
Date: Wed, 02 Dec 2009 16:16:39 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B1663B9.8030306@domain.hid>
	<4B166A5B.6030400@domain.hid>	<4B166EFB.8050309@domain.hid>
	<4B16769A.9060700@domain.hid>	<4B167A55.8080407@domain.hid>
	<4B167B4B.3010804@domain.hid> <4B167FC4.8080904@domain.hid>
	<4B1681DA.3090108@domain.hid>
In-Reply-To: <4B1681DA.3090108@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Realtime gettimeofday()
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Wolfgang Mauerer <wm@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Why? It delivers us the core mechanism we need for the rest as well -
>>>> and it does not require fancy I-pipe hooks.
>>> Because relying on the vdso/vsyscall only works on x86. Whereas
>>> implementing clock slew down/acceleration at nucleus level and simply
>>> sharing data between kernel and user through the the global sem heap,
>>> works for all architectures.
>> There are three kind of archs:
>>  - those that already support vgettimeofday & friends (x86, powerpc,
>>    maybe more)
>>  - those that do not yet though they could (I strongly suspect arm falls
>>    into this category as well)
>>  - those that never will (due to lacking user-readable time sources)
>>
>> We need temporary/permanent i-pipe workarounds for the last two, but I
>> see no point in complicating the first category. This design aims at a
>> longer term.
> 
> Well, I may be wrong, but I prefer generic code to arch-specific code.
> Nucleus code to handle clock slow down/acceleration would be generic;
> I-pipe code to signal NTP syscalls would be generic (and yes, even if
> I-pipe patches are generated for all architectures, whether the code is
> generic or specific makes a big difference);
> User-space code to implement clock_gettime(CLOCK_REALTIME) using data
> shared through the global sem heap would be generic.
> 
> So, I think this design is future proof and easy to maintain. And I do
> not see how it complicates x86 situation, since it is only made of
> generic code.

Well, OK, then place a small optional I-pipe hook into that part that
normally writes the update into the vdso page (I think that is
arch-specific anyway), replicating it into a specified page the nucleus
may set up on a globally shared heap. That hook also has to maintain a
seqlock like Linux does, ie. generating the same layout and semantics.
It's just the transport mechanism, we can easily select it based on the
arch's level of support.

But I'm against any needless redirection through the nucleus (including
potential nklocks etc.).

> 
> Looks like we found a troll to occupy this afternoon :-).
> 

Yeah, would be a nice one if there weren't that qemu-kvm migration
issues I have to trace down in parallel... :)

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

