From: =?iso-8859-1?Q?H=E4nel-Baas=2C_Alexander?=
 <alexander.haenel-baas@sieb-meyer.de>
Date: Thu, 30 Mar 2017 07:32:44 +0000
Message-ID: <9BA84827B30CBE4996725F98F7DC912365354EB5@SMExchange01.siebmeyer.org>
Content-Language: de-DE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] _X86_VSYSCALL on arm ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

our xenomai application shows CONFIG_XENO_X86_VSYSCALL=3D1, but is is runni=
ng on arm machine.

We compile the app on a debian x86 host machine with the OSELAS.Toolchain-2=
016.06 (arm-v7a-linux-gnueabi) for=20
running on the arm Layerscape (ls1021a) target.
To get the proper clfags we ask xeno-config with "--skin=3Dalchemy --cflags=
".

My issue :
Is CONFIG_XENO_X86_VSYSCALL=3D1 for an arm binary good?
Where is the step to configure this flag?=20

When I pass --dump-config to the app, the following config was shown:

./g3t_rtdm_alex_test --dump-config
based on Xenomai/cobalt v3.0.3
CONFIG_MMU=3D1
CONFIG_SMP=3D1
CONFIG_XENO_BUILD_ARGS=3D" 'CFLAGS=3D-march=3Darmv7-a -mfpu=3Dvfp3 -D_FILE_=
OFFSET_BITS=3D64 -Wno-error=3Dold-style-declaration -Wno-error=3Ddiscarded-=
qualifiers' '--host=3Darm-v7a-linux-gnueabi' '--build=3Di686-host-linux-gnu=
' '--enable-pshared' '--enable-smp' '--disable-tls' '--enable-dlopen-libs' =
'--disable-doc-install' 'build_alias=3Di686-host-linux-gnu' 'host_alias=3Da=
rm-v7a-linux-gnueabi' 'CC=3Darm-v7a-linux-gnueabi-gcc' 'CPP=3Darm-v7a-linux=
-gnueabi-cpp' 'PKG_CONFIG=3D/opt/g3DevelBase/g3Toolchain/g3Bsp/sd3XenoArmLs=
.Bsp.V2/platform-sm-arm/sysroot-cross/bin/arm-v7a-linux-gnueabi-pkg-config'=
 'PKG_CONFIG_PATH=3D''PKG_CONFIG_LIBDIR=3D/opt/g3DevelBase/g3Toolchain/g3Bs=
p/sd3XenoArmLs.Bsp.V2/platform-sm-arm/sysroot target/lib/pkgconfig:/opt/g3D=
evelBase/g3Toolchain/g3Bsp/sd3XenoArmLs.Bsp.V2/platform-sm-arm/sysroot-targ=
et/usr/lib/pkgconfig:/opt/g3DevelBase/g3Toolchain/g3Bsp/sd3XenoArmLs.Bsp.V2=
/platform-sm-arm/sysroot-target/share/pkgconfig:/opt/g3DevelBase/g3Toolchai=
n/g3Bsp/sd3XenoArmLs.Bsp.V2/platform-sm-arm/sysroot-target/usr/share/pkgcon=
fig'"
CONFIG_XENO_BUILD_STRING=3D"i686-host-linux-gnu"
CONFIG_XENO_COBALT=3D1
CONFIG_XENO_COMPILER=3D"gcc version 5.4.0 (OSELAS.Toolchain-2016.06.0) "
CONFIG_XENO_DEFAULT_PERIOD=3D1000000
CONFIG_XENO_FORTIFY=3D1
CONFIG_XENO_HOST_STRING=3D"arm-v7a-linux-gnueabi"
CONFIG_XENO_LIBS_DLOPEN=3D1
CONFIG_XENO_LORES_CLOCK_DISABLED=3D1
CONFIG_XENO_PREFIX=3D"/usr/xenomai"
CONFIG_XENO_PSHARED=3D1
CONFIG_XENO_RAW_CLOCK_ENABLED=3D1
CONFIG_XENO_REVISION_LEVEL=3D3
CONFIG_XENO_SANITY=3D1
CONFIG_XENO_TLSF=3D1
CONFIG_XENO_TLS_MODEL=3D"global-dynamic"
CONFIG_XENO_UAPI_LEVEL=3D14
CONFIG_XENO_VERSION_MAJOR=3D3
CONFIG_XENO_VERSION_MINOR=3D0
CONFIG_XENO_VERSION_NAME=3D"Groovy Cosmic Halo"
CONFIG_XENO_VERSION_STRING=3D"3.0.3"
CONFIG_XENO_X86_VSYSCALL=3D1
---
CONFIG_XENO_ASYNC_CANCEL is OFF
CONFIG_XENO_COPPERPLATE_CLOCK_RESTRICTED is OFF
CONFIG_XENO_DEBUG is OFF
CONFIG_XENO_DEBUG_FULL is OFF
CONFIG_XENO_MERCURY is OFF
CONFIG_XENO_REGISTRY is OFF
CONFIG_XENO_REGISTRY_ROOT is OFF
CONFIG_XENO_VALGRIND_API is OFF
CONFIG_XENO_WORKAROUND_CONDVAR_PI is OFF
---
PTHREAD_STACK_DEFAULT=3D65536
AUTOMATIC_BOOTSTRAP=3D1


regards
Alexander H=E4nel-Baas


