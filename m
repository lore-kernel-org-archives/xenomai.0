From: "Yogi A. Patel" <yapatel@gatech.edu>
Message-Id: <9584EBE8-001C-41E7-88A1-3B4CF07DD567@gatech.edu>
Date: Sun, 6 Jul 2014 21:10:34 -0400
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Content-Type: text/plain;
	charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Analogy Reference Issue with NI PCIMIO
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

I=92ve attempted to debug this issue for the past week but can=92t seem =
to figure out what is going on.

I have an NI-6259 DAQ card and am using Analogy NI_PCIMIO to control the =
DAQ.

When I set a channel=92s reference to =93GROUND=94, the values acquired =
hit the voltage rails (-10V, range is set to +/- 10V).

When I set the reference to =93COMMON=94, I get the signal that I am =
feeding in (sine wave from function generator using BNC) at the right =
frequency and amplitude.=20

When I set the reference to =93DIFFERENTIAL=94, I get a flatline.

I=92ve been looking through both the analogy and comedi code to =
understand what might be going on but no luck.=20

It appears that the reference mode is being set, but I don=92t know =
where else to look for this issue. Has anyone experienced these issues =
before? Any particular place/code I should be debugging?

Yogi

