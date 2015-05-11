Message-ID: <5551025A.8060700@xenomai.org>
Date: Mon, 11 May 2015 21:26:18 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <2769EB0871C23A4C8DB00D1218015E8E1B0CE61F@de08ex3008.global.ds.honeywell.com>
 <555100ED.5040300@xenomai.org>
In-Reply-To: <555100ED.5040300@xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Signal not received
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Mann, Anthony M" <Anthony.Mann@Honeywell.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/11/2015 09:20 PM, Philippe Gerum wrote:
> On 05/11/2015 09:04 PM, Mann, Anthony M wrote:
>> The code below uses POSIX and when compiled for a Linux kernel, it
>> works.  When the code is compiled to use the Cobalt real-time kernel, the
>> POSIX calls are wrapped (--posix).  Executing the program, the thread,
>> timer and semaphore work but the signal from the expired timer (SIGRTMIN)
>> is not delivered but is in the queue.  I had tried to unblock all signals
>> when the signal was detected in the queue.  That did not work either.
>>
>> Also, when compiled for the Linux kernel, sigemptyset with sigsuspend
>> causes the main loop to suspend; however, the POSIX wrappped version,
>> sigsuspend did not suspend the loop.  Sigprocmask was needed to be call
>> first, then it suspended.  Since the SIGTRMIN was not received the main
>> goes no further.  However, when pressing ctrl-c, the SIGINT is received
>> and calls the kill_handler routine as intented.  Then the main loop
>> continues.
>>
>> I am new to Xenomai and any suggestions on why the program is not
>> receiving the SIGRTMIN signal and how to correct it will be much
>> appreciated.
> 
> The doc mentioned below may help. Executive summary: asynchronous
> delivery of signals is not supported, a thread has to wait for these
> explicitly.
> 
> http://xenomai.org/migrating-from-xenomai-2-x-to-3-x/#Real-time_signals
> 

Btw, this assumes that you are running xenomai 3, in which case, you can
still access the regular (non real-time) linux implementation of
timer_create() as follows:

ret = __STD(timer_create(...));

Conversely, timers created by the Cobalt/POSIX API will deliver signal
notifications to a thread waiting for them via sigwait(), sigtimedwait()
etc.

-- 
Philippe.

