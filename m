Date: Sat, 13 May 2017 12:39:02 +0200 (CEST)
From: g.strobbe@telenet.be
Message-ID: <1591176440.114382494.1494671942694.JavaMail.zimbra@telenet.be>
In-Reply-To: <632ac67c-8bee-3f25-c395-d52c06b5ea81@xenomai.org>
References: <38db19d5-b6c4-1948-b2ce-ef7270350e0b@iit.it>
 <632ac67c-8bee-3f25-c395-d52c06b5ea81@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] linker error installing xenomai-3.0.4 using gcc-6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


----- On May 11, 2017, at 5:25 PM, Philippe Gerum rpm@xenomai.org wrote:

On 05/11/2017 04:43 PM, alessio margan wrote:
> Hi,
>=20
> using gcc-6 to install xenomai 3.0.4 libraries give me errors probably
> due to gcc-6 compiled with --enable-default-pie option.
>=20
> "/usr/bin/ld -r and -pie may not be used together"
>=20
> as workaround I've used gcc-5.
>=20
> How could solve this issue ?
>=20

The configure script considers CC/LD flags which are preset at
invocation time, so you may want to try this:

.../configure CFLAGS=3D-no-pie CXXFLAGS=3D-no-pie LDFLAGS=3D-no-pie <other
switches>

--=20
Philippe.


I had the same problem running on Debian Stretch.

I tried several combinations of CFLAGS=3D-fno-pie -fno-PIE LDFLAGS=3D-no-pi=
e with no succes.

For example:

/configure --with-core=3Dcobalt --enable-smp --enable-pshared CFLAGS=3D"-v =
-fPIC -fno-pie -fno-PIE"  CXXFLAGS=3D"-fno-pie -fno-PIE" LDFLAGS=3D"-no-pie=
 -shared"

results in:

configure: error: cannot run C compiled programs.

I then resulted just like you to installing an older gcc next to the Debian=
 Stretch system gcc-6.3.0

Still interested in the problem I recently downloaded the GCC source code a=
nd ran grep which returned in gcc/defaults.h

/* Default value for flag_pie when flag_pie is initialized to -1:
   --enable-default-pie: Default flag_pie to -fPIE.
   --disable-default-pie: Default flag_pie to 0.
 */
#ifdef ENABLE_DEFAULT_PIE
# ifndef DEFAULT_FLAG_PIE
#  define DEFAULT_FLAG_PIE 2
# endif
#else
# define DEFAULT_FLAG_PIE 0
#endif

I then decided to configure the gcc source code with similar options to the=
 Debian system default GCC except I choose --disable-default-pie

I configured, build, tested and installed in my home directory, nicely sepa=
rated from the Debian system default.

With update-alternatives I can now switch between the two.

capsugel@debian:~$ gcc -v
Using built-in specs.                                                      =
                                                                           =
      =20
COLLECT_GCC=3Dgcc                                                          =
                                                                           =
        =20
COLLECT_LTO_WRAPPER=3D/usr/lib/gcc/x86_64-linux-gnu/6/lto-wrapper          =
                                                                           =
        =20
Target: x86_64-linux-gnu
Configured with: ../src/configure -v --with-pkgversion=3D'Debian 6.3.0-16' =
--with-bugurl=3Dfile:///usr/share/doc/gcc-6/README.Bugs --enable-languages=
=3Dc,ada,c++,java,go,d,fortran,objc,obj-c++ --prefix=3D/usr --program-suffi=
x=3D-6 --program-prefix=3Dx86_64-linux-gnu- --enable-shared --enable-linker=
-build-id --libexecdir=3D/usr/lib --without-included-gettext --enable-threa=
ds=3Dposix --libdir=3D/usr/lib --enable-nls --with-sysroot=3D/ --enable-clo=
cale=3Dgnu --enable-libstdcxx-debug --enable-libstdcxx-time=3Dyes --with-de=
fault-libstdcxx-abi=3Dnew --enable-gnu-unique-object --disable-vtable-verif=
y --enable-libmpx --enable-plugin --enable-default-pie --with-system-zlib -=
-disable-browser-plugin --enable-java-awt=3Dgtk --enable-gtk-cairo --with-j=
ava-home=3D/usr/lib/jvm/java-1.5.0-gcj-6-amd64/jre --enable-java-home --wit=
h-jvm-root-dir=3D/usr/lib/jvm/java-1.5.0-gcj-6-amd64 --with-jvm-jar-dir=3D/=
usr/lib/jvm-exports/java-1.5.0-gcj-6-amd64 --with-arch-directory=3Damd64 --=
with-ecj-jar=3D/usr/share/java/eclipse-ecj.jar --with-target-system-zlib --=
enable-objc-gc=3Dauto --enable-multiarch --with-arch-32=3Di686 --with-abi=
=3Dm64 --with-multilib-list=3Dm32,m64,mx32 --enable-multilib --with-tune=3D=
generic --enable-checking=3Drelease --build=3Dx86_64-linux-gnu --host=3Dx86=
_64-linux-gnu --target=3Dx86_64-linux-gnu
Thread model: posix
gcc version 6.3.0 20170425 (Debian 6.3.0-16)=20
capsugel@debian:~$ sudo update-alternatives --config gcc
There are 2 choices for the alternative gcc (providing /usr/bin/gcc).

  Selection    Path                                                  Priori=
ty   Status
------------------------------------------------------------
* 0            /usr/bin/gcc-6                                         60   =
     auto mode
  1            /home/capsugel/RT/gcc/usr/bin/x86_64-linux-gnu-gcc-6   40   =
     manual mode
  2            /usr/bin/gcc-6                                         60   =
     manual mode

Press <enter> to keep the current choice[*], or type selection number: 1
update-alternatives: using /home/capsugel/RT/gcc/usr/bin/x86_64-linux-gnu-g=
cc-6 to provide /usr/bin/gcc (gcc) in manual mode
capsugel@debian:~$ gcc -v
Using built-in specs.
COLLECT_GCC=3Dgcc
COLLECT_LTO_WRAPPER=3D/home/capsugel/RT/gcc/usr/lib/gcc/x86_64-pc-linux-gnu=
/6.3.0/lto-wrapper
Target: x86_64-pc-linux-gnu
Configured with: /home/capsugel/RT/gcc/source/gcc-6.3.0/configure -v --with=
-pkgversion=3D'RT 2017-05-07' --enable-languages=3Dc,c++ --prefix=3D/home/c=
apsugel/RT/gcc/usr --program-suffix=3D-6 --program-prefix=3Dx86_64-linux-gn=
u- --enable-shared --enable-linker-build-id --libexecdir=3D/home/capsugel/R=
T/gcc/usr/lib --without-included-gettext --enable-threads=3Dposix --libdir=
=3D/home/capsugel/RT/gcc/usr/lib --enable-nls --with-sysroot=3D/ --enable-c=
locale=3Dgnu --enable-libstdcxx-debug --enable-libstdcxx-time=3Dyes --with-=
default-libstdcxx-abi=3Dnew --enable-gnu-unique-object --disable-vtable-ver=
ify --enable-libmpx --enable-plugin --disable-default-pie --with-system-zli=
b --disable-browser-plugin --with-target-system-zlib --enable-multiarch --w=
ith-arch-32=3Di686 --with-abi=3Dm64 --disable-multilib --with-tune=3Dgeneri=
c --enable-checking=3Drelease
Thread model: posix
gcc version 6.3.0 (RT 2017-05-07)=20
capsugel@debian:~$=20

That is what works for me so far.

Gino

