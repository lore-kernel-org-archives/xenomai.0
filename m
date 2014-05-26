From: "Stoidner, Christoph" <c.stoidner@arvero.de>
Date: Mon, 26 May 2014 14:11:30 +0000
Message-ID: <a5ef5b1b612543268a99d3a6f921fd6c@EX132MBOX1B.de2.local>
References: <6b0caf4dfe7d407988717a23fb855097@EX132MBOX1B.de2.local>,
 <53832095.10901@xenomai.org>
In-Reply-To: <53832095.10901@xenomai.org>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Using Preempt RT with I-Pipe/Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Philippe,=0A=
=0A=
thanks for the fast response! =0A=
=0A=
I will try to solve the spinlock conflicts according to your description an=
d post my results here later on.=0A=
=0A=
Regards,=0A=
Christoph=0A=
=0A=
________________________________________=0A=
Von: Philippe Gerum <rpm@xenomai.org>=0A=
Gesendet: Montag, 26. Mai 2014 13:08=0A=
An: Stoidner, Christoph; xenomai@xenomai.org=0A=
Betreff: Re: [Xenomai] Using Preempt RT with I-Pipe/Xenomai=0A=
=0A=
On 05/25/2014 09:59 PM, Stoidner, Christoph wrote:=0A=
> Hi at all,=0A=
>=0A=
> I need some sort of real time behaviour in secondary domain, so I am tryi=
ng to merge Preempt RT patch with I-Pipe/Xenomai. Since Preempt RT as well =
as I-Pipe doing some specific changes to kernel's spinlock handling (mostly=
 in  "include/linux/spinlock.h") this becomes a bit of tricky. The challeng=
e seems to combine Preemp RT's "rt_spin_lock" with I-Pipe's "ipipe_spinlock=
".=0A=
>=0A=
> My first approach was to instrument I-Pipe's "PICK_SPINLOCK" macros with =
Preempt RT's "rt_spin_lock" calls. In detail that means I have added calls =
of rt_spin_lock to all PICK_SPINLOCK macros for each spinlock type  that is=
 not an I-Pipe spinlock. However I am not sure if that is the best solution=
 and if it is correct for all situations.=0A=
>=0A=
> Has someone experiences how to merge these spinlocks or what to consider =
at all when using Preempt RT with I-Pipe/Xenomai?=0A=
>=0A=
=0A=
Fixing up ipipe_lock.h to switch the regular locks (i.e. neither=0A=
ipipe/raw) to the sleeping rt_ spinlock variant is pretty much all you=0A=
should have to do these days.=0A=
=0A=
My last experience merging I-pipe+preempt-rt dates back to kernel 2.6.x,=0A=
so a few more conflicts might have popped up since then though. This=0A=
said, I did not see any showstopper in recent kernels that would prevent=0A=
such combo from working.=0A=
=0A=
e.g.:=0A=
=0A=
+#ifdef PREEMPT_RT=0A=
+ #define __regular_spin_lock_irqsave(lock, flags)              \=0A=
+       do { rt_spin_lock(std_spinlock(lock)); flags =3D 0; } while (0) /* =
can't=0A=
discard flags */=0A=
+#else=0A=
+#define __regular_spin_lock_irqsave(lock, flags)               \=0A=
+       __real_raw_spin_lock_irqsave(&std_spinlock(lock)->rlock, flags)=0A=
+#endif=0A=
=0A=
#define PICK_SPINLOCK_IRQSAVE(lock, flags)                              \=
=0A=
        do {                                                            \=
=0A=
                if (ipipe_spinlock_p(lock))                             \=
=0A=
                        (flags) =3D __ipipe_spin_lock_irqsave(ipipe_spinloc=
k(lock)); \=0A=
                else if (std_spinlock_raw_p(lock))                         =
     \=0A=
                        __real_raw_spin_lock_irqsave(std_spinlock_raw(lock)=
, flags); \=0A=
                else if (std_spinlock_p(lock))                          \=
=0A=
-                       __real_raw_spin_lock_irqsave(&std_spinlock(lock)->r=
lock, flags); \=0A=
+                       __regular_spin_lock_irqsave(lock, flags); \=0A=
                else __bad_lock_type();                                 \=
=0A=
        } while (0)=0A=
=0A=
and so on for all other helpers defining a preempt-rt specific variant.=0A=
=0A=
--=0A=
Philippe.=0A=

