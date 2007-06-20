From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <op.tt74pfqvt06gyn@domain.hid>
References: <op.tt74pfqvt06gyn@domain.hid>
Content-Type: text/plain
Date: Wed, 20 Jun 2007 16:32:19 +0200
Message-Id: <1182349939.6137.2.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Status Codes in /proc/xenomai/sched
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Axel Beierlein <belatronix@domain.hid>
Cc: "Xenomai-help@domain.hid" <Xenomai-help@domain.hid>

On Wed, 2007-06-20 at 16:18 +0200, Axel Beierlein wrote:
> Hello,
> 
> Where can i find the meaning of the status code at the column STAT
> in /proc/xenomai/sched ? I am a little bit confused of the Status UX.
> 

include/nucleus/thread.h for now, until this eventually gets more
formally documented:

  'S' -> Forcibly suspended.
  'w'/'W' -> Waiting for a resource, with or without timeout.
  'D' -> Delayed (without any other wait condition).
  'R' -> Runnable.
  'U' -> Unstarted or dormant.
  'X' -> Relaxed shadow.
  'H' -> Held thread.
  'b' -> Priority boost undergoing.
  'T' -> Ptraced and stopped.
  'l' -> Locks scheduler.
  'r' -> Undergoes round-robin.
  's' -> Interrupt shield enabled.
  't' -> Mode switches trapped.
  'o' -> Priority coupling off.
  'f' -> FPU enabled (for kernel threads).

> Thanks in Advance
> 
> Axel
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



