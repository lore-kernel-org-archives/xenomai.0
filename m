Message-ID: <4E43EE80.8050406@domain.hid>
Date: Thu, 11 Aug 2011 17:00:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201108101449.54243.carlosnov@domain.hid>
	<201108101810.02640.carlosnov@domain.hid>
	<4E438724.2070709@domain.hid>
	<201108111131.11981.carlosnov@domain.hid>
In-Reply-To: <201108111131.11981.carlosnov@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Trouble with rtdm timers and events
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Carlos Eduardo de Brito Novaes <carlosnov@domain.hid>
Cc: xenomai@xenomai.org

On 08/11/2011 04:31 PM, Carlos Eduardo de Brito Novaes wrote:
> Here it comes.
> I found out that if wait is called inside an IOCTL, there is no hangs at all, 
> everything work as expected, except from te fact that it seens a litle bit 
> strange (to me) to use ioctl to read or write, I would expect to use the 
> correspondent rad and write functions and ioctl to setup something.
> I tried to reduce the code, in the tarball there are one Makefile, one c file 
> for the module and one c file for the app. There is one define line on the 
> module file, comment it ou to get the hangs. The app will simply open the 
> device, issue an wait ioctl (dummy if the module is compiled to wait in 
> read_rt) and the do the actual reading (it hangs on my system if i tell the 
> module to wait on the read_rt function).
> 
> Here comes the kernel log from one run that does the error but fortunately
> does not hang the entire system.

Yes, you can use rtdm_event_wait in read or write. The fact that it
hangs or results in bugs is probably due to the fact that you are
corrupting some memory. Your testcase contains too much code. If you
want to test rtdm_event_wait / rtdm_event_pulse, simply do one driver,
with one ioctl which does the rtdm_event_wait, and the timer which does
the rtdm_event_pulse.

The copy_to_user in the read callback overflows the source area, but
that is not your problem.

Also, do not use open_rt and close_rt in new code as they are deprecated.

-- 
					    Gilles.

