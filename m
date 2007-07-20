Message-ID: <2ff1a98a0707200558u1e118274nf74c77c528dc9d48@domain.hid>
Date: Fri, 20 Jul 2007 14:58:03 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <E1IBrs1-00081N-8b@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <E1IBrs1-00081N-8b@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] [arm] support for user space tsc
	emulation for decrementing counters
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Sebastian Smolorz <ssm@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On 7/20/07, Sebastian Smolorz <ssm@domain.hid> wrote:
> Hi,
>
> here comes my patch for user space tsc emulation for decrementing counters. I
> had to extend the __xn_tscinfo structure because the counter value from the
> last tsc update is needed to calculate the new tsc value.

The struct __xn_tscinfo is a union where "fr" stands for free-running,
the idea was that you could add your own structure for decrementer
based tsc.

-- 
                                               Gilles Chanteperdrix

