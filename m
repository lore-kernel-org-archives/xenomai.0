Date: Fri, 25 Mar 2022 14:01:59 +0100 (CET)
From: Paal Tamas <paal_to@freemail.hu>
Subject: Re: xeno-test fails when kernel 64bit userland 32bit
In-Reply-To: <ee3f267b-800a-5c48-9ff0-fd568637dff3@siemens.com>
Message-ID: <freemail.20220325140159.96034.1@fmxmldata08.freemail.hu>
MIME-Version: 1.0
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

=20
Jan Kiszka <jan.kiszka@siemens.com> =C3=ADrta:
>On 25.03.22 13:26, Paal Tamas via Xenomai wrote:
>> Dear All,
>> I am using xenomai_3.2.1 with kernel 5.10-dovetail on x86_64 platform. I=
 compile the kernel to 64bit, but I need to have the userspace as 32bit. So=
 I configured the userspace compilation the following way:
>> ./configure --with-core=3Dcobalt --enable-smp --enable-pshared --host=3D=
i686-linux CFLAGS=3D"-m32 -D_FILE_OFFSET_BITS=3D64" LDFLAGS=3D-m32 host_ali=
as=3Di686-linux
>> I tried to start RTNET, but I get "Inappropriate ioctl for device" error=
s. I reported this issue in another thread.
>> The problem seems to be not RTNET realted, since xeno-test fails with th=
e same error: desktop:/usr/xenomai/bin$ sudo ./xeno-test
>> Started child 2202: /bin/bash /usr/xenomai/bin/xeno-test-run-wrapper ./x=
eno-test
>> ++ echo 0
>> ++ testdir=3D/usr/xenomai/bin
>> ++ which systemctl
>> ++ systemctl is-active --quiet systemd-timesyncd
>> ++ timesyncd_was_running=3Dtrue
>> ++ systemctl stop systemd-timesyncd
>> ++ /usr/xenomai/bin/smokey --run random_alloc_rounds=3D64 pattern_check_=
rounds=3D64
>> arith OK
>> bufp skipped (no kernel support)
>> cpu_affinity skipped (no kernel support)
>> fpu_stress OK
>> gdb OK
>> iddp skipped (no kernel support)
>> leaks OK
>> memory_coreheap OK
>> memory_heapmem OK
>> memory_tlsf OK
>> setup.c:96, ioctl(fd, IOC_RT_IFINFO, &cmd): Inappropriate ioctl for devi=
ce
>> /usr/xenomai/bin/smokey: test net_packet_dgram failed: Inappropriate ioc=
tl for device
>> + start_timesyncd
>> + true
>> + systemctl start systemd-timesyncd
>> + timesyncd_was_running=3Dfalse
>> child 2202 returned: exited with status 1
>> What am I doing wrong?
>
>Nothing, known issue in principle:
>https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/21
>
>Jan
>
>--=20
>Siemens AG, Technology
>Competence Center Embedded Linux

>Jan,

>=20

>Thank you for the fast response!

>Do you have any guess when this "mixed system" will work?

>=20

>Thank you,

>Tamas
