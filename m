From: "Stoidner, Christoph" <c.stoidner@arvero.de>
Date: Thu, 11 Dec 2014 15:47:36 +0000
Message-ID: <26e587954f4c46119fa524af7a3a454e@EX132MBOX1A.de2.local>
References: <8119909587ec45d1ba5696722a1b0945@EX132MBOX1A.de2.local>
 <20141210190114.GQ1524@hermes.click-hack.org>
 <6f637a6b60964c49bbc08e3204c8eae3@EX132MBOX1A.de2.local>
 <20141211100520.GA21808@hermes.click-hack.org>
 <88cb5162a0ca44fb8251aa8161a8d8d8@EX132MBOX1A.de2.local>
 <20141211102249.GB21808@hermes.click-hack.org>
 <14309ee2cb7e45c9a01e6e1504c5bed5@EX132MBOX1A.de2.local>
 <20141211104713.GC21808@hermes.click-hack.org>
 <67263b7a47034e2fba906d0b68b3277f@EX132MBOX1A.de2.local>,
 <20141211144711.GD21808@hermes.click-hack.org>
In-Reply-To: <20141211144711.GD21808@hermes.click-hack.org>
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
> Ok, maybe we have some hope with the tracer though. What should=0A=
> trigger a trace is the fact that a relax request has been sent, but=0A=
> that the next linux scheduling point does not wake up the said task.=0A=
> This is all debug code, so it does not need to be clean. You can=0A=
> define a per-cpu variable (if running on SMP systems, otherwise a=0A=
> global variable will do) with the last request posted. And when a=0A=
> linux scheduling happens, test that the newly scheduled task is the=0A=
> task that was passed to the relax, if that is not the case, trigger=0A=
> a trace freeze. The point where the nucleus is informed of a Linux=0A=
> task switch is do_schedule_event(). The trick is that if you have=0A=
> some tasks with a higher priority than the relaxed task, it is=0A=
> normal that the relaxed task is not scheduled immediately, so if you=0A=
> want the condition to hold, you need to run the xenomai tasks which=0A=
> relax with the highest priority. Also, obviously, after the test,=0A=
> the pointer should be reset to NULL, because there are several task=0A=
> queued, and with a global variable you have no way of knowing which=0A=
> is next.=0A=
=0A=
I will do so. Do I have to change the gatekeeper's priority behind the rela=
xing=0A=
task to assure that the gatekeeper would be scheduled before?=0A=
=0A=
Regards,=0A=
Christoph=0A=

