Message-ID: <50980A89.7060008@xenomai.org>
Date: Mon, 05 Nov 2012 19:50:49 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5097F3BE.8070709@gmail.com>
	<5097F518.9090101@gmail.com>	<5097F882.3010509@gmail.com>
	<5097FEC9.6010603@gmail.com>
In-Reply-To: <5097FEC9.6010603@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Cross-compiling RTDM driver errors
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Stefan Videv <videvstefan@gmail.com>
Cc: xenomai@xenomai.org

On 11/05/2012 07:00 PM, Stefan Videv wrote:

> On 11/05/2012 05:33 PM, Stefan Videv wrote:
>> On 11/05/2012 05:19 PM, Stefan Videv wrote:
>>> On 11/05/2012 05:13 PM, Stefan Videv wrote:
>>>> Hi,
>>>>
>>>> I am trying to cross compile a driver that I wrote which is very 
>>>> similar to the one provided in the examples (tut02-skeleton-drv). 
>>>> I've basically changed the write function to do what I am interested 
>>>> in doing, everything else is the same (however I am not providing a 
>>>> read function).
>>>>
>>>> During compilation I get the following error:
>>>>
>>>> FATAL: modpost: GPL-incompatible module vlcTxDriver.ko uses GPL-only 
>>>> symbol 'rtdm_dev_unregister'
>>>>
>>>> What's that supposed to mean, and how do you get around it?
>>> I answered my own question just now -- I've forgotten to define the 
>>> module licence correctly. Having done that I end up with some 
>>> undefined symbols, just like when trying to compile the POSIX examples.
>>>
>>> Here's what I get:
>>>
>>> WARNING: "pse51_shm_close" [/home/stefan/VLCTxDriver/vlcTxDriver.ko] 
>>> undefined!
>>> WARNING: "munmap" [/home/stefan/VLCTxDriver/vlcTxDriver.ko] undefined!
>>> WARNING: "mmap" [/home/stefan/VLCTxDriver/vlcTxDriver.ko] undefined!
>>> WARNING: "open" [/home/stefan/VLCTxDriver/vlcTxDriver.ko] undefined!
>>>
>>> Any help is appreciated! Thanks!
>> I've somewhat answered my questions again:
>>
>> http://www.xenomai.org/pipermail/xenomai-help/2011-12/msg00014.html
>>
>> However, I still do not understand how do you go about enabling these 
>> features (i.e. what to enable when configuring my kernel). 
> I've enabled shared memory support from the POSIX options for Xenomai. 
> That takes care of the first 3 warnings.
> 
> However, I am still having the last one. I am trying to use this 
> particular open() function:
> 
> http://pubs.opengroup.org/onlinepubs/000095399/functions/open.html
> 
> to be able to write to /dev/mem


You do not write to /dev/mem in a kernel module. You use ioremap.

-- 
                                                                Gilles.

