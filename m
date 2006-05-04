From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-help] Have condition variables Priority Inheritance
	Protection (PIP)?
Date: Thu, 4 May 2006 10:58:22 -0300
References: <200604281736.28169.lbocseg@domain.hid>
	<200605031315.01583.lbocseg@domain.hid> <4459A511.8050302@domain.hid>
In-Reply-To: <4459A511.8050302@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200605041058.22358.lbocseg@domain.hid>
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

Em Quinta 04 Maio 2006 03:54, Jan Kiszka escreveu:

>> ...
>> Yes, however I can't figure out how could I use mutexes as counting
>> semaphores, for instance. They have different meanings. However I could
>> think in semaphores protected by PIP in singular cases, although I
>> couldn't figure out how to do it in a systematic approach so that it cou=
ld
>> be used in a realtime framework such as Xenomai...
>
>So you have to protect a multi-instance resource which can be used by a
>certain number of tasks in parallel? Is this a real scenario or just a
>hypothetical?

Just hypothetical for now. I guess I am preparing myself to the questions t=
hat=20
could arrive about Xenomai when presenting my master thesis (if I will=20
present it at all :) )

>Let's consider it's real: this means that every task successfully
>requesting the resource becomes one of the owners. So you would have to
>maintain a list of owners, not just a single reference as with mutexes.

Another way would be make Xenomai maintain this list of owners that would b=
e=20
updated in rt_sem_p calls, doesn't it?

>Once someone requests the resource when there are no instances left, at
>least one of the owners should be boosted to the requesters priority.

Right.

>All feasible, but probably so special with traps and pitfalls (think of
>initialising or handling multiple requests by the same tasks)

I tried to, but couldn't figure out which would be those pitfalls.

>that no one yet developed a generic mechanism for any OS I know of. But you
>are always free to do so based on existing elementary mechanisms. :)=20

Maybe after my deadline ;)

Thank you,

Rodrigo.

	=09
_______________________________________________________=20
Abra sua conta no Yahoo! Mail: 1GB de espa=E7o, alertas de e-mail no celula=
r e anti-spam realmente eficaz.=20
http://br.info.mail.yahoo.com/


