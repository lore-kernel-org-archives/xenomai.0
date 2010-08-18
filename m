Message-ID: <4C6C0851.9000804@domain.hid>
Date: Wed, 18 Aug 2010 18:20:33 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <6FCCA913376DD7488F4139A4D11B8F4801465AC9@domain.hid>
In-Reply-To: <6FCCA913376DD7488F4139A4D11B8F4801465AC9@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RTDM task blocks when connecting gdb to realtime
 task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Herrera-Bendezu, Luis" <lherrera@domain.hid>
Cc: xenomai@xenomai.org

Herrera-Bendezu, Luis wrote:
> I am using Xenomai 2.4.10 on PPC. An RTDM driver creates an RTDM task
> using rtdm_task_init() and goes to sleep periodically via function
> rtdm_task_sleep().
> 
> When driver is loaded, RTDM task executes as expected. Then a realtime
> application is started via gdbserver on target board and on a linux host
> a gdb client is connected to that board. As soon as gdb breakpoints the
> realtime application the RTDM task never returns from rtdm_task_sleep().
> The application does not open the RTMD driver so at this point there is
> no interaction with the driver.
> (...)
> 
> Any ideas on the cause of the problem and fix?

That is a feature actually, in order to help you debug your application,
 all timers in the system are stopped. So, the rtdm task will only
return from rtdm_task_sleep when you will type "continue" in gdb.

The timer which have the XNTIMER_NOBLCK bit are not stopped, but setting
this bit cleanly will need extensions of the RTDM driver API.

-- 
					    Gilles.

