From: Sebastian Smolorz <ssm@domain.hid>
Date: Fri, 20 Jul 2007 15:02:45 +0200
References: <E1IBrs1-00081N-8b@domain.hid>
	<2ff1a98a0707200558u1e118274nf74c77c528dc9d48@domain.hid>
In-Reply-To: <2ff1a98a0707200558u1e118274nf74c77c528dc9d48@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1IBs85-0000h5-DQ@mailer.emlix.com>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> On 7/20/07, Sebastian Smolorz <ssm@domain.hid> wrote:
> > Hi,
> >
> > here comes my patch for user space tsc emulation for decrementing
> > counters. I had to extend the __xn_tscinfo structure because the counter
> > value from the last tsc update is needed to calculate the new tsc value.
>
> The struct __xn_tscinfo is a union where "fr" stands for free-running,
> the idea was that you could add your own structure for decrementer
> based tsc.

Ah, ok, will change the patch. The abbreviation was not immediately clear to 
me. ;-)

-- 
Sebastian

