Message-ID: <4E4418EE.8000005@domain.hid>
Date: Thu, 11 Aug 2011 20:01:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201108101449.54243.carlosnov@domain.hid>
	<201108111131.11981.carlosnov@domain.hid>
	<4E43EE80.8050406@domain.hid>
	<201108111456.24208.carlosnov@domain.hid>
In-Reply-To: <201108111456.24208.carlosnov@domain.hid>
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

On 08/11/2011 07:56 PM, Carlos Eduardo de Brito Novaes wrote:
> Hello again,
> 
> I did what you said, changed the open/close to non real time, removed every 
> portion of code that is not related with the fault (the read_rt is still there 
> since is where the problem arrises and also another ioctl to start timer since 
> the open/close are moved out of real time context). There is also the wait 
> ioctl to show that the code works when wait is done inside ioctl.
> The problem persists, but no hangs perceived. Just the application returns too 
> fast and there is the kernel message on NULL pointer derreference, so I also 
> tried to recompile with another kernel version, the vanilla 2.6.38-8 from 
> kernel.org and the adeos patch (on the previous tests I was using the same 
> with additional ubuntu patches). Even now the app returns imediately after 
> call read with rtdm_event_wait and there is the same kernel log.
> I dont think there is any memory corruption due to the module code since there 
> is no dynamic allocations, little pointer operations mainly related to the 
> context hadler witch is allocated by xenomai on rtdm_dev_register.
> I send you the new tarball.
> 
> Thanks for your support.

The copy_to_user is still overflowing. And in fact, it is probably the
cause of the bug you observe, I had not read your example carefully.

-- 
                                                                Gilles.

