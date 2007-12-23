From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Sun, 23 Dec 2007 23:17:56 +0100
References: <200712231747.35449.niklaus.giger@domain.hid>
	<18286.53276.972102.704126@domain.hid>
In-Reply-To: <18286.53276.972102.704126@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200712232317.56597.niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Buildbot is back (and reporting errors)
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Am Sonntag, 23. Dezember 2007 schrieb Gilles Chanteperdrix:
> Niklaus Giger wrote:
>  > a) The simulator fails in two tests with the vxworks skins. In
>  > http://ngiger.dyndns.org/buildbot/builders/sim_f/builds/1/steps/check_sim/logs/stdio
>  > you will find at the end the lines
>  > > Some problems were reported in:
>  > > vxworks->t010726-1::
>  > > vxworks->t010823-2::
>  > Going back one finds:
>  > > starting VxWorks services.
>  > > Xenoscope: lt-t010823-2: fatal in MvmIrq (time=30000718.974563):
>  > > test interrupted by watchdog.
>  > and
>  > > starting VxWorks services.
>  > > Xenoscope: lt-t010726-1: fatal in MvmIrq (time=30000718.974820):
>  > > test interrupted by watchdog.
> 
> The problem is that the root task priority is 0, and that now, 0 is a
> priority with a special meaning. However, VxWorks priority range is from
> 0 to 255, not from 1 to 255.
> 
Usually only the excTask runs with priority 0 on a vxWorks system. I would
therefore suggest that we forbid starting a vxworks task with priority 0.
If a error is returned and this exception is documented in
the doc/txt/vxworks-skin.txt I could live with it without any problems.

Thanks anyway for your explanation.

-- 
Niklaus Giger

