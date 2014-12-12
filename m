From: "Stoidner, Christoph" <c.stoidner@arvero.de>
Date: Fri, 12 Dec 2014 16:42:05 +0000
Message-ID: <ea7b0e38bbc54fb693aa93e0acd4cb22@EX132MBOX1A.de2.local>
References: <20141211100520.GA21808@hermes.click-hack.org>
 <88cb5162a0ca44fb8251aa8161a8d8d8@EX132MBOX1A.de2.local>
 <20141211102249.GB21808@hermes.click-hack.org>
 <14309ee2cb7e45c9a01e6e1504c5bed5@EX132MBOX1A.de2.local>
 <20141211104713.GC21808@hermes.click-hack.org>
 <67263b7a47034e2fba906d0b68b3277f@EX132MBOX1A.de2.local>
 <20141211144711.GD21808@hermes.click-hack.org>
 <26e587954f4c46119fa524af7a3a454e@EX132MBOX1A.de2.local>
 <20141211160616.GA27793@hermes.click-hack.org>
 <e8d20d65a12c4549a2a1737501ea48dc@EX132MBOX1A.de2.local>,
 <20141211163807.GD27793@hermes.click-hack.org>,
 <609e4e03a401411fa6bc14de1ad4d3a5@EX132MBOX1A.de2.local>
In-Reply-To: <609e4e03a401411fa6bc14de1ad4d3a5@EX132MBOX1A.de2.local>
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
Hi Gilles,=0A=
=0A=
it seems to me as APC interrupts on ipipe got lost. I have added two counte=
rs: One increments in schedule_linux_call() when a request for a specific a=
pplication task is queued. Another one is incremented in lostage_handler() =
when the specific task was waked up. When I output the counter's values aft=
er tasks have freezed the counter of lostage_handler is exactly one value l=
ess than schedule_linux_call's counter. =0A=
=0A=
And then, when I wake-up APC thread manually all freezed tasks continue for=
 a moment, until all are freezing again.=0A=
=0A=
Do you have any idea what could lead to that behaviour?=0A=
=0A=
Regards,=0A=
Christoph=0A=

