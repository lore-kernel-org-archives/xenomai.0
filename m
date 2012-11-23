Message-ID: <50AF2340.5020501@gmail.com>
Date: Fri, 23 Nov 2012 08:18:24 +0100
From: Stefan Roese <stefan.roese@gmail.com>
MIME-Version: 1.0
References: <1353481805-28850-1-git-send-email-stefan.roese@gmail.com>
	<50AC8FAA.8000703@web.de> <50AC9E6D.3060203@gmail.com>
	<50AE83D1.8000402@web.de>
In-Reply-To: <50AE83D1.8000402@web.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH v2] mpc5200: Add RTDM LPBFIFO driver and demo
 RTDM FPGA device driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: xenomai@xenomai.org

Hi Jan,

On 11/22/2012 08:58 PM, Jan Kiszka wrote:

<big snip>

>>>> @@ -0,0 +1,35 @@
>>>> +/*
>>>> + *  Xenomai RTDM device driver for A3M071 FPGA with interrupt support
>>>
>>> Does this driver depend on a specific programming of that FPGA?
>>
>> Yes. As mentioned in the commit text, this is a specific custom design
>> with a "specific" FPGA image. Not really usable for most Xenomai
>> developers/users as is. But I think it might be a good example on how to
>> implement such a thing. And implementing the RT DMA framework for the
>> MPC5200.
> 
> So, basically no one will be able to run your special test case. 

That is not entirely correct. This driver will run on the board with
this special FPGA of course (a3m071, mpc5200 based). Linux mainline
support is also pending for it (will most likely hit v3.8).

> Is
> there any other use case, even an artificial one, for DMA on the MPC5200
> that can be run without the special FPGA setup? Otherwise, it might be
> more helpful to provide a very basic example for the RT DMA API usage as
> pseudo code.

I always find a real-world example better than "pseudo code". Even if it
can't be used as-is in the most systems. Such a real-world RTDM device
driver is proven to be working (not only compile tested).

Anyways, I'm going to send a new patch version today. You (and/or
others) may decide if its worth adding this driver in the xenomai code
base. Again, it has often proven to be good to include special cases
from my point of view. Others can only benefit from it.

Thanks,
Stefan



