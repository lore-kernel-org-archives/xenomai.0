From: =?iso-8859-1?Q?C=E9dric_Perles?= <cperles@sepro-group.com>
Date: Wed, 15 Nov 2017 15:18:34 +0100 (CET)
Message-ID: <00aa01d35e1c$9f697460$de3c5d20$@sepro-group.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] kernel does not boot when ipipe tracer is activated
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I=92m working on an iMX6 based board with NXP kernel 4.1.15.
Using cyclictest and dohell, I benched latency on my Xenomai + Preempt-rt
kernel. To understand the results, I wanted to activate ftrace and
ipipe-tracer.

While ftrace activation was not a big deal, when "I-pipe debugging" is
activated into menuconfig my kernel does not boot anymore and hangs to
"Starting kernel ..."

Did someone faced the same issue ?
Is there a way to investigate

Regards,

C=E9dric.

