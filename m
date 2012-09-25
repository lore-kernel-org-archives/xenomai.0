Message-ID: <50616943.2000109@xenomai.org>
Date: Tue, 25 Sep 2012 10:20:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAH6xOCB_pB4Mhg_WpFXtNN5ELtreYiBSD=obviojoUyGdcr7bg@mail.gmail.com>
In-Reply-To: <CAH6xOCB_pB4Mhg_WpFXtNN5ELtreYiBSD=obviojoUyGdcr7bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Question] Why xenomai domain change the hardware
 timer to One-Shot mode?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Hyeongseok Kang <hseokkang@gmail.com>
Cc: xenomai@xenomai.org

On 09/24/2012 03:34 PM, Hyeongseok Kang wrote:
> Hi, I am trying to port xenomai to arm board and I have some question.

You seem to use old I-pipe patches. Have you read?
http://www.xenomai.org/index.php/I-pipe:ArmPorting

I advise you to use a newer I-pipe path, and read:
http://www.xenomai.org/index.php/I-pipe-core:ArmPorting

> 
> Why xenomai domain change the hardware timer to One-Shot mode by use
> __ipipe_mach_set_dec() ?

Because xenomai timing system is based on a one-shot timer. This allows
timing services to have a better precision than the 1ms or 10ms you
would get with a periodic timer.

> Another question, what's the purpose of TSC? Is it related to one-shot mode
> of timer?

More or less, since the ticks count is meaningless in one-shot mode,
Xenomai needs another clock source, and the TSC is this clock source on
x86, so we "emulate" a TSC on ARM. This tsc or emulated tsc also allows
to measure precisely short durations.

-- 
					    Gilles.

