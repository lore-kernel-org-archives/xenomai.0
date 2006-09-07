From: Ulrich Schwab <schwab@domain.hid>
Subject: Re: [Xenomai-help] Porting / API Questions
Date: Thu, 7 Sep 2006 11:12:28 +0200
References: <44FF3C26.10501@domain.hid>
In-Reply-To: <44FF3C26.10501@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609071112.28817.schwab@domain.hid>
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

On Wednesday 06 September 2006 23:22, Jeff Webb wrote:
> I am attempting to port a real-time simulation from rtlinux3.2-pre3 (GPL)
> to xenomai.  The application consists of a kernel module, and a user-space
> application.  I would like to port the application to xenomai with as few
> changes as possible, and then make improvements in incremental steps.  I am
> currently working on a Fedora Core I, Linux-2.4.32 / xenomai-2.1-rc4
> system.
Why not the latest version of xenomai (2.2) ? 
>
> In this simulation, we use the rtlinux POSIX-like API for threads, timing,
> and writing-to / reading-from real-time FIFOs.  It looks like the
> xeno_posix API will allow me to port the thread and timing code with very
> few (if any) changes.  There does not appear to be a kernel-space version
> of read and write for use on xenomai pipes.  Am I missing something?
When I did the same switch (9 month ago now) I choose to combine
the kernel / user space split in one application and switched to the native 
API at the same time.
I think it was a good decision, since now the application is independent of 
the exact kernel version and is easier to debug.
Only the driver for the analog and digital I/O is still a kernel module (RTDM)

The RT kernel threads of the original version are now threads of the user 
space app running in primary mode. This means the split between RT/non-RT
is basically the same as before, but now they all run in user space.

>
> I noticed that the rtai API appears to support real-time FIFOs, much like
> the old RTLinux API.  In light of this discovery, I changed my RT-Linux
> code to use rtf_get and rtf_put calls (instead of read/write).  This code
> seems to compile for xeno_rtai without too much trouble.
>
> Is it okay to use the POSIX API for threads and timing, and the rtai API
> for FIFOs?  It seems like this is working, but I want to make sure that
> there are no hidden problems.
>
> I have compiled my application for xenomai.  The kernel module loads fine,
> and the userspace application runs as well.  The problem I am having now is
> creating a large FIFO, which is why I wrote the previous email.
Why do You need a FIFO this large ?
Why not using shared memory for the data, and the FIFO for passing
signals/commands ?

Ulrich
>
> Any input on this porting project would be appreciated.  Thanks!
>
> -Jeff
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

