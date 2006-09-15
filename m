Message-ID: <450ABB29.9000304@domain.hid>
Date: Fri, 15 Sep 2006 09:39:37 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] invalid use of FPU in Xenomai context
References: <4509DBEB.7020707@domain.hid> <1158308720.5009.37.camel@domain.hid>
In-Reply-To: <1158308720.5009.37.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Philippe Gerum wrote:
> On Thu, 2006-09-14 at 17:47 -0500, Jeff Webb wrote:
>> I made some more progress in porting my RTLinux application, but now I'm spinning my wheels trying to track down the source of the following error:
>>
>>   "invalid use of FPU in Xenomai context at ..."
> 
> This message also gives the faulty location/symbol+offset. Where does it
> point to?

It's coming from some simple floating point operations in my application code.  The relevant code snippet is:

  print_msg(TRACE_MSG, "rt_delay_sim\n");
  print_msg(INFO_MSG, "jeff rt_delay: 1\n");
  actual_dt = sim_dt / rt_speed_factor + rt_skew_correction;
  print_msg(INFO_MSG, "jeff rt_delay: 2\n");

The kernel message output is:

  Sep 15 09:17:34 kernel: rt_delay_sim
  Sep 15 09:17:34 kernel: jeff rt_delay: 1
  Sep 15 09:17:34 kernel: invalid use of FPU in Xenomai context at [fc264152]
  Sep 15 09:17:34 kernel: Xenomai: suspending kernel thread c1ca3730 ('c1ca3730') at
  0xfc264152 after exception #7

The variables in question are doubles.  The faulty location offset is somewhere in the rt_delay_sim routine, as you would expect from the output above.  This specific code does not appear to be the problem, though.  If I remove the call to the rt_delay_sim routine, I simply get a floating point exception in another location.

The strange thing is that I can do a loop of floating point operations at the beginning of my real-time thread without any problem:

  for (i=0; i<1001; i++)
    {
      f = f * 1.0 + 0.1;
    };  
  print_msg(INFO_MSG, "f = %d\n", (int)f);

but once I get into my real application code, I get the above error after executing several floating point operations.  My 'real application code' is actually a linked list of routines that reside in other kernel modules.  I wish I could come up with a simple example that caused the same problem...  I will keep trying.

As I said before, I am porting an application that works properly under RTLinux GPL, and am making some small changes to compile with Xenomai POSIX threads/timers and RTAI FIFOs.

Thanks,

Jeff


