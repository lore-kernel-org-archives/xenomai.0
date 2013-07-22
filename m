From: Christoph <c.stoidner@arvero.de>
Date: Mon, 22 Jul 2013 16:52:00 +0000 (UTC)
Message-ID: <loom.20130722T184351-130@post.gmane.org>
References: <CAOiXNkD+-yANz15W_cnD9QLjyGH7LUT-Pf8LEJHqx4Kh24pL+g@mail.gmail.com>
	<4F954ABE.20508@xenomai.org>
	<CAOiXNkDKRpQKjtvC-H1YsJtHkNWYcWTUEKPqfYv0HQ_=SRHGCw@mail.gmail.com>
	<4F955058.6080004@xenomai.org>
	<CAOiXNkAGMH+CEQkp3rS0tSZbKQbu9BKrs8SDaFiyY-YFvAdcPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai]
	=?utf-8?q?Jitter_while_generating_PWMs_with_GPIO_from_R?=
	=?utf-8?q?TDM=09driver?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


Hi Andrey,

 
> 
> I see... Nevertheless, I am surprised that context switch is so expensive.

Especially on ARM9 Platform a context switch takes very long time. The
reason is the cache implementation, that requires to flush instruction cache
and data cache at each context switch.

There is a patch for the linux kernel called Fast Context Switch Extension
(FSCE), that speeds up the context switch a lot. If you have installed
i-pipe you should find it within the kernel config. Have a look at it's
restriction that are mentioned in the config's help.

Regards
Christoph


