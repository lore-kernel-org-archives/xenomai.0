Date: Wed, 27 Sep 2017 04:06:52 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
Message-ID: <1040395742.20734635.1506503212382.JavaMail.zimbra@wolfram.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] High latency seemingly caused by Peak rtcan driver for
	xenomai-3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello everyone

I have an application that uses rtcan for communicating with the=20
outside world. My problem is that I occasionally have very high=20
latency that I'm trying to debug. After going through the regular
checks with kernel parameters, smi, mallocs, io etc. I have found
that I don't even have to start my application to get the high=20
latency issue. It is enough to simply start the rt-can interface.=20

So here is what I do:=20

1) Fresh reboot, no rt-modules loaded
> latency

Results show about 1.0 us maximum.

2) Insert xeno_can_peak_pci with 2x4 channels
> modprobe xeno_can_peak_pci
> latency

Results show no difference, still low max latency

3) CAN traffic on all 8 channels, open one channel at a time=20
 test latency in between
> rtcanconfig rtcan0 -b 1000000 up
> latency=20

Results show that the maximal latency follows the following formula
maxLatency_uSec =3D (15*(nChannelsCard2 > 0)+15*nChannelsCard1)+
(15*(nChannelsCard2 > 0)+15*nChannelsCard2)

My question is thus, are these latency values normal for this kind of=20
driver or are there things that I can do to remedy the situation?

Regards
Per =C3=96berg=20

