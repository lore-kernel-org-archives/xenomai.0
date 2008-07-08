Message-ID: <4873B67C.4080809@domain.hid>
Date: Tue, 08 Jul 2008 20:48:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1215525959.487374472c1bc@domain.hid>
In-Reply-To: <1215525959.487374472c1bc@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_read_timer value
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: nourry@domain.hid
Cc: xenomai@xenomai.org

nourry@domain.hid wrote:
> Hi,
> 
> i try to make a little program that just records time reaction : a picture
> appears and we must press a key. Time between image appeared and keypress is
> recorded.
> 
> For that, i use rt_time_read() in aperiodic mode (since if we don't specify
> rt_task_set_periodic(), aperiodic mode is default, that's right ?).
> 
> It seems working until a little bit more 2 seconds, but after that, value
> returned is negative and decreasing, while it was positive and increasing (weird
> because i've read that in aperiodic mode it should be decreasing all the time).
> 
> Moreover, i believe remember that while beginning this program, time was always
> decreasing, like real-time task were affected by the rest of the program.
> 
> I must record time until 5 seconds after image appeared, and this problem
> doesn't ease the task.
> 
> I must have made a mistake, can someone help me ?

rt_timer_read value should never be decreasing, except maybe from time
to time when an overflow takes place. A decreasing clock would really be
something unatural to work with. Overflow may take place more often if you
cast the return value of rt_timer_read to 32 bits: it is a 64 bits
value, and I would not expect it to overflow before years of uptime.
So, there is probably something wrong with your program. Have you
included native/timer.h ? Do you store the result of rt_timer_read in a
64 bits variable ?

> 
> Another little question, which functions, librairies, calls in one word can we
> make in real-time tasks without breaking it ? I want to use event detection from
> SDL library to catch keypress, there's a function that polls for events (for the
> moment i use kbhit). It doesn't seems to increase latency in an endless loop. I
> must keep latency under 1 ms since goal is to measure time reaction with
> accuracy.

The only function which you can call without breaking real-time are
those documented as such in Xenomai native skin (or posix skin, for that
matter) documentation. Everything else needs careful inspection.
Everything that uses Linux system calls, such as for instance, functions
accessing non real-time drivers such as a keyboard driver, will break
real-time. The only functions that have a chance not to break real-time
are those which do not use system calls (and do not call functions which
use system calls), the function "sin" comes to my mind as an example of
such a function.

-- 


					    Gilles.

