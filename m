Message-ID: <52CC62A0.3090108@xenomai.org>
Date: Tue, 07 Jan 2014 21:25:04 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <44lhyrmuw9.fsf@be-well.ilk.org>
In-Reply-To: <44lhyrmuw9.fsf@be-well.ilk.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Altera Cyclone V
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lowell Gilbert <kludge@be-well.ilk.org>
Cc: xenomai@xenomai.org

On 01/07/2014 08:52 PM, Lowell Gilbert wrote:
> What I'm hitting at the moment is that gt_setup() is getting called, 
> but twd_timer_setup() hasn't run yet, so the frequency isn't set yet. 
> Both functions are in __cpuinit, and the file would be used the same for
> other chips containing the Cortex A9, so I'm confused about what might
> be wrong.

gt_setup is supposed to be called after twd_local_timer_common_register,
which calls twd_get_clock, which gets the timer frequency from the twd
clock node. If your SOC does not have a clock node for the twd clock,
then you should add one, because the calibration method yields unprecise
results, which may result in "early shots", meaning too many interrupts,
if the GT is not used as TSC.

> 
> Any pointers would be appreciated.

See:
https://www.xenomai.org/index.php/I-pipe-core:ArmPorting
In particular, about this specific issue:

https://www.xenomai.org/index.php/I-pipe-core:ArmPorting#The_Cortex-A9_case

Regards.

-- 
                                                                Gilles.

