Message-ID: <52414180.1050909@xenomai.org>
Date: Tue, 24 Sep 2013 09:38:40 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5240004A.6070703@mitrol.it>
In-Reply-To: <5240004A.6070703@mitrol.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt_intr_wait bug during debugging
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paolo Minazzi <Paolo.Minazzi@mitrol.it>
Cc: xenomai@xenomai.org

On 09/23/2013 10:48 AM, Paolo Minazzi wrote:
> Hi to all,
> the problem arise when I debug an application that uses an external
> interrupt.
> Below there is a sample (pseudo) code that show how I can see the problem.
> The irq stuff is related on my specific machine, so I think it is not
> important
> give details about GPIO programming and interrupt clear (CLEAR_IRQ).
>
> To see the problem :
> 1. I put a breakpoint on the usleep
> 2. I countinue to send "c" to stop always in the breakpoint.
>

Unless you enabled non-stop mode for GDB, breakpointing the main thread 
will stop all threads, including your IRQ server. Interrupts won't be 
acked the way they should, if the relevant code lives in userland. This 
may cause all sorts of weird behaviors (*).

This is why we strongly recommend managing interrupt delivery from a 
RTDM driver - it does not have to be complex, and NOT from userland. 
This driver may then expose an interface to userland for receiving IRQ 
notifications (read, ioctl, whatever fits).

(*) You may want to check your kernel log, in case the Xenomai core 
decided to disable the interrupt line to prevent an IRQ storm.

-- 
Philippe.

