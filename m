Message-ID: <4926A041.1000706@domain.hid>
Date: Fri, 21 Nov 2008 12:49:21 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <49268C78.5010600@domain.hid> <492690A5.8010703@domain.hid>
In-Reply-To: <492690A5.8010703@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Mark libs with nodlopen when
 using	initial-exec TLS
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Some naive optimist once claim that the dynamic linker would detect if
>> we try to dlopen some Xenomai lib (directly or indirectly) which uses
>> the optimised initial-exec TLS variables. He was wrong of course. It
>> takes the special marker nodlopen to achieve this, and that's what the
>> patch below does when and where required.
> 
> Ok. But I think we should document somewhere the fact that dlopening
> Xenomai libs will not work because of __thread.

There will be a follow-up on this soon, because dlopen causes more
problems, namely to the POSIX skin.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2 ES-OS
Corporate Competence Center Embedded Linux

