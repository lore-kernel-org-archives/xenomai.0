Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] Questions porting existing rtai-24.1.12 app
	toxenomai
Date: Tue, 4 Apr 2006 10:32:28 +0200
Message-ID: <1CFEB358338412458B21FAA0D78FE86D042A2FEE@rennsmail02.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, Randy Smith <rsmith@domain.hid>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
>Randy Smith wrote:
>> I have inherited some linux 2.4.25 kernel module code for a powerpc
that=20
>> uses rtai-24.1.12.  In my xenomai enabled kernel, I have disabled
native=20
>> support and enabled the RTAI emulator.  This works as far as I know.
I=20
>> can insmod it at least but to test it, I need some user mode code and

>> that is where I am running into problems.
>>=20
>> The kernel module runs as a periodic task and uses kernel mode shared

>> memory to communicate with the user mode application.  The user mode=20
>> application uses rtai_malloc to allocate the shared memory that the=20
>> kernel module created with rtai_kmalloc.  My application fails to
link=20
>> since librtai.so cannot resolve the call to rtai_malloc.  What should
I=20
>> migrate the rtai_malloc call to in order to use the rtai skin with=20
>> xenomai??
>
>The thing is that the RTAI emulator provided currently covers a minimal

>set of kernel-space only RTAI services, and does not provide any=20
>user-space interface to these calls. The librtai.so library that would=20
>contain the user-space interface mimicking LXRT is actually empty, and=20
>basically a placeholder, waiting for someone to be motivated enough to=20
>extend the existing support and flesh it. (hint, hint...).

Ok, got the hint ;-)

> Can I not communicate kernel to user via shared memory in that skin?
>=20

RTAI shared memory access from user space works here. Just let me some
time
to make up the patch and post it to GNA. I have a RT-fifo patch also
that=20
removes the I/O size limitation (reader<write) that will make Philippe=20
scream.

>In fact, it's just that the RTAI emulator over Xenomai currently=20
>provides only a small subset of the > 300 routines the original RTAI
API=20
>exports, and solely in kernel space. The reason for that is likely that

>people porting from the RTAI API to Xeno usually switch to Xeno's
native=20
>API directly.

Indeed, switching directly to Xeno native is worth the advice (sigh).

--=20
Stephane


