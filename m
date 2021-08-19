From: Lange Norbert <norbert.lange@andritz.com>
Subject: cobalt_assert_nrt should use __cobalt_pthread_kill
Date: Thu, 19 Aug 2021 09:56:46 +0000
Message-ID: <DB9PR05MB77239BFB7BA2E64E825FF123F6C09@DB9PR05MB7723.eurprd05.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

Hello,

I have some small slight issue with the cobalt_assert_nrt function,
incase a violation is detected the thread should get a signal,
but the implementation will implicitly get a signal during the execution of=
 pthread_kill, see:


#0  getpid () at ../sysdeps/unix/syscall-template.S:60
#1  0x00007fc1dc4fa0d6 in __pthread_kill (threadid=3D<optimized out>, signo=
=3D24) at ../sysdeps/unix/sysv/linux/pthread_kill.c:53
#2  0x00007fc1dc8b2470 in callAssertFunction () at /home/lano/git/preload_c=
heckers/src/pchecker.h:199
#3  malloc () at /home/lano/git/preload_checkers/src/pchecker_heap_glibc.c:=
220
#4 <actual instrumented function>

You see, the signal should happen with the pc of #2, not from the implement=
ation of glibc (or whatever c library).
So the function should be changed to:

void cobalt_assert_nrt(void)
{
            if (cobalt_should_warn())
                        __cobalt_pthread_kill(pthread_self(), SIGDEBUG);
}

(or even replaced with the raw syscall ?)

Regards,
Norbert
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


Rechtsform/ Legal form: Gesellschaft mit beschr?nkter Haftung / Corporation

Firmensitz/ Registered seat: Wien

Firmenbuchgericht/ Court of registry: Handelsgericht Wien

Firmenbuchnummer/ Company registration: FN 61833 g

DVR: 0605077

UID-Nr.: ATU14756806


Thank You
________________________________
