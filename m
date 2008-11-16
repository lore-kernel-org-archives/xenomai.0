Message-ID: <49200E67.3000000@domain.hid>
Date: Sun, 16 Nov 2008 13:13:27 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1L1XPO-0006Xh-1s@domain.hid> <491FF78D.9000609@domain.hid>
In-Reply-To: <491FF78D.9000609@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-commits] r4392 -
	/trunk/include/asm-x86/arith_64.h
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
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Author: gch
>> Date: Sun Nov 16 03:30:40 2008
>> New Revision: 4392
>>
>> URL: http://svn.gna.org/viewcvs/xenomai?rev=4392&view=rev
>> Log:
>> Implement nodiv_ullimd on x86_64
>>
>> Modified:
>>     trunk/include/asm-x86/arith_64.h
> 
> Nice. This solves the user-triggerable kernel oops due to idiv overflows
> in the original version (rt_task_sleep_until(1LL<<63);). I happened to
> receive such a bug report on Friday and was about to consider
> alternative solutions beyond limit checks.
> 
> But how accurate is this conversion? I mean how many bits can we lose
> when doing xnarch_ns_to_tsc(xnarch_tsc_to_ns(x))?

Thanks to a little addition, nodiv_ullimd has the same precision as ullimd.

> 
> Final question: Already prepared a 32-bit version? :)

Yes, the generic vercion should work, provided we implement
__rthal_add96and64
which does an addl and two adcl
-- 
					    Gilles.

