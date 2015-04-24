Message-ID: <5539E86A.7000104@web.de>
Date: Fri, 24 Apr 2015 08:53:30 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <1b27d68cb89340489802b18862a2b2d7@zue-s-199.zue.zwick.de>
In-Reply-To: <1b27d68cb89340489802b18862a2b2d7@zue-s-199.zue.zwick.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Corruption after phtread_mutex_destroy
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Meier, Hans" <Hans.Meier@zwick.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Am 2015-04-23 um 20:42 schrieb Meier, Hans:
> Hi everybody,
> =

> First of all thanks a lot for your excellent work, we are using Xenomai =

> for about 8 years now in quite a complex application together with ACE =

> based on the POSIX skin and most of the time it just works fine.
> =

> But now we have a situation we think needs to be reported. =

> =

> Consider the following:
> We have a thread H with high priority, a thread L with low priority and =

> a mutex M (recursive, prio-inherit). L locks M and then H tries to lock M=
, =

> L gets boosted until it unlocks M, then H succeeds in locking M, then H =

> unlocks M. If H then immediately destroys and frees M, we get a corruptio=
n =

> where M's pthread_mutex_t was stored (a byte gets decremented), as soon a=
s =

> L gets scheduled again.
> =

> According to man page PTHREAD_MUTEX_DESTROY(3P), section "Destroying =

> Mutexes" - close to the end - "Implementations are required to allow an =

> object to be destroyed and freed ... immediately after the object is =

> unlocked". So that is what we do here, we destroy and free the mutex =

> immediately after it is unlocked. Certainly in a simple scenario we could =

> easily work around this problem by destroying and freeing M later, but =

> what if this code is buried deep inside a framework lib (here ACE)? =


Not saying that ACE is to be blamed in this case (until the issue is
fully understood), but that layer is in general a rather problematic
piece of code (politely expressed).

In most projects I saw so far, it was of limited or even no real use
anymore. And it caused quite some headache due to lots of bugs,
specifically regarding concurrency, even in its "matured" parts.

So, if possible, get rid of it, at least on the long run.

Jan

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150424/725a3be=
9/attachment.sig>
