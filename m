MIME-Version: 1.0
Date: Thu, 29 Mar 2012 16:33:26 +0200
Message-ID: <CAFo8bY7d=vsxgBzcD5GmKLvYX-UZqU3Fbfk1mc-3Ces4vLm7yQ@mail.gmail.com>
From: Fabian Scheler <fabian.scheler@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] Help Wanted: Xenomai-based Projects
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

Hello everybody,

at first, I want to introduce myself: My name is Fabian Scheler [1]
and I am a post-doctoral research assistant at the chair in
distributed systems and operating systems [2], my main research
interest are real-time systems and real-time operating systems. In our
research project AORTA [3] we try to analyse and manipulate the
real-time systems architecture (e.g., event-triggered vs.
time-triggered execution, sequential vs. parallel execution, ...) of a
given real-time system. For that purpose, we built an LLVM-based
operating system aware compiler - the RTSC [4] - to e.g. migrate
event-triggered systems to time-triggered systems. Currently, we work
towards the support of multi-core systems, distributed systems and
also replication within the RTSC. So, the RTSC shall be able to map a
given real-time application based on a specific RTOS to such systems.

We now search for {Xenomai,POSIX,...}-based real-time applications
(not necessarily Xenomai, but I think the chance to find an
Xenomai-based application via the Xenomai-list is higher than to find
an eCos-based one) so we can feed them into the RTSC to analyse and
manipulate them. It is important that we search for real applications
(i.e., all the events that have to be handled, the event-handlers, and
ideally their temporal specification need to be available, too),
solely a framework to build some application is not "complete enough"
to feed it into the RTSC. So, if anyone knows about such an
application that is available as source code, I would be very glad if
he or she could tell me about it. If there are people out there, that
are willing to share source code, that is not available publicly,
these people are highly welcome, too - just send me an eMail. Thanks!

Ciao, Fabian

[1] http://www4.informatik.uni-erlangen.de/~scheler
[2] http://www4.informatik.uni-erlangen.de
[3] http://www4.informatik.uni-erlangen.de/Research/AORTA
[4] http://www4.informatik.uni-erlangen.de/Research/RTSC

