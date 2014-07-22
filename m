From: "Steve M. Robbins" <steve@sumost.ca>
Date: Tue, 22 Jul 2014 02:17:19 -0500
Message-ID: <7090484.11r8mI5aN1@riemann>
In-Reply-To: <53A471AB.3030904@xenomai.org>
References: <1705234.5kun8kYdZP@riemann> <53A471AB.3030904@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [Xenomai] POSIX application running under xenomai -- what do
	wrapped functions do?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On June 20, 2014 07:38:51 PM Philippe Gerum wrote:
> On 06/20/2014 05:48 PM, Steve M. Robbins wrote:

> > So I'm working on a motion control project using a Delta Tau system which
> > consists of a PowerPC running Linux with Xenomai 2.5.6.  Delta Tau has
> > arranged things so that you can just write servo loop code in their IDE
> > and
> > the build process takes care of the details.  They also provide a way to
> > write a "background" linux program, which we use as a communications
> > bridge to a second user interface system, sending commands and data over
> > a socket.  The bridge program is mainly doing logging and socket I/O. We
> > use some shared memory to send commands down to a real-time task (called
> > RTI) and servo routine tasks (all written in C) and read back status.
> > Additionally, we have a pair of FIFOs sending data streams from RTI to
> > the bridge process.
> > 
> > Until a few days ago, I considered the bridge program as a regular POSIX C
> > program, but digging into the build system I discovered that it links with
> > the xenomai posix skin libraries, with all the --wrap commands passed to
> > the linker.  Furthermore the threads of this program appear in
> > /proc/xenomai/sched (with PRI=1) and /proc/xenomai/stat shows that the
> > threads are performing a huge number of mode switches.

By removing the --wrap arguments on the link step, we removed the mode
switching of the bridge process.  This appears to have cured our hardware
watchdog problem.


> > Q7: In addition to the inconsistent wrapping in bridge, the real-time task
> > RTI does not wrap any of its calls, e.g. we use write() on the FIFO.  Is
> > this going to cause trouble?
> 
> This is going to switch any real-time Xenomai caller to secondary/non rt
> mode for sure.

Yep, the RTI does a ton of mode switching.  It's due entirely to the write() 
calls: as an experiment, I commented out the write()s and the mode switches 
went away.

 
> In case this applies, if you want to exchange a stream of data between
> the rt and non-rt world, then you may want to have a look at the
> RTDM-based XDDP IPC,
> http://www.xenomai.org/documentation/xenomai-2.6/html/api/group__rtipc.html,
> with sample code in examples/rtdm/profiles/ipc.
> This feature allows a non-rt thread reading/writing to a pseudo-device
> from /dev/rtp* to exchange messages with a rt thread reading/writing to
> a RTDM socket. The rt side never leaves primary mode when doing so, and
> the non rt program does not even have to link against Xenomai libraries.


Yeah, that sounds like what I want.  We are stuck with Xenomai 2.5.6 for now, 
so I went and looked in the docs for that version.  It looks like the Message 
Pipe services [1] would be a fairly direct replacement for our existing FIFO 
code.  How does the Message Pipe compare to your suggestion of Real Time IPC?  
I do see an entry for the Real Time IPC devices in the 2.5 docs [2], albeit a 
bit sparse on details.  Can I simply use the 2.6 docs as a reference?


[1] http://www.xenomai.org/documentation/xenomai-2.5/html/api/group__pipe.html
[2] 
http://www.xenomai.org/documentation/xenomai-2.5/html/api/group__rtipc.html

Thanks,
-Steve


