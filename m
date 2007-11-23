Message-ID: <2ff1a98a0711230214s5f9d4456n98912d2c6d87aea8@domain.hid>
Date: Fri, 23 Nov 2007 11:14:35 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <474566B5.4050105@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <474540B2.9050208@domain.hid>
	<2ff1a98a0711220202q66a624aufeec60d246172a75@domain.hid>
	<474566B5.4050105@domain.hid>
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
To: Theo Veenker <Theo.Veenker@domain.hid>
Cc: Xenomai <xenomai@xenomai.org>

On Nov 22, 2007 12:23 PM, Theo Veenker <Theo.Veenker@domain.hid> wrote:
> Gilles Chanteperdrix wrote:
> > On Nov 22, 2007 9:41 AM, Theo Veenker <Theo.Veenker@domain.hid> wrote:
> >> Hi,
> >>
> >> I understand in the Xenomai posix skin CLOCK_REALTIME gets initialized
> >> on startup of the system and then left alone. There is a problem if the
> >> system's hwclock is storing local time as opposed to UTC. In this case
> >> the Xenomai clock gets initialized with local time instead of UTC.
> >> I use local time in the hwclock because my systems are dual-boot with
> >> MS Windows XP and XP aparently still can't properly deal with hwclock
> >> set to UTC.
> >
> > We use do_getttimeofday at Xenomai initialization time to get the
> > system time. Do you know what we should call to get UTC time ?
>
> Well I think the call is correct, but I suspect it is done before the
> system time is initialized from the hwtimer. Or doesn't that make sense?
> On my system (Ubuntu) hwclock is called from /etc/rcS.d/S50hwclock.sh
> (rather late). It does something like /sbin/hwclock --hctosys --localtime
> (the latter option indicates hwclock is supposed to store local time).
>
> I would suggest to supply a Xenomai init.d start script which reinitializes
> the xenomai realtime clock. This should then obviously be scheduled
> after Linux has called /sbin/hwclock --hctosys.

I had a look at hwclock code, it gets the timezone from localtime
(which probably gets it from glibc's /etc/localtime) and calls
settimeofday with this timezone. sys_settimeofday sets the global
variable sys_tz with the timezone passed by hwclock.

So, if we want Xenomai to get the UTC time independently from the
timezone setting, we should take sys_tz into account.

The problem is that it will work when Xenomai is compiled as module,
since the module will probably be loaded after hwclock is called, but
with Xenomai compiled in kernel, Xenomai initlization will take place
before hwclock is called.

So, either we should provide, as you suggest, a user-space tool to be
called  in init scripts, but this mean that we have to develop an
interface (probably a driver) for this tool (using any skin would
create an unwanted dependency). Another solution is to generate an
I-pipe event when settimeofday is called, and call xnpod_settime in
this event's handler.

Philippe, what do you think ?

-- 
                                               Gilles Chanteperdrix

