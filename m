From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1182416810.9709.38.camel@domain.hid>
References: <467639BE.30504@domain.hid>  <467641F3.3010308@domain.hid>
	<1182357772.6137.39.camel@domain.hid>  <46795F21.8040007@domain.hid>
	<1182378551.6079.45.camel@domain.hid>  <467A2FB2.6050006@domain.hid>
	<1182416810.9709.38.camel@domain.hid>
Content-Type: text/plain
Date: Thu, 21 Jun 2007 11:17:09 +0200
Message-Id: <1182417429.9709.41.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH-STACK] Synchronised timebases and more
Reply-To: rpm@xenomai.org
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

On Thu, 2007-06-21 at 11:06 +0200, Philippe Gerum wrote:
> "users" is too vague a term. If we are talking about application
> developers, they should feel deep in their guts that using something
> within the xnarch layer is terminally wrong, so the point is moot
> anyway.
> 
> Who I'm talking about are Xenomai sub-system developers - you, me,
> whoever goes deep into the plumbing for whatever good reason. In that
> case, we do want to have a mean to retrieve the host's idea of time,
> regardless of whether it's reliable in distributed situations or not,
> one has to decide whether it fits or not, and in most cases, it does.
> Sub-systems may have access to the xnarch sub-system legitimately, and
> if we want to hide the underlying environment we are compiling for
> (whether the real hw or the event-driven engine), we need to export a
> common interface with different implementations.
> 

I'd say that xnarch_get_sys_time() tends to become a misnomer with the
current evolution of Xenomai's timekeeping code, xnarch_get_host_time
would be much better.

-- 
Philippe.



