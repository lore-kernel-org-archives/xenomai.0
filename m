Message-ID: <5176B0E3.3030009@xenomai.org>
Date: Tue, 23 Apr 2013 18:03:47 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1366732845.34430.YahooMailNeo@web161405.mail.bf1.yahoo.com>
In-Reply-To: <1366732845.34430.YahooMailNeo@web161405.mail.bf1.yahoo.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] rt_task_wait_period returns -11 (-EAGAIN)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Tom Z <tomz30@yahoo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/23/2013 06:00 PM, Tom Z wrote:
> Hi,
>
> It seems this problem didn't occur before, but yesterday when I ran the same program on the same platform, a statement in my program calling rt_task_wait_period() returns -11. I looked up the error code, and 11 is the value of EAGAIN defined in <LINUX INCLUDE>/asm-generic/error_base.h. So I tried to modify my code like this
>
> unsigned long overrun;
>
> ret = -EAGAIN
> while(-EAGAIN == ret)
>      ret = rt_task_wait_period( &overrun);
>
>
> But it keeps spinning and throws an error in the end: CPU time exceeded.
>
>
>
> What would be the possible cause?　Ｍｙ platform is a Core 2 Duo laptop with Xenomai 2.6.2.1 on Linux 3.5.7.
>


Check the doc for EWOULDBLOCK. rt_task_set_periodic() was not
called for the task.

-- 
Philippe.

