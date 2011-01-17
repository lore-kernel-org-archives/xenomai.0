Message-ID: <4D3460A7.2080109@domain.hid>
Date: Mon, 17 Jan 2011 16:30:47 +0100
From: Wong Sheng Chao <wong@domain.hid>
MIME-Version: 1.0
References: <4D31B6C3.5060007@domain.hid> <4D3227DA.9080909@domain.hid>
	<4D342298.8090603@domain.hid> <4D344563.6060506@domain.hid>
In-Reply-To: <4D344563.6060506@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Question on periodic task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org


You can try booting in text mode, and set the vga mode to have a lot of
lines, then run the test in text mode, to at least see if the reason of
the freeze you observe is a kernel oops.

I tried booting it in text mode and the program still freezes after i 
execute the user-space program. There were no error messages.

If you do not see anything, then enable all the I-pipe and Xenomai
debugs, and try again.

How do I enable I-pipe and Xenomai debugs? Do I need to set these 
options during kernel configuration time? Will enabling I-pipe let me 
know if it's a kernel-oops?

Thanks again for your help!

Regards
Wong



On 01/17/2011 02:34 PM, Gilles Chanteperdrix wrote:
> Wong Sheng Chao wrote:
>> On 01/16/2011 12:03 AM, Gilles Chanteperdrix wrote:
>>> Wong Sheng Chao wrote:
>>>> Hi
>>>>
>>>> I'm a newbie in real time programming and I recently came to know of
>>>> Xenomai. After patching the Xenomai to the linux kernel, I ran some
>>>> examples that I found from the Internet to get a better understanding of
>>>> the periodic task. Everything seems to run fine when I start two tasks
>>>> with period of 1s and 2s, but the system freezes when I added more tasks
>>>> ( more than 2 tasks). The period is at 1s, 2s and 3s so i think the
>>>> processor has more than enough time to process the tasks.
>>>>
>>>> I also read that the periodic mode is emulated by a software driver
>>>> which uses one-shot mode programming. Thus i did not enable periodic
>>>> timing when I compile the Linux kernel, is this the cause of the problem?
>>>>
>>>> I'm using a system with Core i7, ubuntu 10.04, linux kernel 2.6.32.15,
>>>> xenomai 2.5.4
>>>>
>>>> Do let me know what I did wrong in the code, thanks in advance!!
>>> You almost send us all the information we ask on this page:
>>> http://www.xenomai.org/index.php/Request_for_information
>>>
>>> We lack:
>>> - the version of the Adeos patch you use
>>> - the kernel logs from the boot up to the bug itself.
>>>
>> - the version of the Adeos patch you use
>>
>> I'm using the Adeos patch 2.6.32.15-x86-2.7-01.patch
>>
>> - the kernel logs from the boot up to the bug itself.
>>
>> I was not sure how to do this, so I google online and it seems that
>> there are two ways of doing this, through serial port or ethernet.
>> However I have only one linux system setup. Any suggestion on how I can
>> provide the kernel logs?
>>
>> After the kernel freezes, I reboot the system and went to /var/log to
>> check the kern.log file at the time of the bug, but no logs were made on
>> that particular time, is netconsole or serial port the only method of
>> troubleshooting?
> You can try booting in text mode, and set the vga mode to have a lot of
> lines, then run the test in text mode, to at least see if the reason of
> the freeze you observe is a kernel oops.
>
> If you do not see anything, then enable all the I-pipe and Xenomai
> debugs, and try again.
>


