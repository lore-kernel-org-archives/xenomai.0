Message-ID: <48BF8B7A.1070507@domain.hid>
Date: Thu, 04 Sep 2008 09:17:14 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48BF8AA6.6090702@domain.hid>
In-Reply-To: <48BF8AA6.6090702@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] First thoughts on fast xnsynch
Reply-To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
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
> Hi Gilles,
> 
> I spent a few brain cycles on the design of a generic fast-lock via
> xnsynch. The first thing was defining the lock word and going through
> its use cases.
> 
> You suggested to realize lock stealing directly in user space, but I
> don't see now how this should work reasonably. Our problem is that we
> would have to atomically check for the woken state AND compare the
> current priority against the owner ones. Imaginable only if we replicate
> the priorities into the lock word - but this makes things at least
> horribly complicated (e.g. when priorities change). So I think we have
> to drop this goal. Or what did you have in mind?

No, you are right, it is a scheduler's decition, so must be done in
kernel-space.

-- 
					    Gilles.

