Date: Thu, 8 Oct 2015 21:25:05 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151008192505.GH8324@hermes.click-hack.org>
References: <CAEMXjGwRGn2DQYxinAaCzqLXbqhrG6RsNVODsDO9SGF=a60ccg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEMXjGwRGn2DQYxinAaCzqLXbqhrG6RsNVODsDO9SGF=a60ccg@mail.gmail.com>
Subject: Re: [Xenomai] Question about RT serial and SCHED_FIFO vs.
	SCHED_OTHER
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steve B <sbattazzo@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On Thu, Oct 08, 2015 at 11:37:59AM -0700, Steve B wrote:
> Hello all,
> In working with an application I have using RT serial, I have noticed the
> following:
> 
> It seems like if I try rt_dev_open and/or rt_dev_ioctl from a SCHED_FIFO
> task, my application hangs requiring a hard reboot, and if I try
> rt_dev_write when my task is set up as SCHED_OTHER, I get "CPU time limit
> exceeded" and the application dies (but at least I don't have to do a hard
> reboot at this point).
> 
> Does this behavior make sense?
> It seems now that everything is in order when I apply the workaround of
> having my UART listening task switch itself to SCHED_FIFO or SCHED_OTHER at
> the appropriate times during port initialization, but I'm still curious if
> this is the expected behavior.
> 

Hi,

Please have a look at the serial console if your machine has a
serial console, to see if you do not get a message when the machine
freezes.

And please read:
http://xenomai.org/asking-for-help/

And post again with more details.

Regards.

-- 
					    Gilles.
https://click-hack.org

