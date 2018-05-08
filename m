From: Giulio Moro <g.moro@qmul.ac.uk>
Date: Tue, 8 May 2018 10:28:06 +0000
Message-ID: <VI1PR0701MB21261A3412C5D4176A5834AEB59A0@VI1PR0701MB2126.eurprd07.prod.outlook.com>
References: <1690521400.5815208.1525773838317.JavaMail.zimbra@triolcorp.com.ua>
In-Reply-To: <1690521400.5815208.1525773838317.JavaMail.zimbra@triolcorp.com.ua>
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1251"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] porting Linux POSIX app to Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?windows-1251?B?2OXi9+Xt6u4g0uDw4PEgw/Do4+7w/OXi6Pc=?= <shevchenko.taras@triolcorp.com.ua>, xenomai <xenomai@xenomai.org>
Cc: Olej <o.tsiliuric@yandex.ru>

> 1) is it true the same POSIX-code will generate Xenomai rt-task with opti=
ons below

Yes. Make sure you set the scheduler policy to SCHED_FIFO (or SCHED_RR) (e.=
g.: with pthread_attr_setschedpolicy())

> Does it mean: all of this (man -s2) POSIX-functions safely use from real-=
time points of view ?

Xenomai's libcobalt implements the POSIX functions documented here:
http://www.xenomai.org/documentation/xenomai-3/html/xeno3prm/group__cobalt_=
_api.html
Check the documentation to see which can be safely used from a real-time co=
ntext.

> 3) Xenomai task that not doing system call (calculation task , for exampl=
e), not be interrupted by Linux ?

Correct, as long as it stays in primary mode (i.e.: does not do system call=
s to Linux), your task will run at a higher priority than Linux and therefo=
re (assuming SCHED_FIFO), the scheduler will only interrupt it if there is =
another (Xenomai!) thread at higher priority that is ready to run.

> 4)  strcpy(), strcmp(), sprintf(), atoi(), sqrt(), sin() etc) can be safe=
ly use from real-time points of view ?

Yes, as long as a function does not require a system call to Linux, it is s=
afe to use it in your real-time thread.

________________________________________
From: Xenomai <xenomai-bounces@xenomai.org> on behalf of =D8=E5=E2=F7=E5=ED=
=EA=EE =D2=E0=F0=E0=F1 =C3=F0=E8=E3=EE=F0=FC=E5=E2=E8=F7 <shevchenko.taras@=
triolcorp.com.ua>
Sent: 08 May 2018 11:03
To: xenomai
Cc: Olej
Subject: [Xenomai] porting Linux POSIX app to Xenomai

Good day!
I ve read https://xenomai.org//2014/08/porting-a-linux-application-to-xenom=
ai-dual-kernel/
but some details are still on
Please tell me some nuances

1) is it true the same POSIX-code will generate Xenomai rt-task with option=
s below
CFLAGS :=3D $(shell $(XENO_CONFIG) =97skin=3Dposix =97cflags)
LDFLAGS :=3D $(shell $(XENO_CONFIG) =97skin=3Dposix =97ldflags)
and default Linux -task without options ?


3) Xenomai task that not doing system call (calculation task , for example)=
, not be interrupted by Linux ?

4) No imlementing system call POSIX library functions (man s3 section strcp=
y(), strcmp(), sprintf(), atoi(), sqrt(), sin() etc) can be safely use from=
 real-time points of view ?



_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
https://xenomai.org/mailman/listinfo/xenomai

