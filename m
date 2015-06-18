Message-ID: <4ac010f0fd16906e5c7741c8c16faa25.squirrel@sourcetrek.com>
In-Reply-To: <CANprwBMXsCVdx0qup4e=weJpWW8WZtP2TfZSiT58MhRODSpNsQ@mail.gmail.com>
References: <CANprwBMXsCVdx0qup4e=weJpWW8WZtP2TfZSiT58MhRODSpNsQ@mail.gmail.com>
Date: Thu, 18 Jun 2015 15:39:12 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] RTcfg module waits forever after "rtcfg rteth0
 server" has been called
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: fre go <fgosew@gmail.com>
Cc: xenomai@xenomai.org


fre go wrote:
> I'm currently working with Xenomai 3 (first rc4, now git head) with Kernel
> 3.16.7 and encountered a problem with both versions concerning rtnet: When
> I try to start rtnet with "rtnet start" the call stalls and sometimes even
> locks the kernel.

Yes, it has been reported already, rtcfg is broken in rtnet over xeno 3.

> I could trace this back to the "rtcfg rteth0 server" and
> further investigation via kgdb debugging via virtual machine showed that
> the call to "rtdm_event_signal" in rtnet_rtpc.c seems to be not answered.

As is usual with debug tools what you see here is a symptom of the
problem, not the problem itself. If you want to solve this, you need to
dig deeper and understand the code. A debug tool can not do that for you.

> Although the kernel should be waiting interruptible most of the time
> ctrl+c
> does nothing. Sometimes it does what it's supposed to (interrupt) but
> after
> another call to "rtnet start" the kernel often fails with a oops or even a
> panic). Could it be the kernel which fails here and not xenomai? I'm
> currently out of ideas how to tackle this problem on my own. Maybe
> somebody
> could point me into the right direction.

It is probably not Xenomai, but rather the port of rtnet it contains.

>
> My dev machine is running on KVM and it as been tested with xenomai 2.6.4
> and RTnet 0.9.13 git head, both with different nics (e1000, rtl8139) so I
> can rule out possible KVM or Qemu issues.

I do not understand. Does it work or does it no with 2.6? I guess it does.


-- 
                                            Gilles.
https://click-hack.org


