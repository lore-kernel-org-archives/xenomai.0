Message-ID: <475E8EA6.1040702@domain.hid>
Date: Tue, 11 Dec 2007 14:20:38 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4757EBAE.4050608@domain.hid>		<2ff1a98a0712060544x6e1e8c11q52e9417fb096e4b7@domain.hid>		<475801AA.3060300@domain.hid>		<2ff1a98a0712060621k436f32b7sc1d1cfe53bea8f18@domain.hid>		<475952CD.3020003@domain.hid>		<18265.47545.897637.377869@domain.hid>		<18265.50385.343346.558000@domain.hid>		<475C6454.2090002@domain.hid>		<18268.29130.406826.933528@domain.hid>		<475D5923.2050701@domain.hid>	<2ff1a98a0712100755l5c091420oe4d86ecd919992a4@domain.hid>
	<475DB21C.8040800@domain.hid> <475DB3AA.3080306@domain.hid>
In-Reply-To: <475DB3AA.3080306@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] How to cancel a Xenomai POSIX thread
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
Cc: xenomai-core <xenomai@xenomai.org>

Wolfgang Grandegger wrote:
> The attached test application using a more sophisticated signal handling
> works fine on my MPC5200-board running Linux 2.6.23 and Xenomai trunk.
> Going to try it tomorrow on my PC.

It works fine as well on my PC with Linux 2.6.23 and Xenomai trunk and
now also with Linux 2.4.25 and Xenomai 2.3.x :-). Just to understand it
right: The task signaled with pthread_kill() will be suspended and
switches to secondary mode if it was running in primary mode. The signal
will then be handled by Linux as usual. When the task resumes, does it
get switched back to primary mode automatically?

Great, the only open issue is why executing init_task() switches to
secondary mode resulting in period overruns in high_prio_task(). Is that
obvious to you?

Thanks a lot.

Wolfgang.

