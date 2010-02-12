Message-ID: <4B757B8D.9060307@domain.hid>
Date: Fri, 12 Feb 2010 17:02:21 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20100204105700.GB20669@domain.hid>	
	<b88603c31002050439n790f4f71kd6e152198de511f2@domain.hid>	
	<4B6C1E66.2000008@domain.hid>
	<4B6C2D59.9060200@domain.hid>	
	<b88603c31002050727p1decfdacm919d3f2278fdf2f0@domain.hid>	
	<4B7019AA.8020102@domain.hid>	
	<b88603c31002080633v1b9ee7b4s2a6ee82eeaab644d@domain.hid>	
	<4B71339F.6050300@domain.hid> <4B713462.6000300@domain.hid>	
	<b88603c31002090214j2d21f572sba26ed3883bc0612@domain.hid>
	<b88603c31002120757m386b5662nd8844a8fbccb22f0@domain.hid>
In-Reply-To: <b88603c31002120757m386b5662nd8844a8fbccb22f0@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Force switch back to primary domain
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henri Roosen <henriroosen@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Henri Roosen wrote:
> Ok, found some time to investigate the mutex problem we see on 2.5.1.
> 
> I managed to reproduce with a basic app that uses the same way of
> thread creation as we have in our app.
> Please find attached the basic app. Note, it runs fine on Xenomai
> 2.4.10. Fails on 2.5.1.
> 
> Also, the problem does not show when creating the threads with rt_task_create.
> 
> So the main question is, should it be possible to create threads with
> the clone() system call and then shadowing the threads into the
> Xenomai domain with rt_task_shadow()? And are we just lucky it runs
> this way in 2.4.10?

I would tend to think that Xenomai relies on the existence of a
"pthread_t" associated with each thread, this only happens if the thread
is created with pthread_create, not if created with clone.

In fact, I even wonder how it works with 2.4.10.
(rt_task_delete probably does not work in fact).

-- 
					    Gilles.

