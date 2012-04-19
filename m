MIME-Version: 1.0
Date: Thu, 19 Apr 2012 11:21:33 +0530
Message-ID: <CAM1yFZ8K-4fpouG7JKdvjL2ACHUOCoTRSa-wT-diQOU5ejHryw@domain.hid>
From: Anisha Kaul <born.rebel.83@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Real time thread priority in user space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Greetings,

From: http://www.xenomai.org/documentation/xenomai-2.3/pdf/Life-with-Adeos-=
rev-B.pdf

>The above behaviour is to be opposed to what happens with RTAI/LXRT for in=
stance, where threads migrating to the Linux space actually lose their real=
=AD- time priority in the same move, by inheriting the lowest priority defi=
ned by the RTAI scheduler.

I wished to understand what kind of advantages can it offer, and on a
forum I found someone mentioning the following assumptions:
 - Threads don't spend much time in kernel space.
 - Thread in kernel space tend to hold resources that need to be
released as quickly as possible.

This does make sense to me.

But then, from:
http://www.xenomai.org/documentation/xenomai-2.3/pdf/Life-with-Adeos-rev-B.=
pdf

> Xenomai threads are not only able to run over the context of the highest =
priority domain in the pipeline (i.e. the primary domain) like kernel=ADbas=
ed Xenomai threads, but also in the regular Linux space (i.e. the secondary=
 domain), while still being considered as real=ADtime by Xenomai, albeit su=
ffering higher scheduling latencies.

Considering "Threads in kernel space tend to hold resources that need
to be released as quickly as possible." what can be the reasons behind
the design decision of letting the threads maintain their priority in
user space in Xenomai?

What kind of advantages does this behavior offer w.r.t hard real time?

Please guide.
-Anisha

