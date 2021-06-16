From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
MIME-Version: 1.0
Date: Wed, 16 Jun 2021 09:15:31 +0200
Subject: Large gpio interrupt latency
Message-ID: <10a7-60c9a500-7f-35a6e6c0@10047649>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

working on a realtime data recorder (for which I submitted a patch to a=
dd timestamp retrieval for net packets), I experience a strange latency=
 problem with taking GPIO interrupts.

So basically my app monitors network packets (which as received by the =
DUT would trigger toggling of a GPIO on the DUT) and one GPIO.
We know (from some ohter reference instrument) that the DUT would toggl=
e the GPIO 1-2ms after receiving a specific network packet.

My recorder app relies on the timestamping of events done in interrupts=
 service routines for GPIOs and network interface. By checking the time=
stamps returned by the application, I get an about 50ms delay between t=
he network packet and the GPIO (so something between 51 and 52ms delay)=
.

I wonder where that might be coming from.

Any idea ?

thanks in advance

Fran=C3=A7ois


