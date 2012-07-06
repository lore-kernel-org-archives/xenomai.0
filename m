Message-ID: <4FF708E3.9020407@xenomai.org>
Date: Fri, 06 Jul 2012 17:48:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtfz7+pRjjbE6Ev4zJNZpa45axMePyVar+3MyRyMvcp8aA@mail.gmail.com>	<CAKKWdtd6p2-xHH1FdjVzbX-raNtDkvMemALrQBJMgoTb1dScnw@mail.gmail.com>	<4FCF2751.5070700@xenomai.org>	<4FCF4D05.3070502@xenomai.org>	<4FCF58AF.5040106@xenomai.org>	<4FCF5A4C.60704@xenomai.org>	<4FCF5DED.8060007@xenomai.org>	<4FCF60CD.8000709@xenomai.org>	<4FCF6152.7010002@xenomai.org>	<4FCF62DD.10102@xenomai.org>	<4FCF68CA.8010206@xenomai.org>	<4FCF713F.1030603@xenomai.org>	<4FCF7418.4020805@xenomai.org>	<4FCF7576.8030201@xenomai.org>	<4FCF9A1E.6090706@xenomai.org>	<4FCF9AAD.7020707@xenomai.org>	<4FD1C3EE.1000005@xenomai.org>	<4FD1C50D.5010906@xenomai.org>	<4FD1C60D.401@xenomai.org>	<4FD1C67E.5010600@xenomai.org>	<4FD1C751.5070501@xenomai.org>	<CAKKWdtdebEv14pJhTvr1qc7u3zTzjCPgZZu6h8k1nnrGnpHNdw@mail.gmail.com>	<CAHue_TUHtzKZ6g1__=jB-y08TRnnZ93t2zY8+C-MAWy7QhH=Pg@mail.gmail.com>	<4FF3232E.3050605@xenomai.org>
	<CAHue_TVfw+HxX4uPOQU_j766ApjBHAOPPOzxOaXvX_p5NvR=Gw@mail.gmail.com>
In-Reply-To: <CAHue_TVfw+HxX4uPOQU_j766ApjBHAOPPOzxOaXvX_p5NvR=Gw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] xenomai-2.6.0 instrumentation commands not executing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?TWFyY2luIEt1xZtrYQ==?= <marckuska@gmail.com>
Cc: xenomai@xenomai.org

On 07/06/2012 05:42 PM, Marcin Kuśka wrote:
>>
>> You are compiling with -march=armv7-a and linking with
>> -march=armv4t, are you sure this is supposed to work?
>>
>> I guess compiling for armv7 and linking for armv4 is not supported...
>> Anyway, to understand what happens, you can do what is written,
>> look at config.log.
>>
>>
> Yes that was the problem. Many thanks!
> 
> Now i face another problem. I put the CFLAGS and LDFLAGS in busybox to
> xeno-config --skin=native --cflags and xeno-config --skin=native --cflags

You do not need to compile busybox with xenomai native skin. You only
need to compile xenomai applications with xenomai native skin flags. In
fact, as long as you do not make your own xenomai application, you do
not need to compile anything with xenomai flags. You should just install
xenomai on an otherwise normal root filesystem and try running xenomai
testsuite programs, such as "latency".

> and imported NEEDED libraries to my/rootfilesystem/path/lib and got xenomai
> error:
> 
> *Xenomai: /dev/rtheap is missing
> *
> *(chardev, major=10 minor=254)
> 
> *
> I was surprised that i have to copy those devices by myself but I did it.

You are suppposed to run make DESTDIR=/my/rootfilesystem/path install,
and everything will be installed.

> Now the problem sounds following:
> 
> *Xenomai init: open(/dev/mem): No such file or directory
> Kernel panic - not syncing: Attempted to kill init!*

That is because you have compiled busybox with xenomai flag, which is
completely useless. And if your filesystem does not have /dev/mem, it is
seriously screwed.

Seriously, is README.INSTALL so hard to understand?

-- 
					    Gilles.

