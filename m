From: "Stoidner, Christoph" <c.stoidner@arvero.de>
Date: Sun, 25 May 2014 19:59:19 +0000
Message-ID: <6b0caf4dfe7d407988717a23fb855097@EX132MBOX1B.de2.local>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] Using Preempt RT with I-Pipe/Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi at all,=0A=
=0A=
I need some sort of real time behaviour in secondary domain, so I am trying=
 to merge Preempt RT patch with I-Pipe/Xenomai. Since Preempt RT as well as=
 I-Pipe doing some specific changes to kernel's spinlock handling (mostly i=
n  "include/linux/spinlock.h") this becomes a bit of tricky. The challenge =
seems to combine Preemp RT's "rt_spin_lock" with I-Pipe's "ipipe_spinlock".=
  =0A=
=0A=
My first approach was to instrument I-Pipe's "PICK_SPINLOCK" macros with Pr=
eempt RT's "rt_spin_lock" calls. In detail that means I have added calls of=
 rt_spin_lock to all PICK_SPINLOCK macros for each spinlock type  that is n=
ot an I-Pipe spinlock. However I am not sure if that is the best solution a=
nd if it is correct for all situations. =0A=
=0A=
Has someone experiences how to merge these spinlocks or what to consider at=
 all when using Preempt RT with I-Pipe/Xenomai?=0A=
=0A=
I am grateful for each hint according to that theme.=0A=
=0A=
For Information: Currently I am working with kernel Kernel 3.10.18 and Xeno=
mai 2.6.3=0A=
=0A=
Thanks and regards,=0A=
Christoph=0A=

