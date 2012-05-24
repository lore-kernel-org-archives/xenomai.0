Message-ID: <COL115-W475E9F301660B2C796E3CFE2000@phx.gbl>
From: =?gb2312?B?y++yrr3c?= <sun.bojie@hotmail.com>
Date: Thu, 24 May 2012 14:54:34 +0000
In-Reply-To: <mailman.12.1337871081.15349.xenomai@xenomai.org>
References: <mailman.12.1337871081.15349.xenomai@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] help: Latency of xenomai on Portwell NANO 8044 with Atom
 Z530
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai MailingList <xenomai@xenomai.org>








Hello everyone,

I'm doing tests of Real-time Java on my target board: Portwell NANO 8044 with Atom Z530 1.6 GHz. I've already installed xenomai on it and run some example tests like "Latency" and "Wakeup-time" in /usr/xenomai/bin. When I start the latency test, just get a quit good average latency but at the same time a  very big max. latency. 

I run it in user-mode and the period should be 100 us. Then I get an average latency around 1 or 2 us, but a max. latency around 400 us. After several minutes running, the latency can get to be negative in worst-case. Actually I don't know how to switch to kernel mode because I'm really new in compiling the linux-kernel.

However, when I start the periodic-test in examples, the performance is still quite fine. So I'm confused about that.

By the way, I've already made the configuration carefully several times. The probable reasons (like CONFIG_CPU_FREQ,APM,ACPI_PROCESSOR,INTEL_IDLE,SMI, usb UHCI HW driver ) listed in troubleshooting on the wiki have been all checked by myself in the menuconfig.

And What I'm not sure is whether the performance of my Real-time Java VM will be affected by this Latency of xenomai? The VM uses the POSIX Timer and if I use the POSIX skin in xenomai, I'm not sure whether the performance can be different from on standard linux kernel. 

Thanks a lot in advance.

Regards,
Bojie Sun 
 		 	   		   		 	   		  
