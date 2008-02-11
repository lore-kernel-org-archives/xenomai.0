MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18352.52347.906633.550225@domain.hid>
Date: Mon, 11 Feb 2008 23:30:19 +0100
In-Reply-To: <47B0C9B6.7080207@domain.hid>
References: <18350.7135.108901.491437@domain.hid>
	<18350.7315.555644.171720@domain.hid>
	<47AF057A.3070305@domain.hid>
	<18351.28960.164520.295075@domain.hid>
	<47AF781E.4070102@domain.hid>
	<18351.31369.697255.825404@domain.hid>
	<47AF7F3C.6080805@domain.hid>
	<18352.48401.264561.143362@domain.hid>
	<47B0C7BD.3020609@domain.hid>
	<18352.51397.803115.798009@domain.hid>
	<47B0C9B6.7080207@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [patch 2/4] RTDM support for select-like service.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
 > Gilles Chanteperdrix wrote:
 > > Jan Kiszka wrote:
 > >  > Gilles Chanteperdrix wrote:
 > >  > > Jan Kiszka wrote:
 > >  > >  > Gilles Chanteperdrix wrote:
 > >  > >  > > Would not it be simpler to put a pointer to the task_struct ? After all,
 > >  > >  > > it already has a pid, comm and mm, and a file descriptor will not
 > >  > >  > > survive a task_struct thanks to automatic closing of file descriptors.
 > >  > >  > 
 > >  > >  > Hmm, hmm, hmmmm... Sounds reasonable, should be safe.
 > >  > > 
 > >  > > Actually no, we can not do that because a task_struct may well disappear
 > >  > > and the rtdm_process continue to exist as long as another thread uses the
 > >  > > same mm.
 > >  > 
 > >  > Because we cleanup on mm exit, not task exit, right? OK, looks like I 
 > >  > originally spent a few more thoughts than this time :-/.
 > >  > 
 > >  > > 
 > >  > >  > 
 > >  > >  > > 
 > >  > >  > >  Could you
 > >  > >  > >  > live without the check until we have per-process fd tabled, or was it
 > >  > >  > >  > essential for the select thing?
 > >  > >  > > 
 > >  > >  > > An application which I ported to Xenomai (and which uses the select
 > >  > >  > > call) closes all file descriptors in a for loop. The purpose of this
 > >  > >  > > loop is, I guess, to avoid leaving a file descriptor opened that was
 > >  > >  > > passed through exec.
 > >  > >  > 
 > >  > >  > OK.
 > >  > >  > 
 > >  > >  > So, will you change rtdm_process too? Thanks.
 > >  > > 
 > >  > > I commited the select support, without any change to rtdm_context_get or
 > >  > > rtdm_process. So, now, how do you prefer this to be fixed, by adding an
 > >  > > mm struct to the rtdm_process struct ? By the way, after thinking about
 > >  > > it I can live without this fix: I just have to stop the loop closing
 > >  > > file descriptors at 768, so that it will not try to close RTDM file
 > >  > > descriptors.
 > >  > 
 > >  > If you can live with it, I would vote for fixing it by the intended 
 > >  > redesign via per-process fds.
 > > 
 > > Ok.
 > > 
 > >  > 
 > >  > > 
 > >  > > While commiting the support for select, I also had a dependency problem
 > >  > > in Kconfig: when support for posix select is enabled the posix module
 > >  > > uses a function defined in the RTDM module. So, there is one invalid
 > >  > > configuration: posix built-in with support for select and rtdm built as
 > >  > > a module. I could not find a way to express this condition in the
 > >  > > Kconfig language, so I just made a comment depend on this condition, but
 > >  > > would be happy if anyone found a better solution.
 > >  > 
 > >  > I would say:
 > >  > 
 > >  > config POSIX
 > >  > 	select RTDM if OPT_SELECT
 > > 
 > > But in this case, I can not have posix with select and without rtdm.
 > 
 > Then you need to isolate those services that POSIX needs from RTDM. The 
 > above just expresses the dependency you described. 

Then I was wrong in what I described: the problem is that if posix is
built-in and RTDM is enabled, then RTDM must be built-in.

In the end this just 
 > shows that we have to define the common fd-ground for both skins in the 
 > core.

I also have the choice of defining the service needed
(rt_dev_select_bind) as a callback in the posix module, the RTDM module
setting this callback when loaded (like what the rtcap module does with
rtnet). But I wanted something simple, so I aimed at Kconfig stuff.

-- 


					    Gilles Chanteperdrix.

