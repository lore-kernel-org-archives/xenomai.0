From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Subject: RE: about RTnet* smokey test skipped issue on Qemu
Date: Tue, 3 Aug 2021 06:46:02 +0000
Message-ID: <BN9PR11MB5227EDF8B90BDC8D4B49004DF2F09@BN9PR11MB5227.namprd11.prod.outlook.com>
References: <BN9PR11MB5227AA25E0CD6ACB67B8CE8EF2F09@BN9PR11MB5227.namprd11.prod.outlook.com>
 <769057a8-3bfe-efcd-0975-a94734846dc3@siemens.com>
In-Reply-To: <769057a8-3bfe-efcd-0975-a94734846dc3@siemens.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>



>-----Original Message-----
>From: Jan Kiszka <jan.kiszka@siemens.com>=20
>Sent: Tuesday, August 3, 2021 12:59 PM
>To: Chen, Hongzhan <hongzhan.chen@intel.com>; xenomai@xenomai.org
>Subject: Re: about RTnet* smokey test skipped issue on Qemu
>
>On 03.08.21 06:31, Chen, Hongzhan wrote:
>> Firstly, I found that all smokey tests including RTnet* pass on bare
>> metal x86 platform
>> but three RTnet* related test items  are skipped on Qemu.  After further
>> debug, actually there is
>> no supported rtnet device found on Qemu with current network setting
>> when xenomai image
>> is running over even we already enable all supported rtnet devices on
>> xenomai so that
>> the test is skipped on qemu.
>>=20
>> After I replace virtio-net-pci with e1000 device like [1] patch ,
>> rt_e1000 and rtnet modules
>> would be automatically loaded by udevd so that rtnet* test item can go
>> on without test skipped issue.
>
>By default, we are only doing loopback tests in smokey, nothing that
>requires a real NIC driver to be loaded. These are the modules loaded
>during a test with udp:
>
>Module                  Size  Used by
>rtudp                  24576  0
>rtipv4                 49152  1 rtudp
>rt_loopback            16384  1
>rtnet                  81920  3 rtipv4,rtudp,rt_loopback
>
>You can set the rtnet_driver and rtnet_interface parameters to switch to
>real NICs, but that is not happening during a default xeno-test run.

The problem is that rtnet module is not loaded individually by current syst=
em but because
RT NIC device driver module depend on it and then rtnet module will be load=
ed when specific
RT NIC device driver module is modprobed after triggered by udev service. T=
hat means
We have to add and modify something to explicitly load rtnet module by defa=
ult when system bootup=20
if we do not want to depends on real NIC in our case. For example we may ad=
d corresponding *.conf =20
like [3] to make  rtnet load automatically when system bootup in our case?


[3]:
/etc/modules-load.d/*.conf

/run/modules-load.d/*.conf

/usr/lib/modules-load.d/*.conf

>
>> But system report error like  [2] because there is late packet.  It
>> seems that bad rtnet performance
>> with virtual network on Qemu may block our RTnet smokey test?  Any
>> Suggestions?
>>=20
>
>There is open issue
>https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/13 on that.

So we need to skip performance check like late packet check in our case whe=
n we pass --vm to smokey test?

Regards

Hongzhan Chen
>
>Jan
>
>--=20
>Siemens AG, T RDA IOT
>Corporate Competence Center Embedded Linux

