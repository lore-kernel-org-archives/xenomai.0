Message-ID: <48F35A40.9040306@domain.hid>
Date: Mon, 13 Oct 2008 16:25:04 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48F33543.6070303@domain.hid>
	<48F3380B.6040503@domain.hid>	<48F33AEC.9080608@domain.hid>
	<48F33C4F.4020001@domain.hid>
In-Reply-To: <48F33C4F.4020001@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Fast mutexes vs. automatic mode switch
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
>> As we are already fighting hard to avoid new explicit mode-switch use
>> cases, rather get rid of old ones, I thought it would be better to keep
>> existing semantic across the fast mutex changes.
>>
>> Regarding those shared maps: they are per process, aren't they? But here
>> we need per thread memory. I'm currently thinking of a memory piece that
>> the caller of xeno_set_current provides (or some service that is called
>> together with the latter one, or some extended services - to keep APIs
>> clean). Then, on mode switches, the kernel will carefully
>> (xn_copy_to_user) update it.
> 
> We can allocate a piece of memory on the shared heap, and attach it to a
> thread using a pthread_key.

What would be the advantage of using a heap chunk over doing xn_copy_*?
I haven't looked into details yet but, in contrast to the mutex stuff, I
don't expect that we will have to access that data from within critical
regions.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

