Date: Mon, 12 Mar 2018 14:04:31 +0200 (EET)
From: =?windows-1251?B?2OXi9+Xt6u4g0uDw4PEgw/Do4+7w/OXi6Pc=?=
 <shevchenko.taras@triolcorp.com.ua>
Message-ID: <1068207989.3534007.1520856271605.JavaMail.zimbra@triolcorp.com.ua>
In-Reply-To: <2133725225.3337414.1520682010809.JavaMail.zimbra@triolcorp.com.ua>
References: <2114790524.3335654.1520673402537.JavaMail.zimbra@triolcorp.com.ua>
 <0810a571-c3a3-5e17-7054-42ec68b9787a@xenomai.org>
 <257160912.3337070.1520678054386.JavaMail.zimbra@triolcorp.com.ua>
 <7d4026b4-7980-1457-a3d0-97028af0d658@xenomai.org>
 <2133725225.3337414.1520682010809.JavaMail.zimbra@triolcorp.com.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] -Werror=format-security
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai <xenomai@xenomai.org>

I managed to do it
need to use such way to build:

make bzImage modules
make modules_install
make install

not this=20
sudo apt install kernel-package
CONCURRENCY_LEVEL=3D$(nproc) make-kpkg --rootcmd fakeroot --initrd kernel_i=
mage kernel_headers

Now I get folders /lib/modules/4.9.51-xenomai/build
and add this Path to makefile  , and now I can compile rtdm module
Thank for everybody who help!

----- Original Message -----
From: "=D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1 =C3=F0=E8=E3=EE=F0=FC=E5=E2=
=E8=F7" <shevchenko.taras@triolcorp.com.ua>
To: "Philippe Gerum" <rpm@xenomai.org>
Cc: "xenomai" <xenomai@xenomai.org>
Sent: Saturday, March 10, 2018 1:40:10 PM
Subject: Re: [Xenomai] -Werror=3Dformat-security

Yes, now its build from repo without problems
/usr/xenomai/sbin# ./version=20
Xenomai/cobalt v3.0.6 --#0246d22(2018-03-10 10:52:53 +0100)

Sorry , but in your instruction not all cleared for me (no knowledge enough=
) ,could we verify steps order ?
in /home/me/
get kernel source 4.9.51
    wget https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.51.tar.gz
    tar xf linux-4.9.38.tar.gz
get patch
    cd linux-4.9.51
    wget https://xenomai.org/downloads/ipipe/v4.x/x86/ipipe-core-4.9.51-x86=
-4.patch
get xenomai
    git clone https://git.xenomai.org/xenomai-3.git
run script
    ../xenomai-3/scripts/prepare-kernel.sh --arch=3Dx86_64 --ipipe=3Dipipe-=
core-4.9.51-x86-4.patch   //  should I add  --linux=3D/home/me/linux-4.9.51=
 =20

Take the actual working config :
     yes "" | make oldconfig
Configure kernel
     make menuconfig
Build kernel =20
     sudo apt install kernel-package
     CONCURRENCY_LEVEL=3D$(nproc) make-kpkg --rootcmd fakeroot --initrd ker=
nel_image kernel_headers  //  or make bzImage modules  is correct ?
     cd ..
      sudo dpkg -i linux-headers-4.9.51-xenomai-10.00.Custom_amd64.deb linu=
x-image-4.9.38-xenomai-10.00.Custom_amd64.deb

Configure Xenomai
cd xenomai-3
     ./scripts/bootstrap
     ./configure --with-pic --with-core=3Dcobalt --enable-smp --disable-tls=
 --enable-dlopen-libs
     make -j`nproc`
     sudo make install

enjoy, I hope )))



----- Original Message -----
From: "Philippe Gerum" <rpm@xenomai.org>
To: "=D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1 =C3=F0=E8=E3=EE=F0=FC=E5=E2=
=E8=F7" <shevchenko.taras@triolcorp.com.ua>
Cc: "xenomai" <xenomai@xenomai.org>
Sent: Saturday, March 10, 2018 12:46:17 PM
Subject: Re: [Xenomai] -Werror=3Dformat-security

On 03/10/2018 11:34 AM, =D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1 =C3=F0=E8=
=E3=EE=F0=FC=E5=E2=E8=F7 wrote:
>=20
>=20
> I cloned repo just yesterday
> and now this issue is not fixed
>=20
> so i decide to use   xenomai-3.0.6.tar.bz2  and successfully install it
> /usr/xenomai/sbin# ./version=20
> Xenomai/cobalt v3.0.6
>=20
> ./xeno-config=20
> xeno-config --verbose
>         --core=3Dcobalt
>         --version=3D"3.0.6"
>         --cc=3D"gcc"
>         --ccld=3D"/usr/xenomai/bin/wrap-link.sh gcc"
>         --arch=3D"x86"
>         --prefix=3D"/usr/xenomai"
>         --library-dir=3D"/usr/xenomai/lib"
>=20
>=20
> but the same errors get when compile rtdm modules and  add #include <rtdm=
/rtdm.h> in my *.c
>=20
> I need help cause ready to give up
http://git.xenomai.org/xenomai-3.git/log/, first 2 commits, dated
_today_. As mentioned in my latest e-mail, please _pull_ from the repo,
which means that an update is present.

http://xenomai.org/installing-xenomai-3-x/#Installing_the_Cobalt_core

Just follow the steps mentioned above carefully, do not deviate from
them. All should be fine.

--=20
Philippe.

_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
https://xenomai.org/mailman/listinfo/xenomai

