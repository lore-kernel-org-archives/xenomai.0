Date: Fri, 10 Apr 2009 17:20:42 -0700 (PDT)
From: Martin Shepherd <mcs@domain.hid>
In-Reply-To: <Pine.LNX.4.64.0904101250540.4820@domain.hid>
Message-ID: <Pine.LNX.4.64.0904101708030.4820@domain.hid>
References: <Pine.LNX.4.64.0904081243120.22300@domain.hid>
	<Pine.LNX.4.64.0904081659110.22300@domain.hid>
	<Pine.LNX.4.64.0904101250540.4820@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [Xenomai-help] Running xeno-test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

I need some help in running xeno-test. When I run it, it runs some
tests okay, but fails to start others, and I am wondering if there is
a missing kernel module or configuration that I need to add.

I have been running it as follows (after changing #!/bin/sh to #!/bin/bash):

  sudo -i
  modprobe xeno_switchtest
  modprobe xeno_timerbench
  modprobe xeno_klat

  xeno-test

This runs the first latency test okay, but then on the second I see:

  running: ./run -- -sh -T 120 -t1 # latency
  *
  *
  * Type ^C to stop this application.
  *
  *
  == Sampling period: 100 us
  == Test mode: in-kernel periodic task
  == All results in microseconds
  latency: failed to start in-kernel timer benchmark, code -25

The -25 error code is -ENOTTY, and appears to comes from the following
line of src/testsuite/latency/latency.c:

   err =
        rt_dev_ioctl(benchdev, RTTST_RTIOC_TMBENCH_START, &config);

Given that the xeno_timerbench module is loaded, I can't see why this
would return this error. Is there something else that I need to do to
get this working?

Thanks,

Martin

