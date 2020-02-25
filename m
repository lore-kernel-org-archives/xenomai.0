Date: Tue, 25 Feb 2020 08:48:43 -0600 (CST)
From: Per Oberg <pero@wolfram.com>
Message-ID: <1987057484.452222.1582642123490.JavaMail.zimbra@wolfram.com>
In-Reply-To: <984885226.450915.1582641841732.JavaMail.zimbra@wolfram.com>
References: <2eb86315-dc9d-1096-14a7-c3bd2b32a668@b-tu.de>
 <1021522818.445580.1582639862351.JavaMail.zimbra@wolfram.com>
 <cb174dde-7680-ba74-9aca-7da7adc870dc@b-tu.de>
 <984885226.450915.1582641841732.JavaMail.zimbra@wolfram.com>
Subject: Re: Xenomai RTnet - Kernel module not loading
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Benji <miethben@b-tu.de>
Cc: xenomai <xenomai@xenomai.org>





----- Den 25 feb 2020, p=C3=A5 kl 15:44, Per =C3=96berg pero@wolfram.com sk=
rev:

> ----- Den 25 feb 2020, p=C3=A5 kl 15:24, Benji miethben@b-tu.de skrev:

> > On 2/25/20 3:11 PM, Per Oberg wrote:

> > > ----- Den 25 feb 2020, p=C3=A5 kl 15:02, xenomai xenomai@xenomai.org =
skrev:

> > >> Hello all,

> > >> I'm a student working on a project comparing different real time OS
> > >> approaches. Trying to get RTnet working on a Xenomai Cobalt kernel, =
but
> > >> stuck on loading required kernel modules.

> > >> System is running on Ubuntu 18.04 and uses following versions to bui=
ld
> > >> Xenomai kernel:

> > >> Linux Kernel: 4.19.89
> > >> IPIPE: 4.19.89
> > >> Xenomai: 3.1

> > >> Kernel is build as described in Xenomai wiki and configured with RTn=
et
> > >> as kernel module.

> > >> After installing xenomai kernel and checking the module, everything
> > >> looks ok.

> > >>> $ sudo modinfo /lib/modules/4.19.89/kernel/drivers/xenomai/net/stac=
k/rtnet.ko
> > >>> filename: /lib/modules/4.19.89/kernel/drivers/xenomai/net/stack/rtn=
et.ko
> > >>> description: RTnet stack core
> > >>> license: GPL
> > >>> srcversion: E1B65CA6F28C7B08C111720
> > >>> depends:
> > >>> retpoline: Y
> > >>> intree: Y
> > >>> name: rtnet
> > >>> vermagic: 4.19.89 SMP mod_unload
> > >>> signat: PKCS#7
> > >>> signer:
> > >>> sig_key:
> > >>> sig_hashalgo: md4
> > >>> parm: stack_mgr_prio:Priority of the stack manager task (uint)
> > >>> parm: socket_rtskbs:Default number of realtime socket buffers in so=
cket pools
> > >>> (uint)
> > >>> parm: global_rtskbs:Number of realtime socket buffers in global poo=
l (uint)
> > >>> parm: device_rtskbs:Number of additional global realtime socket buf=
fers per
> > >>> network adapter (uint)

> > >> But kernel module can't be loaded.

> > >>> $ sudo insmod /lib/modules/4.19.89/kernel/drivers/xenomai/net/stack=
/rtnet.ko
> > >>> insmod: ERROR: could not insert module
> > >>> /lib/modules/4.19.89/kernel/drivers/xenomai/net/stack/rtnet.ko: Fun=
ction not
> > >>> implemented

> > >> Has anybody a hint how to build/ load RTnet kernel module properly?

> >> Can you load any other modules? Did you include "loadable module suppo=
rt" in
> > > your kernel config?

> > > If you do a simple "lsmod", does it say anything about other loaded m=
odules ?

> > >> Thanks
> > >> Benji

> > > Per =C3=96berg

> > Loading other modules is possible. But rtnet is not listed as a loadabl=
e
> > module, see below.
> > In kernel config 'MODULE_UNLOAD' and 'MODULES' are set.

> > > Module Size Used by
> > > snd_hda_codec_hdmi 49152 1
> > > snd_hda_codec_realtek 110592 1
> > > snd_hda_codec_generic 73728 1 snd_hda_codec_realtek
> > > rfcomm 69632 16
> > > cmac 16384 1
> > > bnep 20480 2
> > > intel_rapl 20480 0
> > > x86_pkg_temp_thermal 16384 0
> > > intel_powerclamp 16384 0
> > > coretemp 16384 0
> > > arc4 16384 2
> > > i915 1703936 6
> > > iwlmvm 372736 0
> > > mac80211 786432 1 iwlmvm
> > > kvm_intel 184320 0
> > > kvm 622592 1 kvm_intel
> > > iwlwifi 303104 1 iwlmvm
> > > cec 49152 1 i915
> > > rc_core 45056 1 cec
> > > drm_kms_helper 167936 1 i915
> > > snd_hda_intel 40960 3
> > > ...

> Then I would say that you have a mismatch between the versioning informat=
ion in
> your module and kernel build. Are they built together or separately?

> Can you please provide information from "uname -a" and "cat /proc/version=
" ?

> > Thanks
> > Benji

> Best regards
> Per =C3=96berg

Oh, and have you tried using "sudo modprobe rtnet". This command is a bit s=
marter and loads all the dependencies. (It looks in modules.dep that is gen=
erated by "depmod -a")

If there are missing dependencies you should get a warning of you run "depm=
od -a"

Per =C3=96berg

