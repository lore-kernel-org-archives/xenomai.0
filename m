MIME-Version: 1.0
In-Reply-To: <20150402191555.GK31175@hermes.click-hack.org>
References: <54F07AC2.6000902@triphase.com> <54F0D46F.1070006@siemens.com>
 <54F56C9C.6080507@siemens.com>
 <CAPRPZsC9mPitPUmXXR6QQfAGN3UMa2u6hkVwjtO4Eoh-NzC7wA@mail.gmail.com>
 <54FDB495.3060303@triphase.com> <5501FC89.2040205@siemens.com>
 <20150313163431.GE1497@hermes.click-hack.org>
 <550319B3.1050902@siemens.com>
 <20150313171211.GH1497@hermes.click-hack.org>
 <CAPRPZsD4503Yc92d=e0jqR8HtLiV8rXo_vA2e5ea5V_gyCTOzA@mail.gmail.com>
 <20150402191555.GK31175@hermes.click-hack.org>
Date: Thu, 2 Apr 2015 21:29:29 +0200
Message-ID: <CAPRPZsCcAQCYNbVXzB5yW+hNzhLcrDLETDteFLgDLnuzz6RCsA@mail.gmail.com>
From: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] xeno3_rc3 - Watchdog detected hard LOCKUP
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

2015-04-02 21:15 GMT+02:00 Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org>:
> On Thu, Apr 02, 2015 at 08:47:30PM +0200, Jeroen Van den Keybus wrote:
>> I've been testing for two weeks now and the system has crashed three
>> more times under dohell load. Two with 3.14.28, the other with 3.16.0.
>> Time to crash varied between 3 hours and 90 hours.
>>
>> The scenario is always the same: one CPU (has already been any of the
>> 4) gets stuck and the others start reporting soft lockups. The trouble
>> is: I've been unable to get hold of a stack trace of the hardlocked
>> CPU. SysRq L does not work and the CPU does not respond to the NMIs it
>> is given from the softlocked CPUs. I also enabled hardlockup_panic to
>> make sure I get all stack traces but to no avail.
>>
>> Does anyone know another trick to possibly get the backtrace from this CPU ?
>

> You can modify ipipe_trace_freeze to get the trace of a different
> CPU.

Ah yes, I forgot. It is probably locked outside the Linux domain. That
would explain why the regular panic won't work. Is that correct ?

> But if I were you I would test the latest stable release
> first.

Ok. I'll do that. I would have liked to know the cause of the lockups
though, And above all, we wanted to test Xenomai 3 from the start of a
new project.

Thanks

J.

>
> --
>                                             Gilles.

