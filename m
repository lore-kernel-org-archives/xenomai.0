MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17638.4287.277994.908118@domain.hid>
Date: Fri, 18 Aug 2006 21:10:55 +0200
Subject: Re: [Xenomai-core] Re: Test, benchmark
In-Reply-To: <44E60313.8000803@domain.hid>
References: <44DA896F.9060102@domain.hid> <44DB1865.90004@domain.hid>
	<44DB9958.10109@domain.hid> <44DCAF88.2060801@domain.hid>
	<44E5F0B4.8070405@domain.hid>
	<17637.63157.596008.331241@domain.hid>
	<44E60313.8000803@domain.hid>
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
To: Jim Cromie <jim.cromie@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Jim Cromie wrote:
 > Offhand, that seems counterintuitive that -n gives lower growth-rate of 
 > total switches,
 > since its equivalent to a shorter list of 'threadspec's

In addition to the threads specified by the 'threadspec's list,
switchtest create a thread (named sleeper) that sleep 10 ms every time
some other thread switches to it. If there are more threads, this
sleeper thread is less likely to run, so there are more context
switches per second.

 > 
 > 
 > Also, 2 possible output change requests:
 > 
 > a - print per-sample measures, not accumulating ones.
 >     this is more consistent with latency, which prints the latencies
 >     seen over the 1-sec sample period
 >     This also feeds better into histogram, w/o adding 'delta' logic to 
 > histogrammer
 > 
 > b - label output lines more in spirit of latency

Ok, I will change the output.

-- 


					    Gilles Chanteperdrix.

