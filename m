Message-ID: <45F55B8F.3010301@domain.hid>
Date: Mon, 12 Mar 2007 14:54:23 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rtcansend.c problem if using together
	with	-lpthread_rt
References: <DD39B5C3F4963040ADC9768BE7E430CB01BB4107@domain.hid>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB01BB4107@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

Daniel Schnell wrote:
> I am using svn version 2256.
> Am I doing here something fundamentally wrong in providing -lpthread_rt
> as an additional library ? Shouldn't the native skin and the POSIX skin
> just work together ?

The two libraries work together, but the POSIX skin automatically
shadows the main thread. So, if you are trying to shadow it with the
native library, you get the -EBUSY error, that is normal: you can not
shadow the same thread twice. If you want to link rtcansend with the
posix skin, simply remove the shadowing of the main thread with
rt_task_shadow.

-- 
                                                 Gilles Chanteperdrix

