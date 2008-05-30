Message-ID: <2ff1a98a0805300708l6911837r7b89925ca6810792@domain.hid>
Date: Fri, 30 May 2008 16:08:08 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <13639.81.252.86.91.1212153659.squirrel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <16474.81.252.86.91.1211199249.squirrel@domain.hid>
	<2405.81.252.86.91.1211549465.squirrel@domain.hid>
	<2ff1a98a0805230655j35009227h75c63566373ece43@domain.hid>
	<5871.81.252.86.91.1211789666.squirrel@domain.hid>
	<18491.29266.196753.611570@domain.hid>
	<2766.81.252.86.91.1211992159.squirrel@domain.hid>
	<2ff1a98a0805280931j611ae10er69b968ae8699d63d@domain.hid>
	<16273.81.252.86.91.1212060383.squirrel@domain.hid>
	<2ff1a98a0805290614w3d846e6by69b033204f912391@domain.hid>
	<13639.81.252.86.91.1212153659.squirrel@domain.hid>
Subject: Re: [Xenomai-help] Problem with time-out ends
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fabien MAHOT <fabien.mahot@domain.hid>
Cc: xenomai@xenomai.org

On Fri, May 30, 2008 at 3:20 PM, Fabien MAHOT
<fabien.mahot@domain.hid> wrote:
>> On Thu, May 29, 2008 at 1:26 PM, Fabien MAHOT
>> <fabien.mahot@domain.hid> wrote:
>>> I succeed to reduce my test program.
>>> Now, I ve got two xenomai threads.
>>> threadDisplay (prio : 70) : locks a mutex (conflict_lock mutex) and
>>> passes
>>> between Xenomai and Linux domain. (call to sleep())
>>> threadTimeOut (prio : 80) : Starts one timeout of 5ms and tries to lock
>>> the mutex taken by threadDisplay. (Priority Inheritance)
>>>
>>> threadTimeOut waits the conflict_lock unlock of threadDisplay. With
>>> priority inheritance, threadTimeOut gives its priority to threadDisplay.
>>> But, threadTimeOut must also do the EndTimeOut() processing. When the
>>> timeout end signal arrives, if threadDisplay is into Linux Domain, the
>>> system crashes.
>>
>> Do you have the same crash if you use vanilla Linux timer services
>> (__real_timer_create, __real_timer_settime, etc...).
>>
>> --
>>  Gilles
>
> Hello,
>
> I try with vanilla linux timer. If threadTimeOut sets up one or two
> timeouts, now, it's ok. But if it sets up more than two timeouts, the
> system crashes.
> I ve got the same error kernel traces as Posix timer use.
>
> (By the way, In which file vanilla timer services are written ?
> __real_timer_create ... are declared in time.h in xenomai files. I look
> for in linux and glibc sources but I don t find them.)

Read explanation of the --wrap option in ld documentation.


-- 
 Gilles

