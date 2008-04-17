Message-ID: <2ff1a98a0804170939k651cf5b9me2730b5425afab85@domain.hid>
Date: Thu, 17 Apr 2008 18:39:23 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <480775C4.2060302@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0804111759280.5433@domain.hid>
	<4800B4FA.1050309@domain.hid>
	<50879.62.235.129.158.1208014366.squirrel@domain.hid>
	<18432.56533.343662.272421@domain.hid>
	<Pine.LNX.4.64.0804171657380.18446@domain.hid>
	<2ff1a98a0804170830v3b2fc392lf320f05a8c7f4e8d@domain.hid>
	<2ff1a98a0804170846p2dddbea5k3b69dbbc57fb6761@domain.hid>
	<480775C4.2060302@domain.hid>
Subject: Re: [Xenomai-help] rt_task_sleep_until question
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On Thu, Apr 17, 2008 at 6:07 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>
> Gilles Chanteperdrix wrote:
>  > Thinking more about it: there is a useful use, if the sleep duration
>  > is the result of rt_time_tsc2ns. Sleeping indefinitely would be a bit
>  > counter-intuitive.
>  >
>
>  Aside of this, the API has to be orthogonal, and having rt_task_sleep behave as
>  rt_task_suspend is also counter-intuitive. Think about applications doing tick
>  arithmetics to determine the remaining sleep time; at some point, they might
>  hang unexpectedly with delay == 0 == TM_INFINITE.

We agree, this is what I was trying to say.

-- 
 Gilles

