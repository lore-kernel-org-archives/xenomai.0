From: Ulrich Schwab <schwab@domain.hid>
Subject: Re: [Xenomai-help] Xenomai 2.0.1 - Posix Skin - realtime priorities -
	what I'm doing wrong?
Date: Fri, 9 Dec 2005 16:50:11 +0100
References: <439995C0.6030006@domain.hid>
In-Reply-To: <439995C0.6030006@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512091650.11637.schwab@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

On Friday 09 December 2005 15:33, Paolo Gai wrote:
> Dear all,
>
> First of all, I would like to thank Philippe for the long and exaustive
> reply to my previous post about the scheduling example.
>
> I'm now trying the POSIX skin to write a very simple example using
> real-time priorities, RR and FIFO scheduling.
>
> The idea is that a high priority task creates two medium priority tasks
> (that just prints something using printf) and a low priority task (that
> prints a message).  The example is run twice, in one case the medium
> priority tasks have SCHED_FIFO, in another case they have SCHED_RR.
>
> I would expect that in both cases the two medium priority tasks would
> run printing their characters (either in a FIFO order or mixed when
> using RR), and at their end the low priority task would have run
> printing its message.
I did not look inside Your code, but if You are using printf the threads will 
be switched back to secondary domain (non-RT), this might screw up the order 
of scheduling.
You can try using a pipe to hand down the print output to a reader thread in 
secondary domain. This way Your threads in primary domain stay where they 
belong.

So long,
Ulrich Schwab

-- 
====================================================
  inmess GmbH
  Frankfurter Str. 74
  D - 64521 Gross-Gerau
  Phone: +49 6152 97790
  Fax  : +49 6152 977920
  mail : info@domain.hid
  web:   www.inmess.de
====================================================

