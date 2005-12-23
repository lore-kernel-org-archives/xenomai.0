MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17323.59996.206992.318054@domain.hid>
Date: Fri, 23 Dec 2005 13:15:24 +0100
Subject: Re: [Xenomai-core] [RFC] in-kernel timer benchmark
In-Reply-To: <43AAFDA7.7090106@domain.hid>
References: <43A5AE20.804@domain.hid> <17322.62424.94946.83579@domain.hid>
	<43AAFDA7.7090106@domain.hid>
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
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
 > Gilles Chanteperdrix wrote:
 > > (...) But I would vote for a split between the user-space
 > > latency measurement tool and the display tool for kernel-space latency.
 > > 
 > 
 > What's your main concern about the current solution? The need to have
 > RTDM being loaded to start only the userspace test?

I thought the user-space latency was also an example for the native
skin, and had not much in common with the display task for the
kernel-space benchmark. But these benchmarks have in fact much in
common, and the native skin still has the "satch" demo.


 > > It is a very interesting tool indeed (especially since I would need such
 > > a tool to benchmark the various solutions to improve nucleus timers
 > > scalability :). But it would be nice to be able to create several tasks
 > > or several timers without having to open one file descriptor by
 > > timer/task. Or if you want one file descriptor by timer/task,
 > > rt_tmbench_ioctl_nrt should return an error when trying to start the
 > > task or timer twice.
 > > 
 > 
 > Ok, I will try to reworks this, generating a ready-for-merge patch which
 > will also include Philippe's remarks. No promise if this is going to be
 > a pre-Christmas gift. ;)

Do not bother, since I am the one who need it, I may change it. I will
follow-up with a new proposal.

-- 


					    Gilles Chanteperdrix.

