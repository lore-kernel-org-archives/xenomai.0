Message-ID: <4AC9B7CC.6020503@domain.hid>
Date: Mon, 05 Oct 2009 11:09:32 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <11140985.42301254710355962.JavaMail.coremail@domain.hid>
In-Reply-To: <11140985.42301254710355962.JavaMail.coremail@domain.hid>
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
To: han <hshouqian@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

han wrote:
>     Hello everyone！
> I'm Porting a rtai/linux application to xenomai/linux.  Now I come across a problem：
> when I compile the kernel module of my program，I find a WARNING,
>                     WARNING：“__fixunsdfdi”[freqmod.ko] undefined！
> after compiling，I  insmod the module xeno_native.ko，
> then insmod my kernel module freqmod.ko，then I come across an error：
>             insmod:error inserting 'freqmod.ko':-1 Unknown symbol in module
>     dmesg，it tells me: 
>                      unknown symbol __fixunsdfdi。
>  
>    Before being portted to xenomai/linux (linux-2.6.24,xenomai-2.4.3,gcc-4.1.1)，
> it run ok in rtai/linux （linux-2.6.24，rtai-3.7，gcc-4.1.1），
> and I only transport the RTAI API to Xeno's native API. So what's wrong?  I'm looking forward to your answers! 
>      Thank you very much !

You are using FPU in kernel-space. It is bad. If you really want to do
that, you should import that function from the static libgcc.

-- 
                                          Gilles


