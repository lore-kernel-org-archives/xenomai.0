From: "Yogi A. Patel" <yapatel@gatech.edu>
Mime-Version: 1.0 (1.0)
Message-Id: <443DA8ED-FBAA-4DE6-814A-317E04D56407@gatech.edu>
Date: Tue, 26 Aug 2014 23:22:45 -0400
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Overrun error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi -

I have ubuntu 14.04 running kernel 3.8 patched with xenomai 2.6.3.

I have the kernel configured with:

Processor type -> core 2/newer xenon
Preemption model -> low-latency desktop
ACPI -> Processor (disabled)

When I run the latency test, things are great (for hours at a time). Average=
 latencies are 1-1.3us and no overruns.

These latency results remain even when I run my own real time software.=20

However, the moment I open Firefox or chrome, I start seeing overruns.

This is confusing - I would think applications like web browsers would not h=
ave any reason to cause overruns.

It's very likely I don't understand how the overruns occur in such a situati=
on and what causes an overrun.

Has anyone else seen similar issues?

Also, when reading the output of the latency test, why do the overrun values=
 never go back to zero between printouts of the latency test?

Yogi
