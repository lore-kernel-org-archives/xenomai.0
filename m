From: Henry Bausley <hbausley@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 04 Apr 2011 09:12:54 -0700
Message-ID: <1301933574.2049.7.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Placing Xenomai and Linux on Seperate CPU's
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org


Is there a way to place linux on its own core so that it continues to
operate under high realtime loads?  

I seem to be able to do this with a xenomai kernel task and user space
task. As a test I created a large load in my kernel task which of course
caused my xenomai user space application to come to a crawl as expected
since they were both on CPU0.  

I recompiled my kernel task with  T_FPU|T_CPU(2).  With the xenomai user
space task on CPU0 and kernel task on CPU2 they operated in parallel so
my xenomai user space task did not come to crawl.  

I was hoping linux could run on CPU1 & CPU3 so that keyboard input and
mouse input doesn't stop under heavy loads in a kernel task .  However
currently under heavy kernel loading linux basically stops.

I am currently using xenomai 2.5.5.2 w/ Ubuntu 10.04 and testing on an
ATOM D525 which shows up as 4 CPU's (two cores with two hyper threads)
my second test machine is a i5 750 (four cores).





Outbound scan for Spam or Virus by Barracuda at Delta Tau


