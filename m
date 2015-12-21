From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <5677E0D4.8000207@xenomai.org>
Date: Mon, 21 Dec 2015 12:21:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Ports to BCM2708, BCM2709
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>


Hi,

There has been a significant traffic on the list about ongoing port(s)
to the Broadcom 2709 processor family, so it seems the right time to
contribute some related code that has been brewing here for a couple of
weeks, targeting the BCM2708 family.

At git://git.xenomai.org/ipipe.git, branch vendors/raspberry/ipipe-4.1,
you will find a preliminary port of the interrupt pipeline to the
Raspberry Pi Zero, based on the RPi reference tree at
https://github.com/raspberrypi/linux (rpi-4.1.y).

This is work in progress, but this kernel already runs most of the basic
Xenomai 3 test programs on real RPi Zero hardware properly. However, the
pipeline does not play well with CONFIG_NO_HZ_IDLE on this kernel yet,
and the autotuner may fail calibrating the core timer although manual
calibration will get you correct latency figures; these issues will soon
be addressed. At this chance, I took a stab at porting the pipeline to
the BCM2709 processor family as well, but the result has not been tested
so far.

Like it happened with several significant Xenomai features in the past,
this effort was funded by Siemens AG. Corporate Competence Center
Embedded Linux. To give credit where credit is due, Jan Kiszka has been
helping in making Xenomai an industrial-grade option for real-time
applications for more than ten years now, so thanks to him, Gernot
Hillier and their teammates at Siemens.

Over the same period, other companies have greatly helped our project by
contributing code and/or funding significant developments as well, and
like Siemens, keep on doing this on a regular basis, among whom the Denx
people led by Wolfgang Denk. All Xenomai users and developers owe all of
them quite a lot in this respect.

Ok, that was my season's greetings, wrapped in software. The leopard
cannot change its spots, I guess.

-- 
Philippe.

