References: <CALLqZ8RMbYDFnQy5gV7-vSi_v9rUPx9i3XJ4ym7JQ-+x64q+3Q@mail.gmail.com>
 <1176-5f894880-11d-12dbaa60@116733711>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Strange switching [threadname] to  secondary mode after
 exception #0 in kernel-space at 0x80272444
In-reply-to: <1176-5f894880-11d-12dbaa60@116733711>
Date: Fri, 16 Oct 2020 10:59:55 +0200
Message-ID: <87mu0m8s1g.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?Q?Fran=C3=A7ois?= Legal <devel@thom.fr.eu.org>
Cc: Greg Gallagher <greg@embeddedgreg.com>, Jan Kiszka <jan.kiszka@siemens.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>


Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:

> Le Mercredi, Octobre 14, 2020 16:16 CEST, Greg Gallagher <greg@embeddedgr=
eg.com> a =C3=A9crit:=20
>=20=20
>> On Wed, Oct 14, 2020 at 5:37 AM Jan Kiszka <jan.kiszka@siemens.com> wrot=
e:
>> >
>> > On 14.10.20 10:43, Fran=C3=A7ois Legal via Xenomai wrote:
>> > > Anybody can help on this ?
>> > >
>> >
>> > I'm unfortunately not familiar with the armv7 details of copy-from-use=
r,
>> > not too speak of how spectre contributed to it. Greg, Philippe, did you
>> > come across this already?
>> >
>> > Jan
>> >
>> I'll take a look tonight but I haven't hit this in my testing.  This
>> was found on 4.4? Have you tried the 4.19 kernels?
>>=20
>> -Greg
>=20=20
> So I tried the same case on 4.19.121, with the same result, and I guess f=
or the same reason.
> Could anybody explain why, on ARMv7, we need to copy the message header a=
t the syscall entry, and not let the xxxmsg routine do it on its own ?
> Also, I could not find how those COBALT_SYSCALL32emu logic work.

There is no way an armv7 system would run the sys32emu code in
Cobalt. This code path is specific to architectures which support mixed
ABI models. Only Cobalt/x86 supports this so far, issuing x86_32
syscalls to an x86_64 kernel. You may want to check
CONFIG_XENO_ARCH_SYS3264, it is set to "def_bool n" in the Kconfig
stuff.

Converting long/pointer data conforming to a 32bit ABI to their 64bit
representation is the reason why the sys32/compat wrappers exist and are
compiled in when CONFIG_XENO_ARCH_SYS3264 is set. Aggregates arguments
such as msg headers do contain such data.

> Can anybody point me to some documentation ?
>

There is none, I'm afraid.

--=20
Philippe.

