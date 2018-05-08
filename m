Date: Tue, 8 May 2018 13:03:58 +0300 (EEST)
From: =?windows-1251?B?2OXi9+Xt6u4g0uDw4PEgw/Do4+7w/OXi6Pc=?=
 <shevchenko.taras@triolcorp.com.ua>
Message-ID: <1690521400.5815208.1525773838317.JavaMail.zimbra@triolcorp.com.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] porting Linux POSIX app to Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>
Cc: Olej <o.tsiliuric@yandex.ru>

Good day!=20
I ve read https://xenomai.org//2014/08/porting-a-linux-application-to-xenom=
ai-dual-kernel/=20
but some details are still on=20
Please tell me some nuances=20

1) is it true the same POSIX-code will generate Xenomai rt-task with option=
s below=20
CFLAGS :=3D $(shell $(XENO_CONFIG) =97skin=3Dposix =97cflags)=20
LDFLAGS :=3D $(shell $(XENO_CONFIG) =97skin=3Dposix =97ldflags)=20
and default Linux -task without options ?=20

2) Xenomai create wrappers (include/cobalt/wrappers.h) for some system call=
 Linux/POSIX:=20
Does it mean: all of this (man -s2) POSIX-functions safely use from real-ti=
me points of view ?=20

3) Xenomai task that not doing system call (calculation task , for example)=
, not be interrupted by Linux ?=20

4) No imlementing system call POSIX library functions (man s3 section strcp=
y(), strcmp(), sprintf(), atoi(), sqrt(), sin() etc) can be safely use from=
 real-time points of view ?=20



