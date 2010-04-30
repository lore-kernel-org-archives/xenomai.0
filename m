Message-ID: <4BDAEA6F.4070705@domain.hid>
Date: Fri, 30 Apr 2010 16:34:23 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4BDADC13.2070500@domain.hid> <4BDAE961.4060203@domain.hid>
In-Reply-To: <4BDAE961.4060203@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Hi Philippe,
>>
>> I'm not 100% sure if this plugs all remaining wholes in the deferred
>> host tick processing, but at least the most easiest reproducible one is
>> cured now for me (Linux latency peak after termination of 'latency').
>> Please let me know if you see more potential issues, otherwise I would
>> include this in my for-upstream queue.
>>
>> Found while instrumenting the timer core to find RT timer latencies.
>> Hope they become visible now...
> 
> Note that the behaviour of xnpod_schedule may have changed since the fix
> of the XENO_OPT_DEBUG_NUCLEUS issue. Notably, some calls to
> xnpod_schedule should now be skipped if nucleus debug is turned off.
> 
> Are you running the tests with or without nucleus debug?
> 

Without CONFIG_XENO_OPT_DEBUG_NUCLEUS and with the debug fix applied.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

