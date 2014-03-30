From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Sun, 30 Mar 2014 19:20:33 -0400
Message-ID: <20140330232033.GN17765@csclub.uwaterloo.ca>
References: <5338834B.5090604@steinkuehler.net> <53388F8A.6030403@xenomai.org>
 <533894D3.8090803@steinkuehler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <533894D3.8090803@steinkuehler.net>
Subject: Re: [Xenomai] Dedicated Core?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Charles Steinkuehler <charles@steinkuehler.net>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Sun, Mar 30, 2014 at 05:04:03PM -0500, Charles Steinkuehler wrote:
> I am not looking to migrate something that should be a kernel service,
> instead I'm trying to replace having dedicated hardware.

Those PRUs sure can be handy.

> We already have hooks to set processor affinity.  What I am interested
> in is if I dedicate an entire core to running a tight code loop, can I
> avoid Xenomai and/or Linux "pulling the core out from under me" as a
> result of various hardware interrupts or general task scheduling?
> 
> I can live with the code not running for the duration of the Xenomai
> interrupt handler (that's happening now anyway), I just want to know if
> it is (easy) to keep Xenomai and Linux from grabbing the core running my
> tight loop after the interrupt event.  It's similar to having one core
> running "bare metal" code, but I actually need Linux and Xenomai to
> manage setting up the shared memory regions used for IPC prior to
> launching my code.

There are people running the i.MX6 in AMP mode with linux one one core
and a seperate RTOS on another core.

For example https://www.youtube.com/watch?v=1uzrX-YZBnQ mentions doing
exactly that.

Xenomai is good at letting you use all your resources for both real time
and non real time, but if you are willing to dedicate some hardware
entirely to real time, then there are other options for doing that.
I don't think it is at all what Xenomai is aimed at.

-- 
Len Sorensen

