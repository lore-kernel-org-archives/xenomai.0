Date: Tue, 25 Feb 2020 08:11:02 -0600 (CST)
From: Per Oberg <pero@wolfram.com>
Message-ID: <1021522818.445580.1582639862351.JavaMail.zimbra@wolfram.com>
In-Reply-To: <2eb86315-dc9d-1096-14a7-c3bd2b32a668@b-tu.de>
References: <2eb86315-dc9d-1096-14a7-c3bd2b32a668@b-tu.de>
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


----- Den 25 feb 2020, p=C3=A5 kl 15:02, xenomai xenomai@xenomai.org skrev:

> Hello all,

> I'm a student working on a project comparing different real time OS
> approaches. Trying to get RTnet working on a Xenomai Cobalt kernel, but
> stuck on loading required kernel modules.

> System is running on Ubuntu 18.04 and uses following versions to build
> Xenomai kernel:

> Linux Kernel: 4.19.89
> IPIPE: 4.19.89
> Xenomai: 3.1

> Kernel is build as described in Xenomai wiki and configured with RTnet
> as kernel module.

> After installing xenomai kernel and checking the module, everything
> looks ok.

> > $ sudo modinfo /lib/modules/4.19.89/kernel/drivers/xenomai/net/stack/rt=
net.ko
> > filename: /lib/modules/4.19.89/kernel/drivers/xenomai/net/stack/rtnet.k=
o
> > description: RTnet stack core
> > license: GPL
> > srcversion: E1B65CA6F28C7B08C111720
> > depends:
> > retpoline: Y
> > intree: Y
> > name: rtnet
> > vermagic: 4.19.89 SMP mod_unload
> > signat: PKCS#7
> > signer:
> > sig_key:
> > sig_hashalgo: md4
> > parm: stack_mgr_prio:Priority of the stack manager task (uint)
>> parm: socket_rtskbs:Default number of realtime socket buffers in socket =
pools
> > (uint)
> > parm: global_rtskbs:Number of realtime socket buffers in global pool (u=
int)
>> parm: device_rtskbs:Number of additional global realtime socket buffers =
per
> > network adapter (uint)

> But kernel module can't be loaded.

> > $ sudo insmod /lib/modules/4.19.89/kernel/drivers/xenomai/net/stack/rtn=
et.ko
>> insmod: ERROR: could not insert module
>> /lib/modules/4.19.89/kernel/drivers/xenomai/net/stack/rtnet.ko: Function=
 not
> > implemented

> Has anybody a hint how to build/ load RTnet kernel module properly?

Can you load any other modules? Did you include "loadable module support" i=
n your kernel config?=20

If you do a simple "lsmod", does it say anything about other loaded modules=
 ?


> Thanks
> Benji


Per =C3=96berg=20

