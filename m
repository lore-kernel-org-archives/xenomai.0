Subject: Re: Xenomai RTnet - Kernel module not loading
References: <2eb86315-dc9d-1096-14a7-c3bd2b32a668@b-tu.de>
 <1021522818.445580.1582639862351.JavaMail.zimbra@wolfram.com>
From: Benji <miethben@b-tu.de>
Message-ID: <cb174dde-7680-ba74-9aca-7da7adc870dc@b-tu.de>
Date: Tue, 25 Feb 2020 15:24:37 +0100
MIME-Version: 1.0
In-Reply-To: <1021522818.445580.1582639862351.JavaMail.zimbra@wolfram.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Per Oberg <pero@wolfram.com>
Cc: xenomai <xenomai@xenomai.org>

On 2/25/20 3:11 PM, Per Oberg wrote:
>=20
> ----- Den 25 feb 2020, p=C3=A5 kl 15:02, xenomai xenomai@xenomai.org sk=
rev:
>=20
>> Hello all,
>=20
>> I'm a student working on a project comparing different real time OS
>> approaches. Trying to get RTnet working on a Xenomai Cobalt kernel, bu=
t
>> stuck on loading required kernel modules.
>=20
>> System is running on Ubuntu 18.04 and uses following versions to build
>> Xenomai kernel:
>=20
>> Linux Kernel: 4.19.89
>> IPIPE: 4.19.89
>> Xenomai: 3.1
>=20
>> Kernel is build as described in Xenomai wiki and configured with RTnet
>> as kernel module.
>=20
>> After installing xenomai kernel and checking the module, everything
>> looks ok.
>=20
>>> $ sudo modinfo /lib/modules/4.19.89/kernel/drivers/xenomai/net/stack/=
rtnet.ko
>>> filename: /lib/modules/4.19.89/kernel/drivers/xenomai/net/stack/rtnet=
.ko
>>> description: RTnet stack core
>>> license: GPL
>>> srcversion: E1B65CA6F28C7B08C111720
>>> depends:
>>> retpoline: Y
>>> intree: Y
>>> name: rtnet
>>> vermagic: 4.19.89 SMP mod_unload
>>> signat: PKCS#7
>>> signer:
>>> sig_key:
>>> sig_hashalgo: md4
>>> parm: stack_mgr_prio:Priority of the stack manager task (uint)
>>> parm: socket_rtskbs:Default number of realtime socket buffers in sock=
et pools
>>> (uint)
>>> parm: global_rtskbs:Number of realtime socket buffers in global pool =
(uint)
>>> parm: device_rtskbs:Number of additional global realtime socket buffe=
rs per
>>> network adapter (uint)
>=20
>> But kernel module can't be loaded.
>=20
>>> $ sudo insmod /lib/modules/4.19.89/kernel/drivers/xenomai/net/stack/r=
tnet.ko
>>> insmod: ERROR: could not insert module
>>> /lib/modules/4.19.89/kernel/drivers/xenomai/net/stack/rtnet.ko: Funct=
ion not
>>> implemented
>=20
>> Has anybody a hint how to build/ load RTnet kernel module properly?
>=20
> Can you load any other modules? Did you include "loadable module suppor=
t" in your kernel config?=20
>=20
> If you do a simple "lsmod", does it say anything about other loaded mod=
ules ?
>=20
>=20
>> Thanks
>> Benji
>=20
>=20
> Per =C3=96berg=20
>=20

Loading other modules is possible. But rtnet is not listed as a loadable
module, see below.
In kernel config 'MODULE_UNLOAD' and 'MODULES' are set.

> Module                  Size  Used by
> snd_hda_codec_hdmi     49152  1
> snd_hda_codec_realtek   110592  1
> snd_hda_codec_generic    73728  1 snd_hda_codec_realtek
> rfcomm                 69632  16
> cmac                   16384  1
> bnep                   20480  2
> intel_rapl             20480  0
> x86_pkg_temp_thermal    16384  0
> intel_powerclamp       16384  0
> coretemp               16384  0
> arc4                   16384  2
> i915                 1703936  6
> iwlmvm                372736  0
> mac80211              786432  1 iwlmvm
> kvm_intel             184320  0
> kvm                   622592  1 kvm_intel
> iwlwifi               303104  1 iwlmvm
> cec                    49152  1 i915
> rc_core                45056  1 cec
> drm_kms_helper        167936  1 i915
> snd_hda_intel          40960  3
> ...

Thanks
Benji

