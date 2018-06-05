From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <035ed079-cdbb-c39f-d3c6-2a0f46f59361@xenomai.org>
Date: Tue, 5 Jun 2018 12:48:23 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Introducing Dovetail
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>, "Seeger,
 Steven D. (GSFC-444.0)[Embedded Flight Systems,
 Inc]" <steven.seeger@nasa.gov>


This is a heads-up about an ongoing work I hinted at last year [1]
codenamed "Dovetail", which has just reached a significant milestone. In
 short, an overhauled implementation of the interrupt pipeline is now
capable of delivering short response times reliably on the ARM SoCs I'm
working on (mainly i.MX(6q|7d) so far), running the recent 4.17 kernel
release.

This code can be found at [2]. Beware: this is work in progress, the
code base is still in a state of flux, the API will not be carved in
stone anytime soon. However, the main logic is in place and should not
change significantly from now on. Obviously, the devil might still be in
the detail though.

The rationale behind this effort is about securing the maintenance of
this key component of Xenomai so that it could be maintained with common
 kernel development knowledge, at a fraction of the engineering and
maintenance cost native preemption requires. For several reasons, the
I-pipe does not qualify.

Maintaining the I-pipe proved to be difficult over the years as changes
to the mainline kernel regularly caused non-trivial code conflicts,
sometimes nasty regressions bit us downstream. Although the concept of
interrupt pipelining proved to be correct in delivering short response
time with reasonably limited changes to the original kernel, the way
this mechanism is currently integrated into the mainline code shows its
age. For those interested, the major issues affecting the current
implementation are explained at [3].

Back in 2002, I made the choice to add the interrupt pipeline mechanism
sideways to the regular kernel logic for dealing with IRQs, as a way to
limit the potentially nasty interactions between them, logically-wise
and code-wise, including merge conflicts. This decision proved to be,
well, completely wrong over time. I mean, really utterly wrong.

For instance, the countless overhauls of the x86 *APIC support upstream
made rebasing the I-pipe on the next kernel release a complete nightmare
 for as many times. Likewise, maintaining our ARM port with Gilles amid
the transition to the device tree model for this architecture, which
regularly broke our changes to the irqchip and timer drivers, has
certainly boosted our creativity with respect to curse words.

Dovetail addresses the issue of maintainability, hopefully the right way
this time. At the moment, my goal is to make an ARM-targeted version of
Xenomai's Cobalt core use whichever interrupt pipeline flavor is
available from the kernel, either the current I-pipe or the Dovetail
interface. If all goes as planned, Xenomai ports based on Dovetail
should be much easier to rebase on newer kernels, reducing the
maintenance cost.

[1] http://www.xenomai.org/pipermail/xenomai/2017-December/038163.html
[2] git://steely.xenomai.org/linux-dovetail.git
[3] https://xenomai.org/2018/06/introduction-to-dovetail/

-- 
Philippe.

