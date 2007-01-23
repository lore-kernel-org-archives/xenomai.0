From: Jeff Weber <jweber@domain.hid>
Subject: Re: [Xenomai-help] isolating unwanted mode switch
Date: Tue, 23 Jan 2007 16:27:51 -0600
References: <200701231448.35285.jweber@domain.hid>
	<b647ffbd0701231345n33a7ecafm879ca25bdedab2fe@domain.hid>
In-Reply-To: <b647ffbd0701231345n33a7ecafm879ca25bdedab2fe@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701231627.51851.jweber@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Dimitry:

On Tuesday 23 January 2007 15:45, Dmitry Adamushko wrote:
> > Are there other events (not system calls) that initiate a switch to
> > secondary mode?
>
> exceptions (CPU exceptions, e.g. page faults). I presume, you have
> done mlockall(CURRENT | FUTURE), haven't you?
Yes.  my Linux application follows this this model:

main () {
	 mlockall(MCL_CURRENT | MCL_FUTURE);
	rt_task_shadow( ... )  // become a realtime thread

	// for N threads:
		rt_task_spawn( ... ) // fork off child RT thread
}

It is one of the child RT threads that encounters the SIGXCPU unwanted mode 
switch.  It this the correct way to call mlockall() ?

>
> As a starting point, take a look at what /proc/xenomai/faults provides.
Aha!  All faults are 0 expect for:
TRAP         CPU0
 ...
 14:          331    (Page fault)
...

So indeed I have an error in how I call mlockall().  (and I do error check the 
return value in main() ).

>
> Moreover, enable "Nucleus debugging support" in your kernel config. If
> it's an exception indeed, you would see a message like :
Will do.  I always stayed away from enabling XENO_OPT_DEBUG in the past 
because of the associated "scary" warning:
	"... Do not switch this option on unless you really know what you
        are doing."

While I was reconfiguring my kernel, I came across the related config:
XENO_OPT_DEBUG_QUEUES, which has even "scarier" warning:
	"... It adds even more runtime
        overhead then CONFIG_XENO_OPT_DEBUG, use with care."

Is the  XENO_OPT_DEBUG_QUEUES option safe and useful to enable too?

	thanks,
	Jeff

