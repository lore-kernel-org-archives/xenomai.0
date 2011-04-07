Message-ID: <4D9D4E30.3020804@domain.hid>
Date: Thu, 07 Apr 2011 07:40:00 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <COL122-W4082C3BC356937E8C1DDADBDA50@domain.hid>	
	<4D9CA930.3000204@domain.hid>	
	<BLU0-SMTP74AA1DAE7E44EF487B424DBDA50@domain.hid>
	<1302128785.2030.90.camel@domain.hid>
In-Reply-To: <1302128785.2030.90.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Backfire: User <-> Kernel latancy mesurement
 tool on Xenomai
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> On Wed, 2011-04-06 at 19:31 +0100, krishna murthy j s wrote:
>> Thanks for the reply. Can you please tell me why my questions are
>> useless. Such attitude will take Xenomai user group no where. 
> 
> So, don't take what was said earlier personally. It is just that
> sometimes, people may have tuned their bullshit deflector a bit eagerly.
> Mine is totally busted btw, so you never know.

My apologies for losing my temper. There are valid reasons to choose
preempt_rt over Xenomai, but each time we test, we see that we get lower
latencies with Xenomai, so, lower latencies is not among those valid
reasons.

But, by the way, if you are into choosing preempt_rt or Xenomai, you
should ponder these other reasons. Notably the fact that it is much
easier to write a real-time application with preempt_rt without
understanding its inner workings, than it is with Xenomai.

I wonder if we should not make a wiki page which dispassionately
document the dual-kernel vs native preemption issue.

-- 
                                                                Gilles.

