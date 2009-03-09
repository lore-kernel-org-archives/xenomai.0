Message-ID: <49B54BB7.5040705@domain.hid>
Date: Mon, 09 Mar 2009 18:02:47 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1236608449.3587.32.camel@domain.hid>	
	<49B53EE4.1030008@domain.hid> <1236616652.3531.57.camel@domain.hid>
In-Reply-To: <1236616652.3531.57.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] rt_queue_create in RT task?
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Andreas Glatz <andreasglatz@domain.hid>
Cc: xenomai@xenomai.org

Andreas Glatz wrote:
> Hi,
> 
> On Mon, 2009-03-09 at 17:08 +0100, Philippe Gerum wrote:
>> Andreas Glatz wrote:
>>> Hi,
>>>
>>> Calling rt_queue_create in a real-time task is supposed to fail
>>> according to the documentation. 
>>>
>> It fails from kernel space, otherwise, from user-space, your application would 
>> simply be moved to a Linux context automatically for processing the 
>> rt_queue_create() syscall.
> 
> Currently, we are developing in Userspace, so everything works fine. But
> we still would like to have the option to run in kernel-space if for
> some reason the user-space performance is too poor. 
>

Could you elaborate a bit about this? What was bad, latency? If so, what is your 
target arch/platform, and which typical latency do you require?

-- 
Philippe.

