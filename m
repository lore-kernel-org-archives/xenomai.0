Message-ID: <4B881E5A.1060407@domain.hid>
Date: Fri, 26 Feb 2010 20:17:46 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1Nl4od-0001Kw-AU@xenomai.org>
In-Reply-To: <E1Nl4od-0001Kw-AU@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : Avoid false error
	reports of	xeno_handle_mlock_alert
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>, Xenomai core <Xenomai-core@domain.hid>

GIT version control wrote:
> Module: xenomai-jki
> Branch: for-upstream
> Commit: b7940ae7699b5a371d538d1a8e22be07c3d36bf7
> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=b7940ae7699b5a371d538d1a8e22be07c3d36bf7
> 
> Author: Jan Kiszka <jan.kiszka@domain.hid>
> Date:   Thu Feb 25 23:33:46 2010 +0100
> 
> Avoid false error reports of xeno_handle_mlock_alert
> 
> We already propagate the SIGDEBUG reason to user space. Use it to tell
> SIGDEBUG_NOMLOCK apart from other triggers of this signal, e.g. the
> watchdog. This also allows to drop xeno_sigxcpu_no_mlock.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>

That is not really enough. Since a user may want to register is own
handler, we have to handle that case as we do for sigwinch. In the
process, we can also give the exported function a better name based on
sigdebug.

Ok. Will take care of that.


-- 
					    Gilles.

