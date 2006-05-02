From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-help] Have condition variables Priority Inheritance
	Protection (PIP)?
Date: Tue, 2 May 2006 09:36:00 -0300
References: <200604281736.28169.lbocseg@domain.hid> <44527E39.7090501@domain.hid>
In-Reply-To: <44527E39.7090501@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200605020936.00576.lbocseg@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Em Sexta 28 Abril 2006 17:42, Jan Kiszka escreveu:

>...
>> Could someone please point me the reason?
>
>Just as with semaphores: there is no ownership concept for condition
>variables. Thus, who should be boosted to your priority in case you
>decide to wait on such a resource?

Sorry, you are right. Xenomai has no way of knowing which tasks could signa=
l=20
the condition variable. If I wanted to wait on some resource using priority=
=20
inheritance I guess I would have to raise the priority of the task owning t=
he=20
resource manually when only one task can signal the condition variable (or =

semaphore). Do you know other better approaches? I mean if a task A of=20
priority 50, shares a resource with task B and C, both priority 10 through =

semaphores. Suppose B and C are using the semaphore when A requests it. How=
=20
could they be boosted to A's priority, so that A is protected with priority=
=20
inheritance and then go back to their original priorities? Or should I use =

other IPC mechanism for sharing resource with PIP?

Thanks in advance,

Rodrigo.

	=09
_______________________________________________________=20
Abra sua conta no Yahoo! Mail: 1GB de espa=E7o, alertas de e-mail no celula=
r e anti-spam realmente eficaz.=20
http://br.info.mail.yahoo.com/


