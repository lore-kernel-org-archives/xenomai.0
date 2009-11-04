Message-ID: <4AF1545D.4060207@domain.hid>
Date: Wed, 04 Nov 2009 11:15:57 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <985eb86f0911030429i5c419a6ak8f6e1f2a43250819@domain.hid>
	<985eb86f0911030815t68e7bf14i14ab0d7374c8ce5a@domain.hid>
In-Reply-To: <985eb86f0911030815t68e7bf14i14ab0d7374c8ce5a@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Fwd: How to fix static priority to processes
 known in advance
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: tarek ben ali <tarekbenali@domain.hid>
Cc: xenomai@xenomai.org

tarek ben ali wrote:
> 
> 
> ---------- Forwarded message ----------
> From: *tarek ben ali* <tarekbenali@domain.hid <mailto:tarekbenali@domain.hid>>
> Date: 2009/11/3
> Subject: How to fix static priority to processes known in advance
> To: xenomai@xenomai.org <mailto:xenomai@xenomai.org>
> 
> 
> Hi All,
> I am beginner to Xenomai i have implemented Xenomai 2.4.5 on a 2.6.26
> Kernel.I'm wondering how can I set priority
> to processes known in advance,some ideas or code please.I count on your
> boost.
> regards,
> Tarek

You can not do that, every task has to know its priority, and set it, or
can be created with a specific priority.

-- 
                                          Gilles


