Message-ID: <4B167FC4.8080904@domain.hid>
Date: Wed, 02 Dec 2009 15:55:00 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B1663B9.8030306@domain.hid>
	<4B166A5B.6030400@domain.hid>	<4B166EFB.8050309@domain.hid>
	<4B16769A.9060700@domain.hid>	<4B167A55.8080407@domain.hid>
	<4B167B4B.3010804@domain.hid>
In-Reply-To: <4B167B4B.3010804@domain.hid>
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
>> Why? It delivers us the core mechanism we need for the rest as well -
>> and it does not require fancy I-pipe hooks.
> 
> Because relying on the vdso/vsyscall only works on x86. Whereas
> implementing clock slew down/acceleration at nucleus level and simply
> sharing data between kernel and user through the the global sem heap,
> works for all architectures.

There are three kind of archs:
 - those that already support vgettimeofday & friends (x86, powerpc,
   maybe more)
 - those that do not yet though they could (I strongly suspect arm falls
   into this category as well)
 - those that never will (due to lacking user-readable time sources)

We need temporary/permanent i-pipe workarounds for the last two, but I
see no point in complicating the first category. This design aims at a
longer term.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

