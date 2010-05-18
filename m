Message-ID: <4BF2F73C.7070605@domain.hid>
Date: Tue, 18 May 2010 22:23:24 +0200
From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
MIME-Version: 1.0
References: <2319761F7FA0D1479BA77EC2E0A8E7BCE3D6E7@domain.hid><245373446233674495BCA5CA2FC1EB17378D01593B@RCexchangeSVR1.ruggedcom.local>	<4BED2910.6020105@domain.hid>
	<181804936ABC2349BE503168465576460EBD6239@domain.hid>
	<4BF17464.5090100@domain.hid>
	<181804936ABC2349BE503168465576460EBD62C8@domain.hid>
	<4BF251EC.7040605@domain.hid> <4BF267D3.4040500@domain.hid>
	<4BF28401.6060503@domain.hid> <4BF28B0C.3080705@domain.hid>
	<4BF2AB19.5060701@domain.hid> <4BF2DF77.90806@domain.hid>
In-Reply-To: <4BF2DF77.90806@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Question about getting system time
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "Kiszka, Jan" <jan.kiszka@domain.hid>, Andreas Glatz <AndreasGlatz@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Wolfgang Mauerer wrote:
>>> On the one hand you make complicated code (which will be costly on low
>>> end hardware) to avoid shutting interrupts around a few assignments, but
>>> on the other hand you leave an architecture specific function pointer
>>> call where we want a fast behaviour on average (remember, we do all this
>>> to avoid a system call, which is only a few hundreds nanoseconds on your
>>> big iron x86), and where we have a generic fast replacement. Sometimes,
>>> I do not understand your logic.
>> But using the same argument, you could get rid of Linux vsyscall based
>> gettimeofday()...
> 
> I do not see your point, the Linux code does not go a long way to make
> lockless code, it simply turns off interrupts around the gtod data
> update, which is really reasonable given the size of the masking
> section. The reading is lockless, the writing is not.
> 
I was referring to the argument that system calls are so fast that
replacing gtod with a syscall-less version that uses function
pointer dereferencing instead does not make much of a difference.

Be it as it may, I need to check how far our budget can cover
the (much more comprehensive) modifications required for the
solution suggested by you. Let's see.

Regards, Wolfgang

