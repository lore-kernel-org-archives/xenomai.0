Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2009 18:44:45 -0400
Message-ID: <6DDBE5621293434D9E66429533B6A231043B7714@domain.hid>
References: <4AC2448B.1080500@domain.hid>
From: "Andreas Glatz" <AndreasGlatz@domain.hid>
Subject: Re: [Xenomai-core] RFC: 2.5 todo list.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

Hi,

> full of energy after this tremendous first XUM, I would like to start =
a
> discussion about what people would like to see in the 2.5 branch.

True, it was an great opportunity to see and talk to you guys.


Here is a first list, please feel free to criticize it:
- signals in primary domain (something that we almost forgot)

We don't need that immediately but I think it would be very
handy to have a standard method to register callbacks which are
called once a thread has been signalled and is scheduled.


- xnsynch_acquire using atomic_cmpxchg unconditionally (no #ifdefs)

Atomic operations are always good :)

- statistics of all mapped named heaps in /proc/xenomai/heap

That would be very handy from our point of view.

- unwapped access to user-space posix skin methods

We'r using native skin... so I can't say much about that.

- fast semaphores in user-space
- syscall-less select ?

I think, that'd be great. I think that'd help to decrease
the execution time significantly. I haven't told you yet, but I also
have managed to compile and run our Switch application in kernel
space. That decreased the access time to a shared hardware
resource protected by mutexes and using queues by 20% (avg.
access time was 270us in kernel-space instead of 330us in
user-space according to the histograms I generated).


Best regards,
Andreas

