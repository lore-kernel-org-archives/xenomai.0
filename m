Message-ID: <474566B5.4050105@domain.hid>
Date: Thu, 22 Nov 2007 12:23:33 +0100
From: Theo Veenker <Theo.Veenker@domain.hid>
MIME-Version: 1.0
References: <474540B2.9050208@domain.hid>
	<2ff1a98a0711220202q66a624aufeec60d246172a75@domain.hid>
In-Reply-To: <2ff1a98a0711220202q66a624aufeec60d246172a75@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] CLOCK_REALTIME initialization
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
Cc: Xenomai <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> On Nov 22, 2007 9:41 AM, Theo Veenker <Theo.Veenker@domain.hid> wrote:
>> Hi,
>>
>> I understand in the Xenomai posix skin CLOCK_REALTIME gets initialized
>> on startup of the system and then left alone. There is a problem if the
>> system's hwclock is storing local time as opposed to UTC. In this case
>> the Xenomai clock gets initialized with local time instead of UTC.
>> I use local time in the hwclock because my systems are dual-boot with
>> MS Windows XP and XP aparently still can't properly deal with hwclock
>> set to UTC.
> 
> We use do_getttimeofday at Xenomai initialization time to get the
> system time. Do you know what we should call to get UTC time ?

Well I think the call is correct, but I suspect it is done before the
system time is initialized from the hwtimer. Or doesn't that make sense?
On my system (Ubuntu) hwclock is called from /etc/rcS.d/S50hwclock.sh
(rather late). It does something like /sbin/hwclock --hctosys --localtime
(the latter option indicates hwclock is supposed to store local time).

I would suggest to supply a Xenomai init.d start script which reinitializes
the xenomai realtime clock. This should then obviously be scheduled
after Linux has called /sbin/hwclock --hctosys.

> 
>> What I would like to do is tell Xenomai to reinitialize CLOCK_REALTIME
>> at some point *after* Linux has initialized its own clock from the
>> hwclock. As clock_settime() isn't yet supported (in 2.3) I can't do
>> this now. Will it be in 2.5, or is there at present another way of
>> reinitializing CLOCK_REALTIME?
> 
> Yes, it is in 2.4.
> 

Thanks.

Theo


