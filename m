From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17608.46241.732781.448429@domain.hid>
Date: Thu, 27 Jul 2006 14:42:09 +0200
Subject: Re: [Xenomai-core] Timer optimisations, continued
In-Reply-To: <1153990428.5251.46.camel@domain.hid>
References: <448E98A3.6080707@domain.hid> <448E9E8B.70809@domain.hid>
	<448EA7F7.5000802@domain.hid> <448EB038.8070802@domain.hid>
	<448EE593.7010809@domain.hid> <448EF022.1040901@domain.hid>
	<17550.61982.685449.470866@domain.hid>
	<44C6626A.6000304@domain.hid> <1153990428.5251.46.camel@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
 > >  o A further improvement should be achievable for scenarios 4 and 5 by
 > >    introducing absolute xntimers (more precisely: a flag to
 > >    differentiate between the mode on xntimer_start). I have an outdated
 > >    patch for this in my repos, needs re-basing.
 > > 
 > 
 > Grmblm... Well, I would have preferred that we don't add that kind of
 > complexity to the nucleus interface, but I must admit that some
 > important use cases are definitely better served by absolute timespecs,
 > so I would surrender to this requirement, provided the implementation is
 > confined to xnpod_suspend_thread() + xntimer_start().

It would be nice if absolute timeouts were also available when using
xnsynch_sleep_on. There are a few use cases in the POSIX skin.

-- 


					    Gilles Chanteperdrix.

