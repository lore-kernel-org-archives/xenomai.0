Message-ID: <48844DA9.2060809@domain.hid>
Date: Mon, 21 Jul 2008 10:49:45 +0200
From: Sebastian Smolorz <smolorz@domain.hid>
MIME-Version: 1.0
References: <212629.44124.qm@domain.hid>
In-Reply-To: <212629.44124.qm@domain.hid>
Content-Type: text/plain; charset=ISO-8859-3; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] milisecond delay
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: menege1@domain.hid
Cc: xenomai-help <xenomai@xenomai.org>

Please keep the mailing list CC'ed.

egemen kaleli wrote:
> =B9 used sleep(0.1) hoping that I would have 0.1 second delay.I was wro=
ng.

sleep(unsigned int seconds) doesn't take fractions of seconds.

> =B9 dont want to use rt_task_sleep() because I dont want to use softwar=
e timer.

I don't understand what you mean. Do you want to use a dedicated=20
hardware timer? How do you think sleep() works?

> so, what can I use that provides milisecond resolution at least.?

The very first question for you is: Do you want to delay a task=20
execution under the control of Xenomai or Linux? For Xenomai I already=20
pointed you to the API. For the latter, you could use nanosleep().

--=20
Sebastian

