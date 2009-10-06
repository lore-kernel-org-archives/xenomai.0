Message-ID: <4ACB05EB.2030105@domain.hid>
Date: Tue, 06 Oct 2009 10:55:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4AC9B7CC.6020503@domain.hid>
	<11140985.42301254710355962.JavaMail.coremail@domain.hid>
	<2259155.256821254816690185.JavaMail.coremail@domain.hid>
In-Reply-To: <2259155.256821254816690185.JavaMail.coremail@domain.hid>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] unknown symbol __fixunsdfdi
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: han <hshouqian@domain.hid>, Xenomai help <xenomai@xenomai.org>

han wrote:
> 
> 在2009-10-05，"Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org> 
> 写道：
>>han wrote:
>>>     Hello everyone！
>>> I'm Porting a rtai/linux application to xenomai/linux.  Now I come across a problem：
>>> when I compile the kernel module of my program，I find a WARNING,
>>>                     WARNING：“__fixunsdfdi”[freqmod.ko] undefined！
>>> after compiling，I  insmod the module xeno_native.ko，
>>> then insmod my kernel module freqmod.ko，then I come across an error：
>>>             insmod:error inserting 'freqmod.ko':-1 Unknown symbol in module
>>>     dmesg，it tells me: 
>>>                      unknown symbol __fixunsdfdi。
>>>  
>>>    Before being portted to xenomai/linux (linux-2.6.24,xenomai-2.4.3,gcc
> -4.1.1)，
>>> it run ok in rtai/linux （linux-2.6.24，rtai-3.7，gcc-4.1.1），
>>> and I only transport the RTAI API to Xeno's native API. So what's wrong?  I'm looking forward to your answers! 
>>>      Thank you very much !
>>
>>You are using FPU in kernel-space. It is bad. If you really want to do
>>that, you should import that function from the static libgcc.
>>
>>-- 
>>                                          Gilles
>>
>     Thank you very much for your reply!
>     Yes, I'm using some math functions in my kernel module, because my program was based on rtai/linux before. I have tried to port rtai_math.ko to xenomai/linux,
>  and I have tested the math.ko from rtai in xenomai/linux，
> it can work well. That is to say : when I compile a test kernel module, there is no WARNING and error；
> but when I compile my program, the WARNING and error arise. Why? Do I need  import those functions from the static libgcc? and the math.ko module from rtai can't be used in xenomai/linux?  
>      Thank you for your concern！

Listen, either you know what you are doing and you should not need my
help. Or you do not know, and in that case you should listen to what we
tell you: stop using FPU in kernel-space.

Please stop sending me private mails.

-- 
                                          Gilles


