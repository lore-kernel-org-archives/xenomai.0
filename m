Message-ID: <4BA8F732.10206@domain.hid>
Date: Tue, 23 Mar 2010 18:15:30 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4BA39C3D.1040802@domain.hid>
	<4BA4EF75.7010202@domain.hid>	<4BA74820.2090401@domain.hid>
	<4BA8752E.8090407@domain.hid>	<4BA8C15E.5050707@domain.hid>
	<4BA8F517.3060705@domain.hid>
In-Reply-To: <4BA8F517.3060705@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] crash after termination
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Jan Kiszka wrote:
> Stefan Kisdaroczi wrote:
>> Hi Jan,
>>
>> Only user space using the native skin. Some additional notes:
>> I'm using the freepascal compiler and link against libnative, i dont use gcc.
>> There is one process starting the other ten processes using fork() & execl().
>> The tasks do a lot of mode switching between primary/secondary.
>> The stacksize for the tasks is 1MB. We only use between 4K-16K of stack in our
>> applications. So there should be still a bit less than 1 MB for socket calls
>> and printf, is this to low ?
> 
> Also stack overflows must not crash the kernel, they may only cause
> application crashes.
> 
>> I rebuilt the kernel without arcnet and isdn and disabled smp too, using 2.5.1.
>> It still crashes every time on termination. If I pull the network connector,
>> I could start and shutdown the applications 5 times without problem. If the
>> network is connected, as soon as there is some network activity like ssh/samba
>> on termination the box crashes. Sometimes it gets even back to the prompt before
>> crashing. Its a rtl8139 network card, but happens in a virtualbox-vm with a pcnet
>> card too. In the traces is always a "do_IRQ+0x...", so I think the problem is
>> related to IRQ-handling.
> 
> That sounds promising! If you can provide your test case to us (or me
> privately), we could try to reproduce - inside a proper hypervisor which
> has proper debugging facilities. :)

I do not know if this could be related, but you have two drivers we 8139
in their name. Could there be a conflict?

-- 
					    Gilles.

