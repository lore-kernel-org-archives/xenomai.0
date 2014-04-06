Message-Id: <50C4037C-3A2F-4357-97CB-1F114385D922@gmail.com>
From: Andreas Glatz <andi.glatz@gmail.com>
In-Reply-To: <534178AC.3090905@xenomai.org>
Mime-Version: 1.0 (Apple Message framework v936)
Date: Sun, 6 Apr 2014 17:02:05 +0100
References: <CAKJ14NdsfwK4Vj=UpYb6p9bvFE=1ZoQb6ss--9f-WqXOXGDn2g@mail.gmail.com>
 <52CAEA4D.1020505@xenomai.org>
 <6FD43B5D-6C35-48E7-BC3C-1414A0B809C9@gmail.com>
 <533E8D1F.7040405@xenomai.org>
 <F7F39021-A6D9-433D-B8F9-917C44A4B6B8@gmail.com>
 <534178AC.3090905@xenomai.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Subject: Re: [Xenomai] Command line freeze during xeno-regression-test on
	omap4460
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org


On 6 Apr 2014, at 16:54, Gilles Chanteperdrix wrote:

> On 04/06/2014 01:21 PM, Andreas Glatz wrote:
>> First i mounted tmpfs on /tmp so I don't wear out the SD card too  
>> much:
>> mount -t tmpfs -osize=192M tmpfs /tmp
>>
>> Then I used the following line to start the test (substitute MYTEST
>> below with the following line):
>> /usr/lib/xenomai/testsuite/dohell -m /tmp -l /opt/ltp
>>
>> Note: I always monitored the test over wifi with 'top' so I also had
>> some network load...
>>
>> I got the following results with the 3.10.34 kernel, which includes
>> everything up to the current ipipe-3.10 tag (it also included the
>> patch you mentioned):
>>
>> - xeno-regression-test "MYTEST" -> FAIL if booted from SD card (see
>> description above); OK if booted from ext USB HD _AND_ no mmc
>> partitions mounted
>> - CONFIG_IPIPE && CONFIG_XENOMAI && MYTEST -> FAIL (got status LED 2
>> constantly on as described above)
>> - CONFIG_IPIPE && MYTEST -> OK (see attached config file and ltp test
>> log)
>
> Of course, I assume you used the exact same kernel configuration, the
> only difference being CONFIG_XENOMAI in the two cases, right?

Yes! I just went into menuconfig and disabled CONFIG_XENOMAI, rebuilt  
it, installed it and rebooted. I'm now recompiling the kernel with the  
last config I sent you and the changes I attached (i got all those  
changes after enabling CONFIG_XENOMAI and your CONFIG_* changes with  
make menuconfig). After everything is built, I'll install it and  
repeat running 'MYTEST' without 'xeno-regression-test'.

A.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: config.diff
Type: application/octet-stream
Size: 5246 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140406/1ac7eef7/attachment.obj>
-------------- next part --------------

