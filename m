Message-ID: <4BEDC668.40708@domain.hid>
Date: Fri, 14 May 2010 23:53:44 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2319761F7FA0D1479BA77EC2E0A8E7BCE3D72A@alpine.pivotalsys.com>	
	<4BED7D5B.6050605@domain.hid>
	<1273866035.6334.435.camel@domain.hid>
In-Reply-To: <1273866035.6334.435.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_mutex created prior to main causes board to
 freeze?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Travis Stratman <tstratman@domain.hid>
Cc: xenomai@xenomai.org

Travis Stratman wrote:
> Gilles,
> 
> I provided the Xenomai build for this board so I thought that it would
> be appropriate for me to pick up for Sherk at this point.
> 
> On Fri, 2010-05-14 at 18:42 +0200, Gilles Chanteperdrix wrote:
>> Sherk Chung wrote:
>>> We are using Xenomai on an AT91 ARM board.  We wrote a program that
>>> creates multiple Xenomai tasks, which use rt_mutexes to when accessing
>>> some shared global variables.  The rt_mutexes used are declared
>>> globally, as in the example below.  Since the objects sharedVar1,
>>> shredVar2, etc. are declared on the global stack, the rt_mutexes are
>>> created prior to main() getting executed.  The problem we are having is
>>> that our program is causing our HW to freeze up on program load, it
>>> never gets to the first line of main(), and our HW supplier pointed out
>>> that we must call mlockall() and the set up the signal handlers before
>>> creating the mutexes.
>>>
>>>  
>>>
>>> Is there a problem with creating rt_mutexes the way we are doing, and
>>> should that cause the ARM board to freeze?  (the same program loads fine
>>> on an x86)
>> No, there should not be any problem. Creating a mutex does not require a
>> particular context, only locking it does.
>>
>> Which version of Xenomai do you sue, with which version of the I-pipe patch?
> 
> The port is for a custom AT91-based (AT91SAM9G20) board, but we apply
> the Xenomai patches directly. The kernel is 2.6.28 with the AT91 patches
> and a couple of custom drivers that should not impact Xenomai. The first
> build that I provided was Xenomai 2.5.2 with ipipe 1.12-07. After the
> problem was reported, I tested it on a version that has been used by
> several of our customers on large projects with the same board -- 2.4.8
> w/ ipipe 1.12-02. I saw the same results on both.
> 
> There is no kernel output or output from running the application (ipipe
> debugging is disabled). The board will not respond to any input from any
> interface. 
> 
> Using strace I was able to determine that the first statements in main()
> were not even reached. The strace output would generally stop on access
> to /dev/rtheap or rt_sigaction(SIGXCPU...). My suspicion was the global
> object instantiation calling rt_mutex_create().

I would suspect an issue with the fast mutexes, since they require a
shared heap to have been mapped prior to the mutex creation. But if you
say you saw the same issue on 2.4.8, it must be something completely
different. I will try and reproduce the issue ASAP.

-- 
					    Gilles.

