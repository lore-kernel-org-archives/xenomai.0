Message-ID: <4C1CB7EA.5030005@domain.hid>
Date: Sat, 19 Jun 2010 14:28:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1OKZdD-0003ml-45@domain.hid>
	<4C095876.3060605@domain.hid>	<4C099329.6000303@domain.hid>
	<4C0A49C4.8000509@domain.hid>	<4C0A9AB9.7030602@domain.hid>
	<4C0A9C2A.1030002@domain.hid>	<4C0AA224.6060409@domain.hid>
	<4C0AA2F0.6050201@domain.hid>	<4C0AA3EC.7040106@domain.hid>
	<4C0AA548.6070409@domain.hid>	<4C0AB7BA.7000100@domain.hid>
	<4C0B9846.7050203@domain.hid> <4C1BC224.5040505@domain.hid>
	<4C1BC3BA.3020603@domain.hid> <4C1BD462.1000702@domain.hid>
	<4C1C9882.9060103@domain.hid> <4C1CAF8A.1000900@domain.hid>
In-Reply-To: <4C1CAF8A.1000900@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : native: Rework
 handling of pthread carrier thread
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> As for the rt_task_delete/rt_task_join question, I think we should have
>> to call rt_task_join after deleting  a thread, because that is the only
>> way to make sure that all the ressources associated to a thread are free.
> 
> The question is not how we can release resources (that's trivial:
> pthread_detach) but if we officially provide the service "join after
> delete" to the user. If we do this, its limitations and implications on
> the native interface need to be documented. So far this is fuzzy unless
> you know our implementation.

No pthread_detach does not insure you that the ressources are released.
It insures you that they will be released at a later point in time. That
is the point. The only way to ensure that the ressources have been
released, or more precisely, to wait for them to be released, is to call
phtread_join. If you did not want to wait for that, then there was no
point to create the thread joinable in the first place.

Anyway, yes, I agree, this behaviour of rt_task_join should be documented.

> 
> Jan
> 


-- 
					    Gilles.

