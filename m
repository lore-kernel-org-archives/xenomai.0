MIME-Version: 1.0
Sender: edouard.tisserant@domain.hid
Date: Wed, 7 Oct 2009 18:42:42 +0200
Message-ID: <abbab2d60910070942l2bfbc0bboca0232fb674e1ec0@domain.hid>
From: Edouard TISSERANT <edouard.tisserant@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] XUM 2009 follow-up : Powerlink, CANopen and sockets.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Dear hackers,

I've been passing last month seeking for the best way to implement
Powerlink with Xenomai. I still didn't find the absolute truth, and
would like to confront my point of view.

In short, Powerlink is a kind of CANopen over polled ethernet.
Powerlink re-use a subset of CANopen concepts for high level
communications, whereas on the low level, a single master cyclically
poll each node for data. As you can imagine, communication cycle is
seriously influenced by each controlled node latency answering poll
requests from master.

My intention is to write an efficient Powerlink implementation for
Xenomai, but suitable for later reuse in future Real Time Linux
implementation such as RT-PREEMPT. Discussing with RT-PREEMT gurus, I
understood that re-using native Linux queues could never be a
solution, as those queues induce way too long and unpredictable
latencies for such real-time ethernet (those latencies also apply for
SocketCan). Some software hook at ethernet driver level will be
necessary to reroute RT-related packets directly to the concerned RT
stack. With this approach, the whole stack would have to stay kernel
side to reduce latency in answering poll requests. Implementing the
whole CANopen stack kernel side is generally a bad idea, as it
complicate access to object dictionary from application, usually in
user space.

RTnet proves that Real-Time ethernet can be implemented through the
socket paradigm. I believe that Time Division Medium Access (TDMA) of
RTnet could be interchanged with polled ethernet medium access
discipline from Powerlink. Thus, CANopen implementation part could
stay user side, and could pre-fill answers to poll requests, avoiding
long latencies. But what is the future of RTnet ? Will it be ported to
RT-PREEMPT or will it enter official Xenomai tree ? Will available
RTnet's drivers set continue to grow ? Would it be theoretically
possible for RTnet to support Linux ethernet drivers through a hook
mechanism as mentioned in previous paragraph ?

My feeling is that, yes, we should try to fit implementation of
Powerlink data link layer inside RTnet as another MAC discipline, and
use a modified version of CanFestival for CANopen aspects, keeping it
a user space library. Please comment.

Best regards,

Edouard

--=20
LOLITech
24, rue Pierre Evrat
88100 Saint-Di=E9 des Vosges
tel: +33 3 29 57 60 42
mob: +33 6 10 49 76 41
edouard.tisserant@domain.hid
http://www.lolitech.fr

