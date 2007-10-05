From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4705FE04.7000909@domain.hid>
References: <4705ED3B.4070600@domain.hid>
	<2ff1a98a0710050130j7e0db84dq838aab0417c8bd3f@domain.hid>
	<4705FE04.7000909@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Date: Fri, 05 Oct 2007 11:20:11 +0200
Message-Id: <1191576011.20623.114.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] awful latencies (~110us)
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: CHABAL David <david.chabal@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2007-10-05 at 11:04 +0200, CHABAL David wrote:
> Gilles Chanteperdrix a =E9crit :
> > On 10/5/07, CHABAL David <david.chabal@domain.hid> wrote:
> >> Hello all,
> >>
> >> My box is a Pentium III 733 Mhz/256Mo with Linux 2.6.20 and Xenomai
> 2.3.3.
> >>
> >> When I run the latency test included in the testsuite, I get some
> >> horrible results like:
> >>

You first need to upgrade your Adeos patch in order to avoid a deadly
tracer issue in earlier versions:
http://download.gna.org/adeos/patches/v2.6/i386/older/adeos-ipipe-2.6.20-i3=
86-1.8-08.patch

Then, please switch on CONFIG_IPIPE_TRACE, CONFIG_IPIPE_TRACE_MCOUNT,
CONFIG_IPIPE_TRACE_IRQSOFF, and eventually run the following on the
target kernel:

# echo 1 > /proc/ipipe/trace/enable
# /usr/xenomai/bin/latency -f
... wait for a high latency ...
# echo 128 > /proc/ipipe/trace/back_trace_points
# cat /proc/ipipe/trace/frozen

Sending us back the output of the last command would help.

--=20
Philippe.



