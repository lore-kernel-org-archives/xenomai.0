Message-ID: <b647ffbd0602090621o4501fb08t@domain.hid>
Date: Thu, 9 Feb 2006 16:21:02 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_15901_26804616.1139494862020"
Subject: [Xenomai-core] Benchmarks
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_15901_26804616.1139494862020
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi there,

after a preliminary discussion with Philipe and, well, a few days later
than I expected, I'm starting a new effort of writting some simple (i.e. no=
t

too complex :) yet, hopefully, useful benchmarking utilites.

The idea of each utility is to emulate a certain use case but
at the level which is significant enough to prove that
the system is (or is not) working properly latency-wise.
This, hopefully, will help to determine some bottlenecks and
the parts of code that need to be reworked/tweaked.
Then we may use such tests on release-by-release basis as indicators
of either progress or regress we are making with a certain release.

As an example, the first utility would implement the following use case :

(based on the latency program)

- a given number of periodic threads are running;

- configurable periods (so that e.g. a few threads can become active
  at the same moment of time). Actually, that's what we would need.

- timer : periodic or apperiodic;

...

the utility will not likely produce any screen-output during its work, but
rather the comprehensive statistic in a handy form after finishing.

---

other utils could make use of some scenarious where synch. primitives/
rt_queue's/pipes could be highly used etc.


I guess, Xenomai already provides a valid amount of functionality and it's
quite stable for the time being. So it's time to work on optimizing it!

Everyone is wellcome to come up with any scenarios on which such utilities
could be based.

Any comments on the one with a given number of threads are wellcome too.


--
Best regards,
Dmitry Adamushko

------=_Part_15901_26804616.1139494862020
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br>
Hi there,<br>
<br>
after a preliminary discussion with Philipe and, well, a few days later<br>
than I expected, I'm starting a new effort of writting some simple (i.e. no=
t <br>
too complex :) yet, hopefully, useful benchmarking utilites.<br>
<br>
The idea of each utility is to emulate a certain use case but<br>
at the level which is significant enough to prove that<br>
the system is (or is not) working properly latency-wise.<br>
This, hopefully, will help to determine some bottlenecks and <br>
the parts of code that need to be reworked/tweaked.<br>
Then we may use such tests on release-by-release basis as indicators<br>
of either progress or regress we are making with a certain release.<br>
<br>
As an example, the first utility would implement the following use case :<b=
r>
<br>
(based on the latency program)<br>
<br>
- a given number of periodic threads are running;<br>
<br>
- configurable periods (so that e.g. a few threads can become active<br>
&nbsp; at the same moment of time). Actually, that's what we would need.<br=
>
<br>
- timer : periodic or apperiodic;<br>
<br>
...<br>
<br>
the utility will not likely produce any screen-output during its work, but<=
br>
rather the comprehensive statistic in a handy form after finishing.<br>
<br>
---<br>
<br>
other utils could make use of some scenarious where synch. primitives/<br>
rt_queue's/pipes could be highly used etc.<br>
<br>
<br>
I guess, Xenomai already provides a valid amount of functionality and it's<=
br>
quite stable for the time being. So it's time to work on optimizing it!<br>
<br>
Everyone is wellcome to come up with any scenarios on which such utilities<=
br>
could be based.<br>
<br>
Any comments on the one with a given number of threads are wellcome too.<br=
>
<br clear=3D"all"><br>-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_15901_26804616.1139494862020--

