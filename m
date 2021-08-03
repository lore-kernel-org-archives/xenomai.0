Subject: Re: about RTnet* smokey test skipped issue on Qemu
References: <BN9PR11MB5227AA25E0CD6ACB67B8CE8EF2F09@BN9PR11MB5227.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <769057a8-3bfe-efcd-0975-a94734846dc3@siemens.com>
Date: Tue, 3 Aug 2021 06:58:40 +0200
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB5227AA25E0CD6ACB67B8CE8EF2F09@BN9PR11MB5227.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="windows-1252"
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
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03.08.21 06:31, Chen, Hongzhan wrote:
> Firstly, I found that all smokey tests including RTnet* pass on bare
> metal x86 platform
> but three RTnet* related test items =A0are skipped on Qemu.=A0 After furt=
her
> debug, actually there is
> no supported rtnet device found on Qemu with current network setting
> when xenomai image
> is running over even we already enable all supported rtnet devices on
> xenomai so that
> the test is skipped on qemu.
>=20
> After I replace virtio-net-pci with e1000 device like [1] patch ,
> rt_e1000 and rtnet modules
> would be automatically loaded by udevd so that rtnet* test item can go
> on without test skipped issue.

By default, we are only doing loopback tests in smokey, nothing that
requires a real NIC driver to be loaded. These are the modules loaded
during a test with udp:

Module                  Size  Used by
rtudp                  24576  0
rtipv4                 49152  1 rtudp
rt_loopback            16384  1
rtnet                  81920  3 rtipv4,rtudp,rt_loopback

You can set the rtnet_driver and rtnet_interface parameters to switch to
real NICs, but that is not happening during a default xeno-test run.

> But system report error like =A0[2] because there is late packet. =A0It
> seems that bad rtnet performance
> with virtual network on Qemu may block our RTnet smokey test? =A0Any
> Suggestions?
>=20

There is open issue
https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/13 on that.

Jan

--=20
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

