MIME-Version: 1.0
From: Matheus Leitzke <senseipinto@gmail.com>
Date: Sat, 11 Jul 2020 14:42:59 -0300
Message-ID: <CAKP50V6HKWY9p3jnP8EgEVeoqJj9rtUbSK2k8eqVs-y40cK8MA@mail.gmail.com>
Subject: Problem when compiling Xenomai 3.0.8 user libraries with enable-debug
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I am setting my Xenomai user libraries with:

./configure --host=3Darm-linux-gnueabihf --enable-smp --enable-debug=3Dfull
--enable-pshared --with-core=3Dcobalt

But when I use make to compile the user libraries, the following error is
throw:

make[5]: Entering directory
'/home/matheus/Downloads/xenomai-3.0.8/lib/cobalt/arch/arm'
  CC       libarch_la-features.lo
features.c: In function =E2=80=98cobalt_check_features=E2=80=99:
features.c:78:1: error: r7 cannot be used in asm here
 }

This error is thrown because the r7 register is being used in macro
XENOMAI_SYSCALL2 inside cobalt_check_features from features,c cobalt file.

I try to follow this suggestion:
https://tls.mbed.org/kb/development/arm-thumb-error-r7-cannot-be-used-in-as=
m-here.
However, when inserting "-fomit-frame-pointer" on Makefile c flags
variables, this has no effect.

This error occurs only when I set --enable-debug flag.

Do you have any suggestions?

Matheus
