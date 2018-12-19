From: Lange Norbert <norbert.lange@andritz.com>
Subject: Cobalt Preemption of kernel update_fast_timekeeper can cause deadlocks
Date: Wed, 19 Dec 2018 10:20:35 +0000
Message-ID: <f4c18591165c4b919c85ac90a756af9f@andritz.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

There is a deadlock issue that haunted me for several weeks,
it is caused by the kernels update of the user-visible
timekeeping structures used by the VDSO clock_gettime functions.

The kernel regularly updates a Timestamp structure, which is accessible in =
user-mode,
it does so by something akin to a rw-lock in update_fast_timekeeper.

If cobalt preempts the core during holding the lock, any thread trying to r=
ead the time
will continue to spin. (This alone is an issue IMHO).
If the cobalt thread itself now call the vDSO function as reader,
it will spin on the lock and block the lock from getting released.


Either the update_fast_timekeeper funtion should not be preemptible by coba=
lt,
or the spin-lock on reading could fallback to the syscall after a certain a=
mount of retries.

The later is probably easier to implement, but then could randomly demote c=
obalt threads.
(on the other hand, this would be always a demotion on platforms without th=
e vdso function)

Mit besten Gr=FC=DFen / Kind regards

NORBERT LANGE
AT-DES

ANDRITZ HYDRO GmbH
Eibesbrunnergasse 20
1120 Vienna / AUSTRIA
p: +43 50805 56684
norbert.lange@andritz.com
andritz.com
________________________________

This message and any attachments are solely for the use of the intended rec=
ipients. They may contain privileged and/or confidential information or oth=
er information protected from disclosure. If you are not an intended recipi=
ent, you are hereby notified that you received this email in error and that=
 any review, dissemination, distribution or copying of this email and any a=
ttachment is strictly prohibited. If you have received this email in error,=
 please contact the sender and delete the message and any attachment from y=
our system.

ANDRITZ HYDRO GmbH


Rechtsform/ Legal form: Gesellschaft mit beschr=E4nkter Haftung / Corporati=
on

Firmensitz/ Registered seat: Wien

Firmenbuchgericht/ Court of registry: Handelsgericht Wien

Firmenbuchnummer/ Company registration: FN 61833 g

DVR: 0605077

UID-Nr.: ATU14756806


Thank You
________________________________

