From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18004.38669.551814.469582@domain.hid>
Date: Wed, 23 May 2007 21:33:33 +0200
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E09993F7@domain.hid>
References: <FDBBB5CC70676540B3EF7CFE83FD94E09993F7@domain.hid>
Subject: Re: [Xenomai-help] Artificial task load
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ROSSIER Daniel <Daniel.Rossier@domain.hid>
Cc: xenomai@xenomai.org

ROSSIER Daniel wrote:
 > Hello,
 > 
 >  
 > 
 > Maybe this issue has already been raised up, anyway...
 > 
 > What would be the best way to simulate a task load in Xenomai RT tasks,
 > avoiding the rt_timer_spin() which is not appropriate
 > 
 > when multiple task context switching occur?
 > 
 > (I've already experimented a simple loop with rt_timer_spin(1), but it
 > is not reasonable since the loop instructions consumes some CPU time as
 > well).
 > 
 >  
 > 
 > Thanks for any advice.

Sorry, but I do not understand what is wrong with rt_timer_spin(). If
you do not want to use this service, maybe you can use
xnarch_get_cpu_tsc() (or __xn_rdtsc() in user-space) ?

-- 


					    Gilles Chanteperdrix.

