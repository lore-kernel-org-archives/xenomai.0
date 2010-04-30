Message-ID: <4BDB451E.6010109@domain.hid>
Date: Fri, 30 Apr 2010 23:01:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4BDADC13.2070500@domain.hid>
	<1272658402.24705.108.camel@domain.hid>
In-Reply-To: <1272658402.24705.108.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC] Fix excessive host tick latencies
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> On Fri, 2010-04-30 at 15:33 +0200, Jan Kiszka wrote:
>> Hi Philippe,
>>
>> I'm not 100% sure if this plugs all remaining wholes in the deferred
>> host tick processing, but at least the most easiest reproducible one is
>> cured now for me (Linux latency peak after termination of 'latency').
>> Please let me know if you see more potential issues, otherwise I would
>> include this in my for-upstream queue.
> 
> That patch is correct, please queue it. Anything that breaks the
> assumption described in the following comment from
> xntimer_next_local_shot() is wrong wrt tick deferral: "The host tick
> deferral is cleared whenever Xenomai is about to yield control to the
> host kernel".
> 
> In short, when the code will match the comments and documentation, we
> will be done with debugging.

What I meant is that with the nucleus debugging fixed, we may not even
enter __xnpod_schedule often enough to handle the host tick propagation.
So, maybe we should make xnpod_schedule call __xnpod_schedule if XNHTICK
or XNHDEFER are set.

-- 
					    Gilles.

