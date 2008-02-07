Message-ID: <47AB2771.7080508@domain.hid>
Date: Thu, 07 Feb 2008 16:44:49 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <51CAD0CE1504444DBE77CBBE51A0135D3769E8@domain.hid>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D3769E8@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] fpu
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
> This is probably an application error, but I am having some random weird
> behavior where sometimes a double that I add 0.01 to in a periodic task
> gets corrupted and becomes nan. I didn't specify the T_FPU flag in
> rt_task_spawn() but the docs said that flag is assumed for a user space
> task. I've since set that flag manually and haven't had the problem
> happen yet. Is this just a coincidence? 
> 

Likely, as T_FPU is hard-coded for user space threads. You could try to
strip down your test so that incorrect application behaviour can be
excluded (or use the test below).

>  
> 
> The corruption seems to happen in a half-second window where the system
> is doing a lot and only about 35% of the CPU is available to Linux.
> However, I am testing for overruns on rt_task_wait_period() and never
> seeing any.

Overload must not cause data corruption, "only" missed deadlines. This
case needs closer examination.

As some first step: there is the switchtest tool coming with Xenomai. It
includes consistency checks of the FPU environment across context
switches. Maybe you can give this a try under similar load conditions
over a longer period.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

