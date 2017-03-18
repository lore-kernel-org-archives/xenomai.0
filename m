References: <1489817372.4278.44.camel@gmx.de>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <d0f21b27-4070-91b3-60ac-b596673ba311@web.de>
Date: Sat, 18 Mar 2017 09:45:25 +0100
MIME-Version: 1.0
In-Reply-To: <1489817372.4278.44.camel@gmx.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] ipipe + PREEMPT_RT
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mike Galbraith <efault@gmx.de>, xenomai@xenomai.org

On 2017-03-18 07:09, Mike Galbraith wrote:
> (oops, sent before subscription confirmation.. wash/rinse/repeat)
> =

> Greetings,
> =

> Seeing PREEMPT_RT in ipipe source, I got curious, extracted 4.4.43, and
> wedged it into 4.4.54-rt, but there are a couple places that replace a
>  spinlock_t (not raw) with an ipipe_spinlock_t, which cause build woes
> for PREEMPT_RT.  I ifdefed those problematic spots back to spinlock_t
> for grins, and surprisingly, my x64_64 desktop box booted, and does a
> decent impersonation of a functional box.. which left me wondering
> whether there's a preparatory patch for PREEMPT_RT somewhere, or
> whether the PREEMPT_RT bits are WIP (or leftovers).

A couple of times, I-pipe with Xenomai has been used in combination with
PREEMPT-RT. That basically created 3 prio groups: regular Linux tasks,
real-time Linux tasks hardened by PREEMPT-RT and above that
I-pipe/Xenomai. However, the integration of both patches was never
really fun.

Some fragments of those efforts you still find in the code, but I think
they haven't been stressed for a while. And, as you noticed, they do not
work as-is. I wouldn't be surprised if your ad-hoc fix does not yet
solve the issue, and a Xenomai use case would break. The semantics of
each real-time patch set is already tricky on its own...

That said, I suppose such integration will return automatically once
PREEMPT-RT makes it upstream.

Was your question just out or curiosity, or is there a potential use case?

Jan

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://xenomai.org/pipermail/xenomai/attachments/20170318/d84d2945/at=
tachment.sig>
