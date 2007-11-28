Message-ID: <474D8B34.8080502@domain.hid>
Date: Wed, 28 Nov 2007 16:37:24 +0100
From: "=?UTF-8?B?UGV0ZXIgU2NodWXCn2xsZXI=?="
	<peter.schueller@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-core] ipipe_suspend_domain() not scheduling IRQ threads
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi!

I am currently trying to port IPIPE to a new architecture and have the fo=
llowing symptoms with my
first testcase:

- I am using a 2.6.23 Kernel and mainly looked at blackfin and i386 when =
porting.
- I create a domain with priority IPIPE_ROOT_PRIO+100 in a kernel module
- The domain entry does only: for(;;) ipipe_suspend_domain();
- After registering the domain I get the message "I-pipe: Domain Module T=
estdomain registered." and
after that the system hangs.

I traced the problem a bit and found out that

- ipipe_suspend_domain() always returns to the test domain with the highe=
st priority.
- Within ipipe_suspend_domain() the function __ipipe_sync_stage() gets ca=
lled for the root domain
and calls __ipipe_run_isr for
   irq 1 (Linux Timer Tick)
   irq 2 (network - the whole thing runs from NFS)
   irq 32 (there are 32 hardware interrupts, the last one is irq 31, this=
 must be a virtual irq)

I think the problem is that the IRQ threads do not get scheduled and so c=
annot handle the
Interrupts, although they have been "kicked" by __ipipe_run_isr.

It would be very kind if you could help me with the following questions:

- Are some of my assumptions/ideas above completely wrong?
- Should I read some documentation to get help? (I only found the porting=
 guide and some other=20
guides which did not help me answer the following questions)
- Which part of the code should schedule the IRQ threads? (__ipipe_run_is=
r only "kicks" them afaik)
- Where should ipipe_suspend_domain() hand control over to another domain=
 (i.e. schedule in the
other domain because the higher priority domain has suspended itself)?
- Should I handle the Linux System timer differently from the other inter=
rupts so that it is not
subject to IRQ threading?

Best Regards,

Peter

--=20

Peter Sch=C3=BCller
Theobroma Systems Design und Consulting GmbH
Gutheil-Schoder-Gasse 17, A-1230 Vienna, Austria
Phone: +43 (1) 2369893-403, Fax: +43 (1) 2369893-9-403
http://www.theobroma-systems.com


