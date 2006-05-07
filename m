MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17502.32006.418774.459215@domain.hid>
Date: Mon, 8 May 2006 01:04:38 +0200
Subject: Re: [Xenomai-core] [RFC][patch] per-process data.
In-Reply-To: <445E637A.5080706@domain.hid>
References: <17502.13773.674199.219762@domain.hid>
	<445E637A.5080706@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
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
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
 > Likely I did not yet get the full picture: What prevents using another
 > adeos per-task key for this? 

We would need a per-task key for every skin that needs a per-process
data, but more importantly, we would need to track the clone syscalls
(that would be another adeos event) in order to propagate the per-task
data to each thread of the process. Or maybe ptds are inherited upon
clone ?

And why is it required to establish a new
 > termination hook? Are there scenarios where the existing
 > task-termination hook is not suited for the planned cleanup work?

Because the existing hook is called once for every thread exit, whereas
the pexit event get triggered when the last thread of a process exits,
this is the only moment we are sure we can destroy per-process data.

Using the existing hook, we would need to decrement a reference counter
in the hook, but then we would (again) need to track the clone syscalls
in order to increment the reference counter.

Both implementations require to add an adeos event, the one I chose, if
it works, avoid reference counting.

-- 


					    Gilles Chanteperdrix.

