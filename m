Date: Mon, 11 May 2015 21:26:45 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150511192645.GB3759@hermes.click-hack.org>
References: <2769EB0871C23A4C8DB00D1218015E8E1B0CE61F@de08ex3008.global.ds.honeywell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2769EB0871C23A4C8DB00D1218015E8E1B0CE61F@de08ex3008.global.ds.honeywell.com>
Subject: Re: [Xenomai] Signal not received
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Mann, Anthony M" <Anthony.Mann@Honeywell.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, May 11, 2015 at 07:04:05PM +0000, Mann, Anthony M wrote:
> The code below uses POSIX and when compiled for a Linux kernel, it
> works.  When the code is compiled to use the Cobalt real-time kernel, the
> POSIX calls are wrapped (--posix).  Executing the program, the thread,
> timer and semaphore work but the signal from the expired timer (SIGRTMIN)
> is not delivered but is in the queue.  I had tried to unblock all signals
> when the signal was detected in the queue.  That did not work either.
> 
> Also, when compiled for the Linux kernel, sigemptyset with sigsuspend
> causes the main loop to suspend; however, the POSIX wrappped version,
> sigsuspend did not suspend the loop.  Sigprocmask was needed to be call
> first, then it suspended.  Since the SIGTRMIN was not received the main
> goes no further.  However, when pressing ctrl-c, the SIGINT is received
> and calls the kill_handler routine as intented.  Then the main loop
> continues.
> 
> I am new to Xenomai and any suggestions on why the program is not
> receiving the SIGRTMIN signal and how to correct it will be much
> appreciated.
> 
> The system is setup with:
> Ubuntu 14.04 LTS
> vanilla kernel linux 3.14.33
> ipipe-core-3.14.33-x86-8.patch
> xenomai-3.0-rc4
> Build args: --with-core=cobalt --enable-smp --enable-pshared
>             --host=x86_64-linux host_alias=x86_64-linux

See:
https://xenomai.org/migrating-from-xenomai-2-x-to-3-x/#Real-time_signals

-- 
					    Gilles.

