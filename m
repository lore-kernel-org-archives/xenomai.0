Message-ID: <4C45CF88.20608@domain.hid>
Date: Tue, 20 Jul 2010 18:32:08 +0200
From: Theo Veenker <T.J.G.Veenker@domain.hid>
MIME-Version: 1.0
References: <4C45539B.70204@domain.hid> <4C45770F.10302@domain.hid>
	<4C458607.1060402@domain.hid> <4C45869D.9020501@domain.hid>
In-Reply-To: <4C45869D.9020501@domain.hid>
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
>> Stefan Kisdaroczi wrote:
>>> On 20.07.2010 09:43, Theo Veenker wrote:
>>>> Hi,
>>>>
>>>> I want to upgrade all our PC's from Ubuntu hardy to lucid and in the process
>>>> I'm also going from kernel 2.6.29.5 with Xenomai 2.4.8 to kernel 2.6.32.11
>>>> with Xenomai 2.5.3.
>>>>
>>>> I first built and tested the 2.6.32.11 kernel with 2.5.3 on my hardy system
>>>> and all went fine. But the problem is it just doesn't run on the lucid distro.
>>>> However the vanilla kernel runs fine. I also tried with a config based on the
>>>> ubuntu lucid config, with relevant modules compiled in (I don't use initrd).
>>>>   
>>> Are you sure it's not initrd related ?
>>>
>>> After installing the kernel with dpkg --install i had to run
>>> '# update-initramfs -c -k all' and '# update-grub' manually.
>>> This is not necessary on debian lenny/squeeze and worked
>>> (if I remember correctly) with ubuntu karmic too.
>>> Check in your grub config if there is a initrd entry.
>> Unfortunately this doesn't make a difference. Created initrd for regular and
>> kernel with xenomai; grub config OK. But still the regular kernel works and
>> the other one gives me just a black screen.
> 
> Have you tried removing "quiet" from the kernel command line?

Yes I always do. It somehow hangs before outputting anything. In the meantime
I have recompiled again with BLK_DEV_INITRD set and running update-initramfs etc
as Stefan suggested. No effect. When I install this kernel on an Ubuntu hardy
system it works as expected; on Ubuntu lucid it does not. Could it be due to
this plymouth crap?

Theo




