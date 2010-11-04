Message-ID: <4CD279F7.7070502@domain.hid>
Date: Thu, 04 Nov 2010 10:16:39 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4CC82C8D.3080808@domain.hid>	<4CC92786.3030509@domain.hid>	<4CC92902.4040904@domain.hid>	<4CC943A2.9020806@domain.hid>	<4CC94E0B.9070106@domain.hid>	<4CCEF104.7050409@domain.hid>	<4CD11AB1.8090407@domain.hid>	<4CD13A70.8040702@domain.hid>	<4CD14B1E.4000707@domain.hid>	<4CD14C92.90901@domain.hid>	<4CD14DBC.3060505@domain.hid>	<4CD1509A.3000908@domain.hid>	<4CD152F3.4080203@domain.hid>	<4CD16654.6080704@domain.hid>	<4CD18782.7090607@domain.hid>	<4CD191EE.7000604@domain.hid>	<4CD1936E.50203@domain.hid>	<4CD1BA29.9000303@domain.hid>	<1288816871.1842.84.camel@domain.hid>
	<4CD1DC1B.8060407@domain.hid>	<4CD1DE12.5010309@domain.hid>
	<4CD1E890.5010702@domain.hid> <4CD1EC2F.4040603@domain.hid>
	<4CD1ED16.8030103@domain.hid> <4CD1EDA8.10007@domain.hid>
	<4CD1F33C.5070208@domain.hid> <4CD1F3F5.5080505@domain.hid>
	<4CD1F4FE.9020908@domain.hid> <4CD1F69B.9070100@domain.hid>
	<4CD1F906.1070703@domain.hid> <4CD1FABD.1080301@domain.hid>
	<4CD2612C.2070507@domain.hid>
In-Reply-To: <4CD2612C.2070507@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Potential problem with rt_eepro100
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Jan Kiszka wrote:
> Take a step back and look at the root cause for this issue again. Unlocked
> 
> 	if need-resched
> 		__xnpod_schedule
> 
> is inherently racy and will always be (not only for the remote
> reschedule case BTW).

Ok, let us examine what may happen with this code if we only set the
XNRESCHED bit on the local cpu. First, other bits than XNRESCHED do not
matter, because they can not change under our feet. So, we have two
cases for this race:
1- we see the XNRESCHED bit, but it has been cleared once nklock is
locked in __xnpod_schedule.
2- we do not see the XNRESCHED bit, but it get set right after we test it.

1 is not a problem.
2 is not a problem, because anything which sets the XNRESCHED (it may
only be an interrupt in fact) bit will cause xnpod_schedule to be called
right after that.

So no, no race here provided that we only set the XNRESCHED bit on the
local cpu.

 So we either have to accept this and remove the
> debugging check from the scheduler or push the check back to
> __xnpod_schedule where it once came from. When this it cleaned up, we
> can look into the remote resched protocol again.

The problem of the debug check is that it checks whether the scheduler
state is modified without the XNRESCHED bit being set. And this is the
problem, because yes, in that case, we have a race: the scheduler state
may be modified before the XNRESCHED bit is set by an IPI.

If we want to fix the debug check, we have to have a special bit, on in
the sched->status flag, only for the purpose of debugging. Or remove the
debug check.

-- 
                                                                Gilles.

