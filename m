Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Aug 2007 16:48:39 +0200
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7A4AB194@domain.hid>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
Subject: Re: [Xenomai-help] (WARNING!!! PGP with incorrect signature) Re:
	Time
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dirk Eibach <eibach@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Jan Kiszka wrote:
>> Dirk Eibach wrote:
>> I'm wondering how long a rt_mutex_acquire is supposed to take on a
PPC405
>> platform. I'm getting times about 50 usec here, which is too much for
my
>> application. Is anything wrong in my kernel/xenomai configuration or
is
>> this time to expected?
[...]
> Still not really short, but it is a full syscall in the end. Anyone
with
> platform experience around to comment on the numbers?

My guess would be that rt_mutex_acquire always takes a syscall,
regardless=20
the state of the mutex. When the most common case is an unlocked mutex,=20
this hurts on low end platforms. Reading the code, it looks like this is

confirmed by src/skins/native/mutex.c, at least in version 2.3.2.

I remember this issue was raised couple of month ago in this thread[1].
Xenomai needs an implementation of fast acquisition path for mutexes,
along the principle of FUTEX but independent[2] from it. Maybe=20
someone is already working it?

[1] https://mail.gna.org/public/xenomai-help/2007-05/msg00105.html
[2] https://mail.gna.org/public/xenomai-help/2007-05/msg00120.html

Regards
--=20
Stephane

