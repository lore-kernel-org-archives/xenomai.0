Message-ID: <2ff1a98a0711220202q66a624aufeec60d246172a75@domain.hid>
Date: Thu, 22 Nov 2007 11:02:27 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <474540B2.9050208@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <474540B2.9050208@domain.hid>
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

On Nov 22, 2007 9:41 AM, Theo Veenker <Theo.Veenker@domain.hid> wrote:
> Hi,
>
> I understand in the Xenomai posix skin CLOCK_REALTIME gets initialized
> on startup of the system and then left alone. There is a problem if the
> system's hwclock is storing local time as opposed to UTC. In this case
> the Xenomai clock gets initialized with local time instead of UTC.
> I use local time in the hwclock because my systems are dual-boot with
> MS Windows XP and XP aparently still can't properly deal with hwclock
> set to UTC.

We use do_getttimeofday at Xenomai initialization time to get the
system time. Do you know what we should call to get UTC time ?

>
> What I would like to do is tell Xenomai to reinitialize CLOCK_REALTIME
> at some point *after* Linux has initialized its own clock from the
> hwclock. As clock_settime() isn't yet supported (in 2.3) I can't do
> this now. Will it be in 2.5, or is there at present another way of
> reinitializing CLOCK_REALTIME?

Yes, it is in 2.4.

-- 
                                               Gilles Chanteperdrix

