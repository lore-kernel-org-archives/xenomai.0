Message-ID: <4C98C4DF.6070904@domain.hid>
Date: Tue, 21 Sep 2010 16:44:47 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTikF63jMSnD-XDq_KvApr1EZoGPLP6rFG7HcwpPC@mail.gmail.com>
	<AANLkTinhmyo1AFvPzHXZ12ochSOpMHLj9qwEfQ8GCc5L@mail.gmail.com>
In-Reply-To: <AANLkTinhmyo1AFvPzHXZ12ochSOpMHLj9qwEfQ8GCc5L@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Fwd: isolate realtime and Linux by CPU on SMP
 system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Weber <jwamsc@domain.hid>
Cc: xenomai@xenomai.org

Jeff Weber wrote:
> What is the best method for segregating Xenomai and Linux by CPU?  I was
> unable to do this cleanly using /proc/xenomai/affinity for Xenomai,
> together with the Linux isolcpus boot option.  Details below.

I have no definite answer, I have not checked. What I suspect, however,
is that when you try and force an affinity for a Xenomai thread, it
tries and apply this affinity in secondary mode, i.e. as a plain Linux
thread. So, will fail if the target thread is not in the "isolcpus"
mask. In other words, a Xenomai thread can not run on a CPU where Linux
threads can not run.

-- 
					    Gilles.

