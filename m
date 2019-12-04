Subject: Re: undefined reference to `rt_task_create
References: <441471f5-30ed-3b11-8b58-8e5bd7f805d1@vbm-grp.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <49140ed3-da2c-161b-5a21-4569497727cc@siemens.com>
Date: Wed, 4 Dec 2019 12:10:32 +0100
MIME-Version: 1.0
In-Reply-To: <441471f5-30ed-3b11-8b58-8e5bd7f805d1@vbm-grp.com>
Content-Type: text/plain; charset="iso-8859-15"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Electronic Dept. - Vbm Group" <electronic@vbm-grp.com>, xenomai@xenomai.org

On 04.12.19 12:01, Electronic Dept. - Vbm Group via Xenomai wrote:
> Goodmorning,
> I'm using a Beaglebone black and I'm doing the first tests with Xenomai.
> I've created a kernel patched with Xenomai from here:
> https://github.com/RobertCNelson/ti-linux-kernel-dev/tree/ti-linux-xenoma=
i-4.4.y
>=20
> and installed Xenomai libraries following:
> https://forum.digikey.com/t/how-to-cross-compile-application-for-xenomai-=
with-beaglebone/4943/3
>=20
>=20
>=20
> I've made a test file named cyclic_test.c and the following Makefile:
>=20
> MAIN_SRC=3D cyclic_test
> TARGET=A0=A0=A0 =3D cyclic_test
>=20
> SKIN =A0=A0=A0 :=3D alchemy
> CFLAGS =A0=A0=A0 :=3D $(shell /usr/xenomai/bin/xeno-config --skin=3D$(ski=
n) --cflags)
> LDFLAGS :=3D $(shell /usr/xenomai/bin/xeno-config --skin=3D$(skin) --ldfl=
ags)
> CC =A0=A0=A0 :=3D $(shell /usr/xenomai/bin/xeno-config --cc)
>=20
> $(TARGET): $(MAIN_SRC).c
> =A0=A0=A0 $(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)
>=20
> clean:
> =A0=A0=A0 @rm $(MAIN_SRC)
>=20
>=20
> And I get the following response:
>=20
> gcc -o cyclic_test cyclic_test.c -I/usr/xenomai/include/cobalt
> -I/usr/xenomai/in
> clude -march=3Darmv7-a -mfpu=3Dvfp3 -D_GNU_SOURCE -D_REENTRANT
> -fasynchronous-unwind
> -tables -D__COBALT__ -Wl,--no-as-needed
> -Wl,@/usr/xenomai/lib/modechk.wrappers
> /usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=3Dmain
> -Wl,--dynamic-list=3D/usr/xen
> omai/lib/dynlist.ld -L/usr/xenomai/lib -lcobalt -lmodechk -lpthread -lrt
> -march=3D
> armv7-a -mfpu=3Dvfp3
> /tmp/ccNmb1Fm.o: In function `rt_timer_read':
> cyclic_test.c:(.text+0xe): undefined reference to `clockobj_get_time'
> cyclic_test.c:(.text+0x20): undefined reference to `alchemy_clock'
> /tmp/ccNmb1Fm.o: In function `loop_task_proc':
> cyclic_test.c:(.text+0x32): undefined reference to `rt_task_self'
> cyclic_test.c:(.text+0x40): undefined reference to `rt_task_inquire'
> cyclic_test.c:(.text+0x76): undefined reference to `rt_task_set_periodic'
> cyclic_test.c:(.text+0xc4): undefined reference to `rt_task_wait_period'
> /tmp/ccNmb1Fm.o: In function `main':
> cyclic_test.c:(.text+0x11c): undefined reference to `rt_task_create'
> cyclic_test.c:(.text+0x12e): undefined reference to `rt_task_start'
> collect2: error: ld returned 1 exit status
> Makefile:10: recipe for target 'cyclic_test' failed
> make: *** [cyclic_test] Error 1
>=20
> Can you advise me plase?
> Thank you very much.

You are missing "-lalchemy" in your linker flags. Normally, xeno-config
--skin=3Dalchemy --ldflags returns this, at least for me here with both
latest stable and the 3.1-rc. What version are you using?

Jan

--=20
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

