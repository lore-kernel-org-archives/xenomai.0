Date: Mon, 22 Feb 2021 07:14:45 -0300
From: Gabriel Dinse <gabriel_dinse@hotmail.com>
Subject: Re: Incompatible pointer type error when compiling kernel
Message-ID: <SN6PR08MB56613FE5201E248CC7901EB093819@SN6PR08MB5661.namprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
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

 > This is a 32-bit build running on the rpi3?
Yes, it is

 > I have some ipipe fixes coming, but I don't think these are ipipe=20
related.
 > Can you show how you patched and built your kernel? I'll try to=20
reproduce
 > on my end.  What compiler are you using?

For patching the kernel, I did:
xenomai-3.1 on =EE=82=A0 main =E2=9E=9C ./scripts/prepare-kernel.sh=20
--linux=3D~/Projects/linux-kernels/linux-5.4.93-ipipe --arch=3Darm=20
--ipipe=3D~/Projects/linux-kernels/ipipe-core-5.4.93-arm-0.patch

The config I'm using is multi_v7_defconfig modified a little bit. The=20
same configuration was fine for Vanilla kernel using the same version=20
(5.4.93), as I was pretending to compare both.

Toolchain I'm using, selected directly on buildroot-2020.02.11 long=20
term is: Linaro ARM 2018.05

