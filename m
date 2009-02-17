Message-ID: <499AC754.4080904@domain.hid>
Date: Tue, 17 Feb 2009 14:19:00 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20090217094750.46fb937d@domain.hid> <499A8E53.303@domain.hid>
	<0d559346cf77157cb52c39a05fc23429@domain.hid>
In-Reply-To: <0d559346cf77157cb52c39a05fc23429@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Adeos-main] I.MXL won't boot after patching with
	adeos-ipipe-2.6.27-arm-1.12-00.patch
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: =?UTF-8?B?R3dlbmhhw6ts?= <gwen@domain.hid>
Cc: adeos-main@gna.org

Gwenha=C3=ABl wrote:
> On Tue, 17 Feb 2009 10:15:47 +0000, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> gwenhael.goavec wrote:
>>> Hello,
>>>
>>> I wish to test adeos and Xenomai on Arm9 I.MXL(MC9328) based
>>> platform. I have already tested with linux-2.6.26.5 and
>>> linux-2.6.24.3. Ipipe worked fine and the system has booted
>>> correctly.
>>> But with linux-2.6.27.13 and others 2.6.27.XX System
>>> won't boot. The last message I have is :=20
>>>
>>> BIOS> boot                                                           =
  =20
>=20
>>> ## Booting kernel from Legacy Image at 100a0000 ...
>>>    Image Name:   Linux-2.6.27.13                  =20
>>>    Created:      2009-02-16  21:03:08 UTC
>>>    Image Type:   ARM Linux Kernel Image (uncompressed)
>>>    Data Size:    1329204 Bytes =3D  1.3 MB             =20
>>>    Load Address: 08008000              =20
>>>    Entry Point:  08008000
>>>    Verifying Checksum ... OK
>>>    Loading Kernel Image ... OK
>>> OK                           =20
>>>  =20
>>> Starting kernel ...
>>>                   =20
>>> Uncompressing
>>>
> Linux..................................................................=
=2E....................
>>> done, booting the kernel.
>>>
>>> kernel_start() is never called.
>>>
>>> However, when CONFIG_IPIPE is not active, the system works
>>> well!
>>>
>>> Do someone have the same problem ?
>>> What is the solution for having  linux-2.6.27 working
>>> with this processor ?
>>> Thank you very much.
>> What exactly is the support selected in the Linux kernel for this
>> processor? Could you try the printascii in printk trick to see exactly=

>> where the boot fails?
>=20
> I have selected IMX for the processor type.
>=20
> I have applied the printk trick but I have no new informations on the
> terminal. The problem seems to being between decompress_kernel() and
> start_kernel().

Then you have a problem in the memory layout. Check all the addresses
and see if no two zones overlap.

--=20
                                                 Gilles.


