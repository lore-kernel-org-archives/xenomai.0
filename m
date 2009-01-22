Message-ID: <4978EEDC.6040307@domain.hid>
Date: Thu, 22 Jan 2009 23:10:36 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <8e2adebc0812311008j76d745f9r539a1b9108f8903d@domain.hid>	<495BB5AE.1010805@domain.hid>	<8e2adebc0901221104y18d09bb5l3d5645f77e4f42ed@domain.hid>	<4978C5A1.4080302@domain.hid>
	<8e2adebc0901221408q3bd65bfeu29b7cfe8ce3bb05e@domain.hid>
In-Reply-To: <8e2adebc0901221408q3bd65bfeu29b7cfe8ce3bb05e@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] ARM I-pipe port to OMAP osk board
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Mandar Thite <mandarthite@domain.hid>
Cc: xenomai@xenomai.org

Mandar Thite wrote:
> Hi again,
> Platform specific code for "clock_event_device" timer initialization in
> "arch/arm/mach-omap1/time.c" is starting the timer in "autoreload mode" as
> per "HZ" value. Is this ok for functioning of I-pipe or needs a
> modification(i mean should it be started in "one shot mode")?
> Thanks. ---Mandar

Xenomai requires one shot mode.

-- 
					    Gilles.

