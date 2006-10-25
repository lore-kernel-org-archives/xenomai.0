Message-ID: <453FC4C0.5070105@domain.hid>
Date: Wed, 25 Oct 2006 15:10:40 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
References: <1160947939.4962.27.camel@domain.hid>
In-Reply-To: <1160947939.4962.27.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] switchtest and Xenomai 2.2.4
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

When I upgraded to Xenomai 2.2.4, I tried the switchtest program:

  cd /usr/xenomai/testsuite/switchtest
  ./run

The program appeared to run properly, but <ctrl>-c would not stop the application.  I was not able to kill the process cleanly, and /proc/xenomai/stat showed lots of processes still running.

The other tests (latency, cyclic, switchbench) and the program I am developing seem to work normally.

I have not experienced this problem with previous versions of Xenomai.

System details:
 adeos-ipipe-2.6.17-i386-1.5-00.patch
 Linux version 2.6.17.13
 AMD Athlon(tm)64 X2 Dual Core Processor  4400+
 Fedora Core 5
 SMP kernel

Is there anything I can do to help find the problem?

Thanks,

Jeff

