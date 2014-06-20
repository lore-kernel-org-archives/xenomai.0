From: "Steve M. Robbins" <steve@sumost.ca>
Date: Fri, 20 Jun 2014 10:48:32 -0500
Message-ID: <1705234.5kun8kYdZP@riemann>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: [Xenomai] POSIX application running under xenomai -- what do
	wrapped functions do?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I've looked through the FAQ and read all the "Start Here" documentation on the 
wiki.  At the risk of sounding dense, I confess I am still a bit unsure what 
the wrapped POSIX functions are doing.  This is going to be a long-winded 
post, but here's the first questions:

Q1: Generically, what are the wrapped functions doing?  I did look at the code 
for wrapped select().  I can see it calls some xenomai function and falls back 
to the regular select(), but well, let's just say I'm no wiser...

Q2: The POSIX skin wraps I/O like read() and write().  Is it supported to mix
wrapped and unwrapped calls?  I have inherited a code base where some I/O with 
FIFOs and files uses wrapped calls but socket code uses unwrapped code.

Q3: The POSIX skin wraps select() but not pselect().  The two functions are 
basically identical in function if you don't use signal masking (as we don't). 
So we have different behaviour if I choose pselect() over select(). Since  
Xenomai needs to wrap one, is there a chance that using the unwrapped 
alternative may confuse Xenomai?  Our code uses pselect() today.



So I'm working on a motion control project using a Delta Tau system which 
consists of a PowerPC running Linux with Xenomai 2.5.6.  Delta Tau has 
arranged things so that you can just write servo loop code in their IDE and 
the build process takes care of the details.  They also provide a way to write 
a "background" linux program, which we use as a communications bridge to a 
second user interface system, sending commands and data over a socket.  The 
bridge program is mainly doing logging and socket I/O. We use some shared 
memory to send commands down to a real-time task (called RTI) and servo 
routine tasks (all written in C) and read back status. Additionally, we have a 
pair of FIFOs sending data streams from RTI to the bridge process. 

Until a few days ago, I considered the bridge program as a regular POSIX C 
program, but digging into the build system I discovered that it links with the 
xenomai posix skin libraries, with all the --wrap commands passed to the 
linker.  Furthermore the threads of this program appear in /proc/xenomai/sched 
(with PRI=1) and /proc/xenomai/stat shows that the threads are performing a 
huge number of mode switches.

Our bridge suffers from random lockups. During one lockup, with the help of 
/proc/PID/status and /proc/PID/wchan, I was able to determine that the process 
was stuck in the system call "xnshadow_harden".  It stayed "stuck" for 30+ 
hours until I rebooted the machine.  

If interested, I posted some more details here:
* http://forums.deltatau.com/showthread.php?tid=1654
* http://forums.deltatau.com/showthread.php?tid=743


Q4: Generically, what causes a process to get stuck in xnshadow_harden()?  How 
would I troubleshoot further?

Q5: We do not call pthread_setschedparam() to change the scheduler or priority 
of the bridge program's threads, yet they appear as PRI=1 in 
/proc/xenomai/sched ... any ideas?  (Note that we do invoke an initialization 
function provided by Delta Tau which may be doing something under the covers).  

Q6: I realize I haven't given terribly many details, but generically, what 
would cause a non-real time "background" process to switch to the primary 
domain, as ours seems to do?

Q7: In addition to the inconsistent wrapping in bridge, the real-time task RTI 
does not wrap any of its calls, e.g. we use write() on the FIFO.  Is this 
going to cause trouble?

Thanks for reading this far.  If you can provide clues for even one of my 
questions, I'd be very very grateful.

Thanks,
-Steve


