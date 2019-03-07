From: Lange Norbert <norbert.lange@andritz.com>
Subject: smokey's fork tests hangs?
Date: Thu, 7 Mar 2019 14:55:41 +0000
Message-ID: <930188d381964d3794e4204d7ef2a477@andritz.com>
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

Hello,

I have problems with the fork tests, they both hang for me.

# xeno smokey --run=3D11 --verbose=3D2
<hangs>

# xeno smokey --run=3D20 --verbose=3D2
no leak withthread
no leak withmutex
no leak withcond
no leak withsem
no leak withnamed sem
no leak withtimer
no leak withmq
<hangs>

When started under gdb, the parent is running into waitpid,
The child is stuck at an innocent locking snippet [1].

#0  __lll_lock_wait_private ()
    at ../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:63
#1  0x00007ffff7ed74de in __GI___register_atfork (
    prepare=3D0x7ffff7f5edc0 <atfork_lock>, prepare@entry=3D0x0,
    parent=3Dparent@entry=3D0x0,
    child=3Dchild@entry=3D0x7ffff7f9f4e0 <cobalt_fork_handler>,
    dso_handle=3D0x7ffff7de0e5b <__lll_lock_wait_private+27>)
    at register-atfork.c:40
#2  0x00007ffff7faca9d in __pthread_atfork (prepare=3Dprepare@entry=3D0x0,
    parent=3Dparent@entry=3D0x0,
    child=3Dchild@entry=3D0x7ffff7f9f4e0 <cobalt_fork_handler>)
    at pthread_atfork.c:51
#3  0x00007ffff7f9f307 in __cobalt_init ()
    at /home/lano/buildroot/build/xenomai/lib/cobalt/init.c:212
#4  cobalt_init () at /home/lano/buildroot/build/xenomai/lib/cobalt/init.c:=
252
#5  0x00007ffff7f9f4fc in cobalt_fork_handler ()
    at /home/lano/buildroot/build/xenomai/lib/cobalt/init.c:192
#6  0x00007ffff7ed7898 in __run_fork_handlers (who=3Dwho@entry=3Datfork_run=
_child)
    at register-atfork.c:134
#7  0x00007ffff7e9b04a in __libc_fork () at ../sysdeps/nptl/fork.c:137
#8  0x0000000000408d0b in ?? ()
#9  0x00000000004051d1 in main ()

[1] - https://sourceware.org/git/?p=3Dglibc.git;a=3Dblob;f=3Dsysdeps/unix/s=
ysv/linux/x86_64/lowlevellock.S;h=3D71dd740202b1d6501a2ffd929aa99cbd99a019e=
f;hb=3D1e5c5303a522764d7e9d2302a60e4a32cdb902f1


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

