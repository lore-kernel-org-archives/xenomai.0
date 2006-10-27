Message-ID: <45421B89.3090302@domain.hid>
Date: Fri, 27 Oct 2006 09:45:29 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] switchtest and Xenomai 2.2.4
References: <1160947939.4962.27.camel@domain.hid> <453FC4C0.5070105@domain.hid>
	<454078AD.5000907@domain.hid> <4540DE60.40209@domain.hid>
	<4540E1AB.2040200@domain.hid> <4540EABD.10403@domain.hid>
	<4540ECA6.5000604@domain.hid> <45411147.1070205@domain.hid>
	<4541C0E6.3070807@domain.hid>
In-Reply-To: <4541C0E6.3070807@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Ok, could you try one last thing: keep try_module_get and module_put in
> ksrc/drivers/testing/switchtest.c and apply the attached patch to 
> src/testsuite/switchtest/switchtest.c

This does not seem to fix the problem completely.  Output stops after pressing ctrl-c one time, and I get:

[root xeno-build-r1749p5]# ps a -T
  PID  SPID TTY      STAT   TIME COMMAND
19878 19878 pts/1    SLl+   0:00 ./switchtest
19878 19884 pts/1    SLl+   0:00 ./switchtest
19878 19885 pts/1    SLl+   0:00 ./switchtest
19878 19886 pts/1    SLl+   0:00 ./switchtest
19878 19887 pts/1    SLl+   0:00 ./switchtest

[root xeno-build-r1749p5]# cat /proc/xenomai/sched
CPU  PID    PRI      PERIOD   TIMEOUT    STAT       NAME
  0  0       -1      0        0          R          ROOT/0
  1  0       -1      0        0          R          ROOT/1
  0  19878    0      0        0          X          switchtest
  0  0        1      0        0          W          rtk1/0
  0  0        1      0        0          W          rtk2/0
  0  0        1      0        0          Wf         rtk3/0
  0  0        1      0        0          Wf         rtk4/0
  0  0        1      0        0          Wf         rtk5/0
  0  0        1      0        0          Wf         rtk6/0
  0  19884    1      0        0          R          rtus0-11
  0  19885    1      0        0          R          rtus0-12
  0  19886    1      0        0          R          rtus_ufps0-13
  0  19887    1      0        0          R          rtus_ufps0-14
  1  0        1      0        0          W          rtk1/1
  1  0        1      0        0          W          rtk2/1
  1  0        1      0        0          Wf         rtk3/1
  1  0        1      0        0          Wf         rtk4/1
  1  0        1      0        0          Wf         rtk5/1
  1  0        1      0        0          Wf         rtk6/1

After pressing ctrl-c a second time, switchtest exits leaving a clean 'ps', but I get:

[root xeno-build-r1749p5]# cat /proc/xenomai/sched
CPU  PID    PRI      PERIOD   TIMEOUT    STAT       NAME
  0  0       -1      0        0          R          ROOT/0
  1  0       -1      0        0          R          ROOT/1
  0  0        1      0        0          W          rtk1/0
  0  0        1      0        0          W          rtk2/0
  0  0        1      0        0          Wf         rtk3/0
  0  0        1      0        0          Wf         rtk4/0
  0  0        1      0        0          Wf         rtk5/0
  0  0        1      0        0          Wf         rtk6/0
  1  0        1      0        0          W          rtk1/1
  1  0        1      0        0          W          rtk2/1
  1  0        1      0        0          Wf         rtk3/1
  1  0        1      0        0          Wf         rtk4/1
  1  0        1      0        0          Wf         rtk5/1
  1  0        1      0        0          Wf         rtk6/1

Removing the module then fails:

[root switchtest]# /sbin/rmmod xeno_switchtest
ERROR: Module xeno_switchtest is in use
[root switchtest]#

I can run switchtest multiple times, but I get more and more leftover threads in /proc/xenomai/stat.

-Jeff


