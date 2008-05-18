MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18480.30551.499645.920690@domain.hid>
Date: Sun, 18 May 2008 20:37:11 +0200
In-Reply-To: <48305BE4.3040503@domain.hid>
References: <18459.38249.462320.715909@domain.hid>
	<18459.38430.835407.942336@domain.hid>
	<18459.38500.720338.652195@domain.hid>
	<18459.38558.684426.240775@domain.hid>
	<18459.38644.699369.801548@domain.hid>
	<18459.38704.252719.734650@domain.hid>
	<48305BE4.3040503@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [Patch 5/7] Define new syscalls for the system
 skin
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
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
 > Gilles Chanteperdrix wrote:
 > > The two syscalls defined in the posix skin now moved to the sys skin, they are
 > > used in user-space by include/asm-generic/bits/bind.h and the new header
 > > include/asm-generic/bits/current.h. The global and process-specific shared heaps
 > > are now part of this patch.
 > >
 > 
 > Is there any reason why the nucleus should not implement a full-fledged "RT
 > futex" support, instead of a toolbox to build them? I'm concerned by skins
 > reinventing their own wheel uselessly to get to the same point at the end of the
 > day; e.g. cb_lock ops seem to me fairly generic when it comes to handling
 > futexes, so I would move them upstream one level more.
 > 
 > In that respect, talking about "semaphore heaps" at nucleus level looks a bit of
 > a misnomer: if we mostly bring a service to map non-cacheable memory to
 > user-space, then we don't actually provide semaphore support.

If I understand correctly, a futex is, in xenomai terms, a way to
associate a user-space address, with an xnsynch object. I feel this
would complicate things: currently, the way I implemented user-space
mutexes for the posix skin kept the old association between the
user-space mutex, and its kernel-space companion, also used by
kernel-space operations.

-- 


					    Gilles.

