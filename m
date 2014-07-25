From: "Steve M. Robbins" <steve@sumost.ca>
Date: Fri, 25 Jul 2014 09:54:37 -0500
Message-ID: <1927199.3ixLvlnsCr@riemann>
In-Reply-To: <53D01D0F.8030202@xenomai.org>
References: <1705234.5kun8kYdZP@riemann> <7090484.11r8mI5aN1@riemann>
 <53D01D0F.8030202@xenomai.org>
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

On July 23, 2014 10:37:35 PM Philippe Gerum wrote:

> RTIPC/xddp and the Message pipe services are based on the very same code
> in the Xenomai core, it's only a matter of differing interfaces. Over
> 2.5.6, I would go for the pipes, since the xddp driver in that release
> might lack a couple of fixes which were merged into 2.6.

OK, we are now looking a bit more closely at the 2.5 Message Pipe docs and my colleague noticed a small quirk.  

For rt_pipe_read(), the doc [1] says:

		Environments:

		This service can be called from:

		 *    Kernel module initialization/cleanup code
		 *    Interrupt service routine only if timeout is equal to TM_NONBLOCK.

		 *    Kernel-based task
		 *    User-space task (switches to primary mode)

So a literal reading of the last two bullet points suggest that a call from kernel-based task never switches to primary mode while a call from the user-space task always does.  Naively that seems surprising.  Is it accurate?  

Secondly, for a user-space task: will it mode switch if there is data available?  If we use TM_NONBLOCK in a user space task, can we avoid the mode switch?

Finally, the function rt_pipe_receive() is pretty similar to rt_pipe_read() so much so that I would guess one is implemented using the other.  Thus I'm a bit surprised that its "Environments" documentation [2] differs from the previous in that it doesn't list "User-space task".  Is that accurate?


[1] http://www.xenomai.org/documentation/xenomai-2.5/html/api/group__pipe.html#g62cb64807c2c843f8e8eebb2dc3a7d4e
[2] http://www.xenomai.org/documentation/xenomai-2.5/html/api/group__pipe.html#g731e5ef18007dcd58a9346bea66abbc6

Thanks,
-Steve


