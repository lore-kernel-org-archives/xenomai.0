MIME-Version: 1.0
From: Jean-Michel Hautbois <jhautbois@domain.hid>
Date: Fri, 23 Sep 2011 09:58:32 +0200
Message-ID: <CAL8zT=g-Mo1VDk2X9zE1d=j-k2wVRFVeNVHEuX50p7Bee5rKaQ@mail.gmail.com>
Content-Type: multipart/alternative; boundary=20cf30025e5a1bdb9804ad972e05
Subject: [Xenomai-core] P2020 support for ftrace with ipipe 2.12-01 and xeno
	2.5.5.1
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

--20cf30025e5a1bdb9804ad972e05
Content-Type: text/plain; charset=UTF-8

Hi List,

I am trying to use ftrace on a P2020 board, using the following :
- Linux 2.6.35-11
- Xenomai 2.5.5.1 (or 2.5.6, same problem)
- ipipe 2.12-01

I launch it using :
$> mkdir /tmp/debug
$> mount -t debugfs nodev /tmp/debug
$> cd /tmp/debug/tracing
$> echo function_graph > current_tracer

The last one fails (it hangs the CPU, I cannot do anything than hard reset).
Do you know what could cause that ?
As I can't have any trace, I don't really know how to go further, and before
using a BDI I would like to know if it is a known issue, as I could not find
anything related to this in the recent changes...

Thanks in advance for your help,
Regards,
JM

--20cf30025e5a1bdb9804ad972e05
Content-Type: text/html; charset=UTF-8

Hi List,<br><br>I am trying to use ftrace on a P2020 board, using the following :<br>- Linux 2.6.35-11<br>- Xenomai 2.5.5.1 (or 2.5.6, same problem)<br>- ipipe 2.12-01<br><br>I launch it using :<br>$&gt; mkdir /tmp/debug<br>

$&gt; mount -t debugfs nodev /tmp/debug<br>$&gt; cd /tmp/debug/tracing<br>$&gt; echo function_graph &gt; current_tracer <br><br>The last one fails (it hangs the CPU, I cannot do anything than hard reset).<br>Do you know what could cause that ?<br>

As I can&#39;t have any trace, I don&#39;t really know how to go further, and before using a BDI I would like to know if it is a known issue, as I could not find anything related to this in the recent changes...<br><br>Thanks in advance for your help,<br>

Regards,<br>JM<br>

--20cf30025e5a1bdb9804ad972e05--

