From: Michael Haberler <mail17@mah.priv.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Jan 2013 09:29:37 +0100
Message-Id: <D9F55F45-EC38-45B2-A922-08F24868BA87@mah.priv.at>
Mime-Version: 1.0 (Apple Message framework v1283)
Subject: [Xenomai] universal application binary: how to auto-detect
	Xenomai/RT-PREEMPT/vanilla kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

thanks to patience on this list we were able to build linuxcnc such that =
it runs on Xenomai, besides RT-PREEMPT, vanilla kernels (in a =
simulator/non-RT mode) and RTAI


I'm planning to adapt linuxcnc such that a universal binary can be built =
which runs under Xenomai, RT-PREEMPT and vanilla kernels as this will =
simplify logistics quite a bit; what I'd like have is reliable =
auto-detection of the kernel type and 'do the right thing' (RTAI will =
remain a separate build).

Autodetection could be one of several things - digging around with a =
shell script, using system calls, digging in /proc - unsure how to best =
do this, in particular I'm unsure how to tell an RT-PREEMPT kernel from =
a vanilla kernel=20

I know it's a bit OT - still I'd be thankful for suggestions

any other low-lying cliffs I might hit?

- Michael



