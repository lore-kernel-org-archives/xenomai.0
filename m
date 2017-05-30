References: <75c20daf-b35f-116e-11c5-75f6fcfc10ed@gmail.com>
From: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Message-ID: <0532cb51-4e2b-f600-b866-f60bd3d13c80@numalliance.com>
Date: Tue, 30 May 2017 09:22:52 +0200
MIME-Version: 1.0
In-Reply-To: <75c20daf-b35f-116e-11c5-75f6fcfc10ed@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] dlopen failing when using shared library on xenomai
 3.0.4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Fyleo <fyleo45@gmail.com>, xenomai@xenomai.org

Hi,

Why don't you link the shared lib at compilation ?

Regards,
S.Ancelot

Le 29/05/2017 =C3=A0 23:19, Fyleo a =C3=A9crit :
> Hello all,
>
> I'm trying to port machinekit (machinekit.io) to xenomai 3.0.4 which=20
> support only xenomai 2.6.4 for the moment.
>
> This software is design this way :
>
> A : main executable
>
> B : shared library abstracting thread API, with one library for posix,=20
> for xenomai, ...
>
> The xenomai B library is linked against alchemy, copperplate, ...=20
> (xeno-config --ldflags --auto-init-solib --skin=3Dalchemy)
>
> The program works in a way that, at start time, it load with dlopen=20
> the configured API (B).
>
> My problem is that dlopen(with RTLD_GLOBAL|RTLD_NOW) fail with the=20
> error : "/usr/lib/libcopperplate.so.0: undefined symbol: main"
>
> Here is the simplified test case to reproduce the problem :
>
> main.c:
>     #include <stdio.h>
>     #include <stdlib.h>
>     #include <dlfcn.h>
>
>     int main(int argc, char *const argv[])
>     {
>         void *handle;
>
>         handle =3D dlopen("./ulapi-xenomai.so", RTLD_GLOBAL|RTLD_NOW);
>         if (!handle) {
>             fprintf(stderr, "%s\n", dlerror());
>             exit(EXIT_FAILURE);
>         }
>
>         dlclose(handle);
>         exit(EXIT_SUCCESS);
>     }
>
> gcc main.c -o testcase -ldl
> gcc -Wl,-soname,ulapi-xenomai.so -shared -o ulapi-xenomai.so=20
> `xeno-config --ldflags --auto-init-solib --skin=3Dalchemy`
>
> run testcase
>
> I am missing something or is there a solution that doesn't imply to=20
> use RTLD_LAZY ?
>
> my xeno-config --info
> Xenomai version: Xenomai/cobalt v3.0.4
> Linux beaglebone 4.4.62-ti-xenomai-r105 #1 SMP Wed May 24 00:09:09 UTC=20
> 2017 armv7l GNU/Linux
> Kernel parameters: console=3DttyO0,115200n8=20
> capemgr.disable_partno=3DBB-BONELT-HDMI=20
> bone_capemgr.uboot_capemgr_enabled=3D1 root=3D/dev/mmcblk0p1 ro=20
> rootfstype=3Dext4 rootwait coherent_pool=3D1M net.ifnames=3D0 quiet
> I-pipe release #7 detected
> Cobalt core 3.0.4 detected
> Compiler: gcc version 4.9.2 (Debian 4.9.2-10)
> Build args: --prefix=3D/usr --includedir=3D/usr/include/xenomai=20
> --mandir=3D/usr/share/man --with-testdir=3D/usr/lib/xenomai/testsuite=20
> --enable-dlopen-libs --enable-smp --build arm-linux-gnueabihf=20
> build_alias=3Darm-linux-gnueabihf
>
> Regards,
>
> Fyleo
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

