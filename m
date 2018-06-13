MIME-Version: 1.0
In-Reply-To: <CAFUnMknE0yE7tFKtKrG5x+x9UoA7yHQR-aEtSRMEo__nG=EtcQ@mail.gmail.com>
References: <CAFUnMknE0yE7tFKtKrG5x+x9UoA7yHQR-aEtSRMEo__nG=EtcQ@mail.gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Wed, 13 Jun 2018 13:39:53 -0400
Message-ID: <CALLqZ8TQeEkz_UpH-a4H+Kt7DN13XVH=WkFxn8La2kozOK=B+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] how to install the following modules xeno_rtdm
 xeno_hal xeno_nucleus to use RTnet
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ashok kumar <ashokkumar.bb@gmail.com>
Cc: "J. Kiszka" <jan.kiszka@siemens.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

Do you have the modules enabled in the CONFIG? How are you configuring
your kernel?

-Greg

On Wed, Jun 13, 2018 at 1:06 AM, Ashok kumar <ashokkumar.bb@gmail.com> wrot=
e:
> Hi,
>
> I am using xenomai -2.6.2.1 and I have patched the xenomai -2.6.2.1
> with linux kernel 3.4.6
> and I installed using the following commands
>
> sudo make-kpkg --bzimage --initrd --append-to-version=3D-xenomai-2.6.4
> -j8 kernel-image kernel-headers modules
> # Install kernel
> cd ..
> sudo dpkg -i linux-image-*.deb
> sudo dpkg -i linux-headers-*.deb
>
> sudo ../xenomai-2.6.4/configure --enable-shared --enable-smp --enable-x86=
-sep
> sudo make -j8
> sudo make install
>
> cd /etc/ld.so.conf.d/
> sudo touch xenomai.conf
> sudo sh -c "echo '/usr/xenomai/lib' >> xenomai.conf"
> sudo ldconfig
>
> echo "export PATH=3D$PATH:/usr/xenomai/bin" >> ~/.bashrc
> # echo "export PATH=3D$PATH:/usr/xenomai/bin:/usr/xenomai/lib:/usr/xenoma=
i/include"
>>> ~/.bashrc
> sudo su
> echo "export PATH=3D$PATH:/usr/xenomai/bin" >> ~/.bashrc
> # echo "export PATH=3D$PATH:/usr/xenomai/bin:/usr/xenomai/lib:/usr/xenoma=
i/include"
>>> ~/.bashr
> ************************************************* ***********************=
*****
> after installing xenomai-2.6.4 with linux kernel 3.4.6
> I am not able to get the module in the xenomai directory, to use  RTnet
>
> =E2=80=8CI  required to load the modules  for RTnet operations
> sudo modprobe xeno_rtdm
> sudo modprobe xeno_hal
> sudo modprobe xeno_nucleus
>
> after executing this command I am using lsmod to view these modules
> ,but the modules are not getting loaded.
>
> In /usr/xenomai I am not able to see the modules.
>
> help me to get the following module xeno_rtdm, xeno_hal, xeno_nucleus
> install to use the rtnet
>
>
> Thank you
> R. Ashokkumar
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

