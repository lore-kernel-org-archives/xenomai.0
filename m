From: "Stoidner, Christoph" <c.stoidner@arvero.de>
Date: Thu, 11 Dec 2014 10:00:16 +0000
Message-ID: <6f637a6b60964c49bbc08e3204c8eae3@EX132MBOX1A.de2.local>
References: <8119909587ec45d1ba5696722a1b0945@EX132MBOX1A.de2.local>,
 <20141210190114.GQ1524@hermes.click-hack.org>
In-Reply-To: <20141210190114.GQ1524@hermes.click-hack.org>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Sleeping function called from invalid context
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

=0A=
>> > That is strange, are these tasks=0A=
>> > running with the SCHED_OTHER policy ?=0A=
>> No, they are running with sched fifo.=0A=
>=0A=
>Ok, next, are they using=0A=
>rt_timer_mode_set=0A=
>or=0A=
>RT drivers which return -ENOSYS in their rt handlers ?=0A=
=0A=
Assumedly you mean rt_timer_set_mode() instead of rt_timer_mode_set(). This=
 function is not called since we are using our own skin. Also our own skin =
does not use xntbase_switch(). Maybe it is interesting to know that our ski=
n is configured with periodic timing (1ms). =0A=
=0A=
RT drivers are also not installed on our system. =0A=
=0A=
Regards,=0A=
Christoph=0A=

