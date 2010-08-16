Message-ID: <4C6941B2.6030105@domain.hid>
Date: Mon, 16 Aug 2010 15:48:34 +0200
From: Theo Veenker <T.J.G.Veenker@domain.hid>
MIME-Version: 1.0
References: <4C45539B.70204@domain.hid> <4C45770F.10302@domain.hid>
	<4C458607.1060402@domain.hid> <4C45869D.9020501@domain.hid>
	<4C45CF88.20608@domain.hid> <4C691F66.7070802@domain.hid>
	<4C692359.5080802@domain.hid>
In-Reply-To: <4C692359.5080802@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] kernel 2.6.32.11 with xenomai 2.5.3 fails to
 boot on ubuntu lucid system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Theo Veenker wrote:
>> Theo Veenker wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Theo Veenker wrote:
>>>>> Stefan Kisdaroczi wrote:
>>>>>> On 20.07.2010 09:43, Theo Veenker wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> I want to upgrade all our PC's from Ubuntu hardy to lucid and in 
>>>>>>> the process
>>>>>>> I'm also going from kernel 2.6.29.5 with Xenomai 2.4.8 to kernel 
>>>>>>> 2.6.32.11
>>>>>>> with Xenomai 2.5.3.
>>>>>>>
>>>>>>> I first built and tested the 2.6.32.11 kernel with 2.5.3 on my 
>>>>>>> hardy system
>>>>>>> and all went fine. But the problem is it just doesn't run on the 
>>>>>>> lucid distro.
>>>>>>> However the vanilla kernel runs fine. I also tried with a config 
>>>>>>> based on the
>>>>>>> ubuntu lucid config, with relevant modules compiled in (I don't use 
>>>>>>> initrd).
>>>>>>>   
>>>>>> Are you sure it's not initrd related ?
>>>>>>
>>>>>> After installing the kernel with dpkg --install i had to run
>>>>>> '# update-initramfs -c -k all' and '# update-grub' manually.
>>>>>> This is not necessary on debian lenny/squeeze and worked
>>>>>> (if I remember correctly) with ubuntu karmic too.
>>>>>> Check in your grub config if there is a initrd entry.
>>>>> Unfortunately this doesn't make a difference. Created initrd for 
>>>>> regular and
>>>>> kernel with xenomai; grub config OK. But still the regular kernel 
>>>>> works and
>>>>> the other one gives me just a black screen.
>>>> Have you tried removing "quiet" from the kernel command line?
>>> Yes I always do. It somehow hangs before outputting anything. In the 
>>> meantime
>>> I have recompiled again with BLK_DEV_INITRD set and running 
>>> update-initramfs etc
>>> as Stefan suggested. No effect. When I install this kernel on an Ubuntu 
>>> hardy
>>> system it works as expected; on Ubuntu lucid it does not. Could it be 
>>> due to
>>> this plymouth crap?
>> (back from holliday) I really like to get my kernel working. I just compiled
>> a kernel 2.6.32.11 with lots of stuff (sound etc) disabled. The regular kernel
>> works fine, with adeos-ipipe-2.6.32.11-x86-2.6-03.patch patch applied it does
>> not work for Ubuntu 10.04 distro (blank screen) but *does work* for Ubuntu 8.04.
>> What could be the cause of this weird problem? It must be something very early
>> in the boot process that's different between the distro versions that makes the
>> kernel work in one environment and not in the other.
>>
>> I'm posting my latest config in the hope someone sees that I screwed up
>> something there.
> 
> It is difficult to know what is going on without being able to reproduce
> this issue. However, a few suggestions:
> - you have several consoles enabled, including the "dummy" console,
> please try and only enable the one you want output from, or use the
> kernel parameter "console", for instance console=ttyS0,115200 if you
> want output on the serial port;

It seems impossible to disable the dummy console from the config gui.
I finally found a dumb terminal that actually works so I'm now going to
test the console= kernel param.

> - have you tried Xenomai 2.5.4 and the Adeos patches it contains?

Yes, that's what I'm working with.

Theo

