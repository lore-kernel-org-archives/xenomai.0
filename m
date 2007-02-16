From: Jeff Weber <jweber@domain.hid>
Date: Fri, 16 Feb 2007 15:58:01 -0600
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200702161558.01839.jweber@domain.hid>
Subject: [Xenomai-help] tracer from user space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai Help <xenomai@xenomai.org>

I need to isolate an unacceptable latency resuming a primary mode task, by 
determining the events the events that preceeded the delay, preferably from 
userspace.  I cannot rule out a userspace coding error contributing to the 
latency.

Is this a job better suited to task switch hooks, or the ipipe tracer, or 
perhaps yet another tool?

Assuming the best tool is the ipipe tracer, because task switch hooks must be 
used from kernel space, how much can I learn about the user space tasks and 
function calls that preceeded the latency?

(All the sample tracer output I've found has shown kernel function call 
activity.)

What is the minimum ipipe patch to have useful tracer functionality?
(I'm currently using Linux-2.6.17.14 + adeos-ipipe-2.6.17-i386-1.5-00 + 
xenomai-2.2.4 )

	thanks,
	Jeff

