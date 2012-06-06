MIME-Version: 1.0
In-Reply-To: <4FCF1517.3010904@xenomai.org>
References: <CAKKWdtfz7+pRjjbE6Ev4zJNZpa45axMePyVar+3MyRyMvcp8aA@mail.gmail.com>
	<4FCF1517.3010904@xenomai.org>
Date: Wed, 6 Jun 2012 13:36:31 +0430
Message-ID: <CAKKWdtfRyuhDzmvCC-WM66+=ncs+ocbdUuop2TRNThsj6ZAy6g@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] xenomai-2.6.0 instrumentation commands not executing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai@xenomai.org

Thank you, Philippe, for the reply.

How can i enable posix skin? should i do , make menuconfig, for the
kernel? Or i should change scripts/defconfig.frag?

It seems that both places have the correct values already but i still
have the error:

defconfig.frag:
#
# Interfaces
#
CONFIG_XENO_SKIN_NATIVE=3Dy

#
# Native interface options
#
CONFIG_XENO_OPT_NATIVE_PERIOD=3D0
CONFIG_XENO_OPT_NATIVE_PIPE=3Dy
CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=3D4096
CONFIG_XENO_OPT_NATIVE_SEM=3Dy
CONFIG_XENO_OPT_NATIVE_EVENT=3Dy
CONFIG_XENO_OPT_NATIVE_MUTEX=3Dy
CONFIG_XENO_OPT_NATIVE_COND=3Dy
CONFIG_XENO_OPT_NATIVE_QUEUE=3Dy
CONFIG_XENO_OPT_NATIVE_HEAP=3Dy
CONFIG_XENO_OPT_NATIVE_ALARM=3Dy
CONFIG_XENO_OPT_NATIVE_MPS=3Dy
# CONFIG_XENO_OPT_NATIVE_INTR is not set
CONFIG_XENO_SKIN_POSIX=3Dy

and in the kernel:
# Interfaces
#
CONFIG_XENO_SKIN_NATIVE=3Dy
CONFIG_XENO_OPT_NATIVE_PERIOD=3D0
CONFIG_XENO_OPT_NATIVE_PIPE=3Dy
CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=3D1024
CONFIG_XENO_OPT_NATIVE_SEM=3Dy
CONFIG_XENO_OPT_NATIVE_EVENT=3Dy
CONFIG_XENO_OPT_NATIVE_MUTEX=3Dy
CONFIG_XENO_OPT_NATIVE_COND=3Dy
CONFIG_XENO_OPT_NATIVE_QUEUE=3Dy
CONFIG_XENO_OPT_NATIVE_BUFFER=3Dy
CONFIG_XENO_OPT_NATIVE_HEAP=3Dy
CONFIG_XENO_OPT_NATIVE_ALARM=3Dy
CONFIG_XENO_OPT_NATIVE_MPS=3Dy
CONFIG_XENO_OPT_NATIVE_INTR=3Dy
CONFIG_XENO_OPT_DEBUG_NATIVE=3Dy
CONFIG_XENO_SKIN_POSIX=3Dy
CONFIG_XENO_OPT_POSIX_PERIOD=3D0
CONFIG_XENO_OPT_POSIX_SHM=3Dy
CONFIG_XENO_OPT_POSIX_INTR=3Dy
CONFIG_XENO_OPT_POSIX_SELECT=3Dy
CONFIG_XENO_OPT_DEBUG_POSIX=3Dy
# CONFIG_XENO_SKIN_PSOS is not set
# CONFIG_XENO_SKIN_UITRON is not set
# CONFIG_XENO_SKIN_VRTX is not set
CONFIG_XENO_SKIN_VXWORKS=3Dy
CONFIG_XENO_OPT_VXWORKS_PERIOD=3D1000
CONFIG_XENO_OPT_DEBUG_VXWORKS=3Dy
# CONFIG_XENO_OPT_NOWARN_DEPRECATED is not set
CONFIG_XENO_SKIN_RTDM=3Dy
CONFIG_XENO_OPT_RTDM_PERIOD=3D0
CONFIG_XENO_OPT_RTDM_FILDES=3D128
CONFIG_XENO_OPT_RTDM_SELECT=3Dy
# CONFIG_XENO_OPT_DEBUG_RTDM is not set
CONFIG_XENO_OPT_DEBUG_RTDM_APPL=3Dy


On Wed, Jun 6, 2012 at 1:00 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 06/06/2012 09:40 AM, ali hagigat wrote:
>>
>> I have installed xenomai-2.6.0. None of the instrumentation commands
>> work except latency. What can i do?
>>
>
> Likely fix your Kconfig. Enable the Xenomai POSIX skin.
>
>> /root> =A0switchbench
>> bash: switchbench: command not found
>> /root> =A0switchtest
>> Xenomai Posix skin init: pthread_setschedparam: Function not implemented
>> /root> =A0cyclictest
>> Xenomai Posix skin init: pthread_setschedparam: Function not implemented
>> /root> =A0latency
>> =3D=3D Sampling period: 100 us
>> =3D=3D Test mode: periodic user-mode task
>> =3D=3D All results in microseconds
>>
>> /root> =A0xeno-test
>> Started child 7172: /bin/bash /usr/xenomai/bin/xeno-test-run-wrapper
>> /usr/xenomai/bin/xeno-test
>> ++ echo 0
>> ++ /usr/xenomai/bin/arith
>> mul: 0x79364d93, shft: 26
>> integ: 30, frac: 0x4d9364d9364d9364
>>
>> signed positive operation: 0x03ffffffffffffff * 1000000000 / 33000000
>> inline calibration: 0x0000000000000000: 28.751 ns, rejected 1/10000
>> inlined llimd: 0x79364d9364d9362f: 41.292 ns, rejected 1/10000
>> inlined llmulshft: 0x79364d92ffffffe1: 5.007 ns, rejected 0/10000
>> inlined nodiv_llimd: 0x79364d9364d9362f: 11.323 ns, rejected 1/10000
>> out of line calibration: 0x0000000000000000: 30.003 ns, rejected 0/10000
>> out of line llimd: 0x79364d9364d9362f: 46.075 ns, rejected 1/10000
>> out of line llmulshft: 0x79364d92ffffffe1: 7.800 ns, rejected 1/10000
>> out of line nodiv_llimd: 0x79364d9364d9362f: 16.683 ns, rejected 1/10000
>>
>> signed negative operation: 0xfc00000000000001 * 1000000000 / 33000000
>> inline calibration: 0x0000000000000000: 29.298 ns, rejected 1/10000
>> inlined llimd: 0x86c9b26c9b26c9d1: 39.658 ns, rejected 1/10000
>> inlined llmulshft: 0x86c9b26d0000001e: 4.059 ns, rejected 0/10000
>> inlined nodiv_llimd: 0x86c9b26c9b26c9d1: 16.976 ns, rejected 0/10000
>> out of line calibration: 0x0000000000000000: 30.002 ns, rejected 1/10000
>> out of line llimd: 0x86c9b26c9b26c9d1: 48.757 ns, rejected 0/10000
>> out of line llmulshft: 0x86c9b26d0000001e: 11.085 ns, rejected 1/10000
>> out of line nodiv_llimd: 0x86c9b26c9b26c9d1: 17.770 ns, rejected 1/10000
>>
>> unsigned operation: 0x03ffffffffffffff * 1000000000 / 33000000
>> inline calibration: 0x0000000000000000: 28.749 ns, rejected 1/10000
>> inlined nodiv_ullimd: 0x79364d9364d9362f: 16.264 ns, rejected 0/10000
>> out of line calibration: 0x0000000000000000: 30.001 ns, rejected 0/10000
>> out of line nodiv_ullimd: 0x79364d9364d9362f: 20.463 ns, rejected 1/1000=
0
>> ++ /usr/xenomai/bin/clocktest -T 30
>> Xenomai Posix skin init: pthread_setschedparam: Function not implemented
>>
>>
>> Only latency seems working.
>>
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> http://www.xenomai.org/mailman/listinfo/xenomai
>>
>
>
> --
> Philippe.

