From: Benji <miethben@b-tu.de>
Subject: Xenomai RTnet - Kernel module not loading
Message-ID: <2eb86315-dc9d-1096-14a7-c3bd2b32a668@b-tu.de>
Date: Tue, 25 Feb 2020 15:02:28 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello all,

I'm a student working on a project comparing different real time OS
approaches. Trying to get RTnet working on a Xenomai Cobalt kernel, but
stuck on loading required kernel modules.

System is running on Ubuntu 18.04 and uses following versions to build
Xenomai kernel:

	Linux Kernel:	4.19.89
	IPIPE:		4.19.89
	Xenomai:	3.1

Kernel is build as described in Xenomai wiki and configured with RTnet
as kernel module.

After installing xenomai kernel and checking the module, everything
looks ok.

> $ sudo modinfo /lib/modules/4.19.89/kernel/drivers/xenomai/net/stack/rtnet.ko
> filename:       /lib/modules/4.19.89/kernel/drivers/xenomai/net/stack/rtnet.ko
> description:    RTnet stack core
> license:        GPL
> srcversion:     E1B65CA6F28C7B08C111720
> depends:
> retpoline:      Y
> intree:         Y
> name:           rtnet
> vermagic:       4.19.89 SMP mod_unload
> signat:         PKCS#7
> signer:
> sig_key:
> sig_hashalgo:   md4
> parm:           stack_mgr_prio:Priority of the stack manager task (uint)
> parm:           socket_rtskbs:Default number of realtime socket buffers in socket pools (uint)
> parm:           global_rtskbs:Number of realtime socket buffers in global pool (uint)
> parm:           device_rtskbs:Number of additional global realtime socket buffers per network adapter (uint)

But kernel module can't be loaded.

> $ sudo insmod /lib/modules/4.19.89/kernel/drivers/xenomai/net/stack/rtnet.ko
> insmod: ERROR: could not insert module /lib/modules/4.19.89/kernel/drivers/xenomai/net/stack/rtnet.ko: Function not implemented

Has anybody a hint how to build/ load RTnet kernel module properly?

Thanks
Benji

