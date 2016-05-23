Date: Mon, 23 May 2016 09:59:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160523075954.GJ13609@hermes.click-hack.org>
References: <0abe0634dbf999057bf8529e0cc0ecd8@stud.hs-heilbronn.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0abe0634dbf999057bf8529e0cc0ecd8@stud.hs-heilbronn.de>
Subject: Re: [Xenomai] Xenomai on Udoo Neo
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: mfinkbei <mfinkbei@stud.hs-heilbronn.de>
Cc: xenomai@xenomai.org

On Mon, May 23, 2016 at 09:49:18AM +0200, mfinkbei wrote:
> Hi,

Hi,

>=20
> I am writing to request some Details about the Xenomai using for an Udoo=
=20
> Neo.
> In my currently Thesis I'm working for the first time with an real-time=
=20
> System.
> One objective therefore is to install Xenomai 3 on the Udoo Neo board=20
> with an iMX6 multicore Processor.
> For the board exist a Linux-Version on the base of the Linux kernel=20
> 3.14.56.
> For this kernel Version there no i-pipe patch available. This is why I=20
> was looking for differences in the affected Files of the kernel 3.14.44=
=20
> and 3.14.56 and Change the i-pipe-patch when there are differences.
> Afterwards, I was able to patch the Udoo Neo Kernel, to make the config,=
=20
> the bzImage and the modules and Install it from an Computer with=20
> Linux-OS to the SD-Card as described in the Documentation.
> At that time of the Installation I kept on working with the Udoo Neo=20
> Board. For Configuring and building the ARM libraries I use the commands
> ./scripts/bootstrap
> sudo ../configure CFLAGS=3D"-march=3Darmv7-a" LDFLAGS=3D"-march=3Darmv7-a=
"=20
> --with-core=3Dcobalt --enable-smp
>=20
> After the make install Command I wanted to test the Installation with
> dmesg | grep -i xenomai
> where I get the Output
>=20
> [    0.147853] [=1B[01;31m=1B[KXenomai=1B[m=1B[K] scheduling class idle=
=20
> registered.
> [    0.147865] [=1B[01;31m=1B[KXenomai=1B[m=1B[K] scheduling class rt=20
> registered.
> [    0.148004] [=1B[01;31m=1B[KXenomai=1B[m=1B[K] init failed, code -19
>=20
>   the full dmesg output in this time frame is
>=20
> [    0.146610] Bus freq driver module loaded
> [    0.147489] futex hash table entries: 256 (order: 2, 16384 bytes)
> [    0.147909] [Xenomai] scheduling class idle registered.
> [    0.147921] [Xenomai] scheduling class rt registered.
> [    0.148021] I-pipe: high-resolution clock not working

Xenomai on cortex a9 uses the global timer as its high resolution
clock source. AFAICT, you have not enabled the global timer in the
kernel configuration, so you simply need to enable it.

Also note that board-specific kernels drivers have generally a lower
quality than the mainline kernel, because they are not reviewed by
the Linux kernel community. So, rather than working with
board-specific kernel, it is advised to cleanup the board specific
drivers you need and submit them to the mainline kernel, so as to
get reviewed, which improves the drivers quality. And when it is
done, you no longer need the board-specific kernel.

Regards.

--=20
					    Gilles.
https://click-hack.org

