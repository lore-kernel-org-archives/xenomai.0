Message-ID: <44FF3C26.10501@domain.hid>
Date: Wed, 06 Sep 2006 16:22:46 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Porting / API Questions
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


I am attempting to port a real-time simulation from rtlinux3.2-pre3 (GPL) to xenomai.  The application consists of a kernel module, and a user-space application.  I would like to port the application to xenomai with as few changes as possible, and then make improvements in incremental steps.  I am currently working on a Fedora Core I, Linux-2.4.32 / xenomai-2.1-rc4 system.

In this simulation, we use the rtlinux POSIX-like API for threads, timing, and writing-to / reading-from real-time FIFOs.  It looks like the xeno_posix API will allow me to port the thread and timing code with very few (if any) changes.  There does not appear to be a kernel-space version of read and write for use on xenomai pipes.  Am I missing something?

I noticed that the rtai API appears to support real-time FIFOs, much like the old RTLinux API.  In light of this discovery, I changed my RT-Linux code to use rtf_get and rtf_put calls (instead of read/write).  This code seems to compile for xeno_rtai without too much trouble.

Is it okay to use the POSIX API for threads and timing, and the rtai API for FIFOs?  It seems like this is working, but I want to make sure that there are no hidden problems.

I have compiled my application for xenomai.  The kernel module loads fine, and the userspace application runs as well.  The problem I am having now is creating a large FIFO, which is why I wrote the previous email.

Any input on this porting project would be appreciated.  Thanks!

-Jeff

