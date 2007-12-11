Message-ID: <475E3FFD.2050406@domain.hid>
Date: Tue, 11 Dec 2007 08:45:01 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4757EBAE.4050608@domain.hid>	<2ff1a98a0712060513g3b056866x883691498daf00e1@domain.hid>	<4757F811.70905@domain.hid>	<2ff1a98a0712060528y13159abdwb83617a8744b3735@domain.hid>	<2ff1a98a0712060544x6e1e8c11q52e9417fb096e4b7@domain.hid>	<475801AA.3060300@domain.hid>	<2ff1a98a0712060621k436f32b7sc1d1cfe53bea8f18@domain.hid>	<475952CD.3020003@domain.hid>	<18265.47545.897637.377869@domain.hid>	<18265.50385.343346.558000@domain.hid>	<475C6454.2090002@domain.hid>	<18268.29130.406826.933528@domain.hid>	<475D5923.2050701@domain.hid>
	<18269.47515.94669.480543@domain.hid>
In-Reply-To: <18269.47515.94669.480543@domain.hid>
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

Gilles Chanteperdrix wrote:
> Wolfgang Grandegger wrote:
>  > After adding pthread_getschedparam() I realized, that policy was 1 and
>  > prio 10 and not as expected 5. The corresponding attribute settings
>  > before calling pthread_create have been ignored somehow. Am I doing
>  > something wrong in task_init()?
> 
> Wait, what you observe here is that the low prio task inherits
> scheduling parameter from the high prio task. The default value for the
> inheritsched attribute is PTHREAD_INHERIT_SCHED. So, if you want to set
> explicitely the scheduling parameter, you should call
> pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);

You are right. With PTHREAD_EXPLICIT_SCHED it works as expected with
2.6. With 2.4, it seems to be the default. I'm not really an advanced
POSIX/PTHREAD programmer :-(.

Wolfgang,

