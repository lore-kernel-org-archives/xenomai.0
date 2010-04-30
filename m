Message-ID: <4BDAE961.4060203@domain.hid>
Date: Fri, 30 Apr 2010 16:29:53 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4BDADC13.2070500@domain.hid>
In-Reply-To: <4BDADC13.2070500@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi Philippe,
> 
> I'm not 100% sure if this plugs all remaining wholes in the deferred
> host tick processing, but at least the most easiest reproducible one is
> cured now for me (Linux latency peak after termination of 'latency').
> Please let me know if you see more potential issues, otherwise I would
> include this in my for-upstream queue.
> 
> Found while instrumenting the timer core to find RT timer latencies.
> Hope they become visible now...

Note that the behaviour of xnpod_schedule may have changed since the fix
of the XENO_OPT_DEBUG_NUCLEUS issue. Notably, some calls to
xnpod_schedule should now be skipped if nucleus debug is turned off.

Are you running the tests with or without nucleus debug?

-- 
					    Gilles.

