From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17590.14655.583084.480317@domain.hid>
Date: Thu, 13 Jul 2006 14:14:55 +0200
Subject: Re: [Xenomai-help] RT timer help
In-Reply-To: <e325d110607130503k37a4e648p1ae581e7b984abb4@domain.hid>
References: <e325d110607130503k37a4e648p1ae581e7b984abb4@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Kim Chuan Lim <lim.kim.chuan@domain.hid>
Cc: xenomai@xenomai.org

Kim Chuan Lim wrote:
 > Hi all,
 > 
 > I am a bit confuse with the rt timer clock tick.
 > printf("rt_timer_ns2tsc(1000000000) == %lld
 > \n",rt_timer_ns2tsc(1000000000));//1second
 > rt_timer_ns2tsc(1000000000) == 1193182;
 > 
 > rt_task_set_periodic(NULL, TM_NOW, 1193182LLu);

rt_task_set_periodic times are passed as count of system clock ticks,
not CPU clock ticks. So, you should be using rt_timer_ns2ticks.

-- 


					    Gilles Chanteperdrix.

