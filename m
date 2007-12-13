Message-ID: <47617E62.3070901@domain.hid>
Date: Thu, 13 Dec 2007 19:48:02 +0100
From: Peter Schueller <peter.schueller@domain.hid>
MIME-Version: 1.0
References: <474D8B34.8080502@domain.hid>
	<474D9B1C.7060003@domain.hid>
In-Reply-To: <474D9B1C.7060003@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: Peter Schueller <schueller.p@domain.hid>
Subject: Re: [Xenomai-core] ipipe_suspend_domain() not scheduling IRQ threads
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
>> I am currently trying to port IPIPE to a new architecture and have the=
 following symptoms with my
>> first testcase:
>>
>> - I am using a 2.6.23 Kernel and mainly looked at blackfin and i386 wh=
en porting.
>> - I create a domain with priority IPIPE_ROOT_PRIO+100 in a kernel modu=
le
>> - The domain entry does only: for(;;) ipipe_suspend_domain();
>> - After registering the domain I get the message "I-pipe: Domain Modul=
e Testdomain registered." and
>> after that the system hangs.

I was finally able to fix the problem: I had overlooked the interrupt tai=
lcall which has to look for=20
processes to be scheduled and everything so far worked good without that =
- except IPIPE (I had=20
implemented the tailcall for syscalls only).

>> - Should I read some documentation to get help? (I only found the port=
ing guide and some other=20
>> guides which did not help me answer the following questions)
>=20
> I don't know of any other doc -- this one being rather outdated,
> unfortunately.
>=20

The porting guide contains no information about what the behaviour of the=
 test module should be. If=20
the test module contains a domain doing

   for(;;) ipipe_suspend_domain();

does the "insmod test.ko" command have any chance of returning to the she=
ll? After reading the=20
ipipe_register_domain code I do not think so but perhaps I missed somethi=
ng.


Peter

--=20

Peter Sch=C3=BCller
Theobroma Systems Design und Consulting GmbH
Gutheil-Schoder-Gasse 17, A-1230 Vienna, Austria
Phone: +43 (1) 2369893-403, Fax: +43 (1) 2369893-9-403
http://www.theobroma-systems.com


