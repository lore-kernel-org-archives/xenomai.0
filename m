MIME-Version: 1.0
In-Reply-To: <c296ac71-b3e0-c790-6af3-b64f54a2cf2b@xenomai.org>
References: <CADXNiGXZ7sCz8ZZ0TUtPGuWzCvdyBueeAm0oqeBWs=WccZk-YA@mail.gmail.com>
 <c296ac71-b3e0-c790-6af3-b64f54a2cf2b@xenomai.org>
From: Piotr Piorkowski <qba100@gmail.com>
Date: Wed, 4 Oct 2017 22:03:30 +0200
Message-ID: <CANXti+dsa30duyCYtuiN6OWvg+AoknE_mE8qzUME3wqemzv+ag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] rt_task_set_affinity causes hang
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

I have the same problem on Raspberry Pi 3.
Its look as freeze platform. Under xenomai 3.0.3 programs works fine.

Piotr

2017-10-04 19:49 GMT+02:00 Philippe Gerum <rpm@xenomai.org>:

> On 10/04/2017 05:05 AM, Jackson Jones wrote:
> > Below is an example program that runs fine under xenomai-3.0.3. Under
> 3.0.5
> > it hangs when rt_task_set_affinity() is called.
> >
> > Any ideas?
> >
>
> - which CPU architecture is your app running on?
>
> - what do you mean by "it hangs"? Sleeps with no action with the rest of
> the system still ok, or hard lockup of the whole SoC?
>
> - rt_task_sleep() returns a status code; if the application does not
> care about it, it might enter a tight loop whenever the call fails, for
> whatever reason. That status may help determining such reason.
>
> CONFIG_XENO_OPT_WATCHDOG is usually helpful for detecting runaway
> threads, preventing hard lockups. --
> Philippe.
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai
>
