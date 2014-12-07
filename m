From: "Stoidner, Christoph" <c.stoidner@arvero.de>
Date: Sun, 7 Dec 2014 13:50:02 +0000
Message-ID: <76bf78d4e9644f9394558dc10207fb96@EX132MBOX1A.de2.local>
References: <471986235a5c47e395ece6b3d18830bd@EX132MBOX1A.de2.local>,
 <20141207124041.GS10014@hermes.click-hack.org>
In-Reply-To: <20141207124041.GS10014@hermes.click-hack.org>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Sleeping function called from invalid context
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

=0A=
=0A=
> From what I understand of Xenomai 2.6 code (if this is the version=0A=
> you are using), =0A=
=0A=
Yes, I am using Xenomai 2.6=0A=
=0A=
> normally, the apc should be invoked from the=0A=
> rthal_apc_thread context, not from rthal_apc_handler.=0A=
>=0A=
> The virq handler should be rthal_apc_kicker, which wakes up the=0A=
> process.=0A=
>=0A=
> This code is #ifdef CONFIG_PREEMPT_RT, is not CONFIG_PREEMPT_RT=0A=
> defined in your kernel ?=0A=
=0A=
In my kernel CONFIG_PREEMPT_RT is not defined but CONFIG_PREEMPT_RT_FULL. M=
oreover except in Xenomai code I did not find any CONFIG_PREEMPT_RT in kern=
el code or preempt RT patch-3.10.18-rt14. In older versions of preempt RT (=
e.g. patch-2.6.33.9-rt31) I can found such a define/configuration. It seems=
 as it was removed. =0A=
=0A=
Regards,=0A=
Christoph=

