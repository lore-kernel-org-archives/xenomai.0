References: <20160831013955.4B7092A08D5@webmail.sinamail.sina.com.cn>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <df739cab-251a-63be-f0a2-543b9c6a2055@xenomai.org>
Date: Thu, 1 Sep 2016 09:33:01 +0200
MIME-Version: 1.0
In-Reply-To: <20160831013955.4B7092A08D5@webmail.sinamail.sina.com.cn>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] overruns with Celeron J1900
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: wangyuchi1017@sina.com, xenomai <xenomai@xenomai.org>

On 08/31/2016 03:39 AM, wangyuchi1017@sina.com wrote:
>> ----- Original Message -----
>> From: Philippe Gerum <rpm@xenomai.org>
>> To: wangyuchi1017@sina.com, xenomai <xenomai@xenomai.org>
>> Subject: Re: [Xenomai] overruns with Celeron J1900
>> Date: 2016-08-26 22:41
> 
> 
>> On 08/26/2016 03:47 AM, wangyuchi1017@sina.com wrote:
>>>  Hello, everyone!  I am setting up a real-time platform using the Advantech MIO-5251 board which uses the intel Celeron J1900 CPU. It's details can be found at http://www.advantech.com/products/bc6786b7-b69b-4fdd-9b63-79180dbd5dcb/mio-
>> 5251/mod_ff8534cc-e858-40ba-9bc2-386f19bfee4a. It's quite powerful. I use Linux-4.1.18, Xenomai-3.0.2 and Lubuntu 16.04. Kernel command line "xenomai.smi=enabled" was added, but when I run the latency -t0 (-t1, -t2) test, overruns occurred.
>>>   .config, dmesg files are pasted below. Can anyone give me some help?
>> Please do not inline config file contents, especially without line
>> terminators. It is better to attach it only when asked to.
>> The kernel log is barely readable also due to the lack of line
>> terminators. Please resend properly.
>> Some fragment of the latency program output is missing too; this
>> information is required to better understand the issue.
>> It looks like the SMI workaround was successfully enabled for your
>> chipset, which does not mean all offending SMI sources have been shut
>> though. Sometimes one may just be unlucky, due to vendor BIOS woes.
>> However, CONFIG_PERF_EVENTS using NMI-based sampling is clearly an issue
>> on Intel, due to sluggish ACPI lookups and/or PMU management from the
>> NMI handler. You may want to try disabling this feature to make sure, or
>> alternatively disabling the NMI event before testing, with:
>> # echo 0 > /proc/sys/kernel/nmi_watchdog
>> -- 
>> Philippe.
> 
>   Sorry for the line terminators and appreciated for your patience. It was caused by different codes of the line
> terminator between HTML formats and normal text. Another stupid question: How to add the '>' symbol automatically? 
> I used the web editor of mailbox, and I didnot find configurations like this.

Your MUA should add these markers automatically when replying to a mail
for quoting the comments being replied to. You may want to check with
the documentation of your MUA, and use its e-mail Reply feature.

> 
>   I found that CONFIG_PERF_EVENTS in the .config is 'y', and I disabled the NMI event using 
> #echo 0 > /proc/sys/kernel/nmi_watchdog
> overruns remain during the latency -t0 (-t1, -t2) test. Below is the results. (config, dmesg and overruns are attached)
> 
> RTT|  13:35:31  (periodic user-mode task, 100 us period, priority 99)
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat
best|--lat worst
> RTD|      0.334|      1.454|      4.444|       7|     0|     -0.016|
 117.837

The latency figures are still ugly, I would not expect more than 30-35
us on this class of hardware.

Another source of latency could be brought in by the graphics support.
To determine this, you may want to boot your system in text mode, or
switch to a text VT before running the latency test.

To pinpoint the latency spot, obtaining a detailed trace is required. To
this end, you will need to build your kernel with the CONFIG_IPIPE_TRACE
option enabled, then run the latency program with the -f option. More
information is available here:
http://xenomai.org/2014/06/using-the-i-pipe-tracer/

-- 
Philippe.

