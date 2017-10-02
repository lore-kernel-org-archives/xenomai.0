From: Giulio Moro <g.moro@qmul.ac.uk>
Date: Mon, 2 Oct 2017 14:08:54 +0000
Message-ID: <DB6PR0701MB24567885F171F1129C2FCE61B57D0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] The task calling pthread_cond_signal() has to own the lock
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I am using condition variables with the Posix skin on Xenomai 3.0.5
I find that if the thread calling pthread_cond_signal() has not acquired th=
e lock associated with the condition variable, the waiting thread is not re=
sumed. Is this expected behaviour? As
According to the Posix specifications (referenced by the Xenomai docs):
"The pthread_cond_broadcast() or pthread_cond_signal() functions may be cal=
led by a thread whether or not it currently owns the mutex that threads cal=
ling pthread_cond_wait() or pthread_cond_timedwait() "
therefore, I think that what I observe is unexpected behaviour.
Note: I am happy for my use case to accept the non-deterministic behaviour =
caused by the signalling thread not acquiring the lock.

My test code is here: https://pastebin.com/raw/zjmQBFxr

If I #define SIGNALLER_ACQUIRES_LOCK, then main() acquires mutex before cal=
ling pthread_cond_signal() and the waiting thread is successfully resumed.
The program therefore prints:
main(): Signalling condition
callback(): start
callback(): Locking mutex
callback(): Waiting on condition
main(): Signalling condition
callback(): Unlocking mutex
callback(): Locking mutex
callback(): Waiting on condition
....

However, if I do not define the macro, then the waiting thread is never res=
umed, here is the printout:
main(): Signalling condition
callback(): start
callback(): Locking mutex
callback(): Waiting on condition
main(): Signalling condition
main(): Signalling condition
main(): Signalling condition
main(): Signalling condition
main(): Signalling condition
....

I am compiling with:
clang test-xeno-cond.c `/usr/xenomai/bin/xeno-config --skin=3Dposix --cflag=
s --ldflags` -o cond

and `/usr/xenomai/bin/xeno-config --skin=3Dposix --cflags --ldflags` return=
s:
-I/usr/xenomai/include/cobalt -I/usr/xenomai/include -march=3Darmv7-a -mfpu=
=3Dvfp3 -D_GNU_SOURCE -D_REENTRANT -D__COBALT__ -D__COBALT_WRAP__
-Wl,--no-as-needed -Wl,@/usr/xenomai/lib/cobalt.wrappers -Wl,@/usr/xenomai/=
lib/modechk.wrappers  /usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=3Dmai=
n -Wl,--dynamic-list=3D/usr/xenomai/lib/dynlist.ld -L/usr/xenomai/lib -lcob=
alt -lmodechk -lpthread -lrt

