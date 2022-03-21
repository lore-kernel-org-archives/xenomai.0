Message-ID: <03ca9420-7412-4467-dab1-e25c86d8b5cc@siemens.com>
Date: Mon, 21 Mar 2022 17:28:30 +0100
MIME-Version: 1.0
Subject: Re: [rtnet] kernel bug during slave configuration
Content-Language: en-US
References: <6bd0cf73.395f.17facec1472.Webtop.62@tin.it>
 <9bcb9261-5222-df33-6265-e99db2896809@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <9bcb9261-5222-df33-6265-e99db2896809@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mauro <mau.salvi@tin.it>, xenomai@xenomai.org

On 21.03.22 17:25, Jan Kiszka via Xenomai wrote:
> On 21.03.22 15:40, Mauro via Xenomai wrote:
>> Hi all,
>>
>> I'm using Xenomai 3.1.2 on a Intel Atom x5-E8000 64bit with an Intel
>> I210 gigabit ethernet controller. Linux kernel is 5.4.181.
>>
>> I have two identical devices, one configured as master:
>>
>> -------------
>> $ cat /etc/rtnet.conf
>> prefix="/usr"
>> exec_prefix="/usr"
>> RTNET_MOD="/lib/modules/`uname -r`/kernel/drivers/xenomai/net"
>> RTIFCONFIG="/usr/sbin/rtifconfig"
>> RTCFG="/usr/sbin/rtcfg"
>> TDMACFG="/usr/sbin/tdmacfg"
>> MODULE_EXT=".ko"
>>
>> RT_DRIVER="rt_igb"
>> RT_DRIVER_OPTIONS=""
>>
>> REBIND_RT_NICS="0000:03:00.0"
>>
>> IPADDR="10.0.0.1"
>> NETMASK=""
>>
>> RT_LOOPBACK="yes"
>> RT_PROTOCOLS="udp packet"
>> RTCAP="no"
>>
>> STAGE_2_SRC=""
>> STAGE_2_DST=""
>> STAGE_2_CMDS=""
>>
>> TDMA_MODE="master"
>> TDMA_SLAVES="10.0.0.2"
>> TDMA_CYCLE="1000"
>> TDMA_OFFSET="200"
>> #TDMA_CONFIG="/etc/tdma.conf"
>> -------------
>>
>> and one as slave:
>>
>> -------------
>> $ cat /etc/rtnet.conf
>> prefix="/usr"
>> exec_prefix="/usr"
>> RTNET_MOD="/lib/modules/`uname -r`/kernel/drivers/xenomai/net"
>> RTIFCONFIG="/usr/sbin/rtifconfig"
>> RTCFG="/usr/sbin/rtcfg"
>> TDMACFG="/usr/sbin/tdmacfg"
>> MODULE_EXT=".ko"
>>
>> RT_DRIVER="rt_igb"
>> RT_DRIVER_OPTIONS=""
>>
>> REBIND_RT_NICS="0000:03:00.0"
>>
>> IPADDR="10.0.0.2"
>> NETMASK=""
>> RT_LOOPBACK="yes"
>> RT_PROTOCOLS="udp packet"
>> RTCAP="no"
>>
>> STAGE_2_SRC=""
>> STAGE_2_DST=""
>> STAGE_2_CMDS=""
>>
>> TDMA_MODE="slave"
>>
>> TDMA_SLAVES="10.0.0.2 10.0.0.3 10.0.0.4"
>> TDMA_CYCLE="5000"
>> TDMA_OFFSET="200"
>> #TDMA_CONFIG="/etc/tdma.conf"
>> -------------
>>
>> I start rtnet with "rtnet start" on master
>>
>> $ rtnet start
>> Waiting for all slaves...
>>
>> dmesg on master shows:
>>
>> .......
>> TDMA: Failed to transmit sync frame!
>> TDMA: Failed to transmit sync frame!
>> TDMA: Failed to transmit sync frame!
>> TDMA: Failed to transmit sync frame!
>> TDMA: Failed to transmit sync frame!
>> TDMA: Failed to transmit sync frame!
>> TDMA: Failed to transmit sync frame!
>> TDMA: Failed to transmit sync frame!
>> TDMA: Failed to transmit sync frame!
>> rt_igb: rteth0: igb: rteth0 NIC Link is Up 1000 Mbps Full Duplex, Flow
>> Control: RX/TX
>>
>>
>> Then, I start rtnet with "rtnet start" on slave
>>
>> $ rtnet start
>> Stage 1: searching for master...
>> Stage 2: waiting for other slaves...
>> Stage 3: waiting for common setup completion...ioctl: Invalid argument
>>
>> dmesg on slave shows:
>>
>> *** RTnet for Xenomai v3.1.2 ***
>>
>> RTnet: initialising real-time networking
>> rt_igb: Intel(R) Gigabit Ethernet Network Driver - version 5.2.18-k
>> rt_igb: Copyright (c) 2007-2014 Intel Corporation.
>> igb 0000:03:00.0: removed PHC on eth1
>> RTnet: registered rteth0
>> rt_igb 0000:03:00.0: Intel(R) Gigabit Ethernet Network Connection
>> rt_igb 0000:03:00.0: rteth0: (PCIe:2.5Gb/s:Width x1) 00:30:d6:2b:78:c9
>> rt_igb 0000:03:00.0: rteth0: PBA No: FFFFFF-0FF
>> rt_igb 0000:03:00.0: Using MSI-X interrupts. 1 rx queue(s), 1 tx queue(s)
>> rt_loopback: initializing loopback interface...
>> RTnet: registered rtlo
>> RTcfg: init real-time configuration distribution protocol
>> RTmac: init realtime media access control
>> RTmac/TDMA: init time division multiple access control mechanism
>> udevd[401]: Error changing net interface name vnic0 to : Invalid argument
>> udevd[401]: could not rename interface '5' from 'vnic0' to '': Invalid
>> argument
>> rt_igb: rteth0: igb: rteth0 NIC Link is Up 1000 Mbps Full Duplex, Flow
>> Control: RX/TX
>> usercopy: Kernel memory exposure attempt detected from SLUB object
>> 'rtskb_slab_pool' (offset 219, size 66)!
>> invalid opcode: 0000 [#1] PREEMPT SMP PTI
>> CPU: 0 PID: 419 Comm: rtcfg Tainted: G        W         5.4.181-xeno #1
>> Hardware name: Default string Default string/69823 MSC
>> Q7-BW-E8000-13N0220C PCBFTX, BIOS V1.20#KW050220A 03/16/2018
>> I-pipe domain: Linux
>> RIP: 0010:usercopy_abort+0x7b/0x7d
>> Code: bb 48 c7 c2 30 1d e5 bb 4c 0f 45 de 48 c7 c6 a3 0c e4 bb 57 48 0f
>> 45 f2 4c 89 d1 4c 89 da 48 c7 c7 d0 1c e5 bb e8 d9 95 ff ff <0f> 0b 49
>> 8d 0c 24 4c 8d 03 48 29 d1 31 f6 41 8d 55 00 48 c7 c7 72
>> RSP: 0018:ffffb7dac07efbf0 EFLAGS: 00010246
>> RAX: 000000000000006b RBX: 0000000000000042 RCX: 0000000000000000
>> RDX: 0000000000000000 RSI: ffff9df43661b4c8 RDI: 00000000ffffffff
>> RBP: ffffb7dac07efc08 R08: 00000000000002b5 R09: 0000000000000101
>> R10: 0000000000000001 R11: 0000000000000400 R12: ffff9df4371a38db
>> R13: 0000000000000001 R14: ffff9df4371a391d R15: ffff9df43896af48
>> FS:  00007fe873ae6540(0000) GS:ffff9df436600000(0000)
>> knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007fa6254b14e0 CR3: 0000000077026000 CR4: 00000000001006f0
>> Call Trace:
>>  __check_heap_object+0xed/0x120
>>  __check_object_size+0x14c/0x160
>>  copy_stage_1_data+0x50/0x80 [rtcfg]
>>  rtnet_rtpc_dispatch_call+0x187/0x360 [rtnet]
>>  ? cleanup_cmd_del+0x70/0x70 [rtcfg]
>>  ? finish_wait+0x90/0x90
>>  rtcfg_ioctl+0xa2/0x250 [rtcfg]
>>  ? rtdev_get_by_name+0xa6/0xd0 [rtnet]
>>  rtnet_ioctl+0xe4/0x180 [rtnet]
>>  do_vfs_ioctl+0x40c/0x670
>>  ? handle_mm_fault+0xe5/0x220
>>  ksys_ioctl+0x6c/0xa0
>>  __x64_sys_ioctl+0x1a/0x20
>>  do_syscall_64+0x64/0xb0
>>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> RIP: 0033:0x7fe873a184e7
>> Code: 00 00 90 48 8b 05 a9 59 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff
>> ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01
>> f0 ff ff 73 01 c3 48 8b 0d 79 59 0c 00 f7 d8 64 89 01 48
>> RSP: 002b:00007ffec4281878 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>> RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fe873a184e7
>> RDX: 0000559484de0060 RSI: 0000000040a00104 RDI: 0000000000000003
>> RBP: 0000000000000001 R08: 00005594866382a0 R09: 0000000000000047
>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>> R13: 00000000000005dc R14: 00000000000005dc R15: 00007ffec42819c8
>> Modules linked in: tdma rtmac rtcfg rt_loopback rtpacket rtudp rt_igb
>> rtipv4 rtnet intel_rapl_msr intel_rapl_common intel_powerclamp mei_txe
>> mei i915 coretemp efivars video
>> ---[ end trace 9b391f8ebbda09ed ]---
>> RIP: 0010:usercopy_abort+0x7b/0x7d
>> Code: bb 48 c7 c2 30 1d e5 bb 4c 0f 45 de 48 c7 c6 a3 0c e4 bb 57 48 0f
>> 45 f2 4c 89 d1 4c 89 da 48 c7 c7 d0 1c e5 bb e8 d9 95 ff ff <0f> 0b 49
>> 8d 0c 24 4c 8d 03 48 29 d1 31 f6 41 8d 55 00 48 c7 c7 72
>> RSP: 0018:ffffb7dac07efbf0 EFLAGS: 00010246
>> RAX: 000000000000006b RBX: 0000000000000042 RCX: 0000000000000000
>> RDX: 0000000000000000 RSI: ffff9df43661b4c8 RDI: 00000000ffffffff
>> RBP: ffffb7dac07efc08 R08: 00000000000002b5 R09: 0000000000000101
>> R10: 0000000000000001 R11: 0000000000000400 R12: ffff9df4371a38db
>> R13: 0000000000000001 R14: ffff9df4371a391d R15: ffff9df43896af48
>> FS:  00007fe873ae6540(0000) GS:ffff9df436600000(0000)
>> knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007fa6254b14e0 CR3: 0000000077026000 CR4: 00000000001006f0
>> ------------[ cut here ]------------
>> kernel BUG at mm/usercopy.c:99!
>> hard_start_xmit returned -11
>>
>>
>> Sometimes the "ioctl: Invalid argument" is also on "Stage 1: searching
>> for master..."
>>
>> What am I doing wrong?
>>
>> Thanks in advance, regards
>>
> 
> This likely relates CONFIG_HARDENED_USERCOPY and RTnet not tagging the
> rtskb slab pool at being a potential usercopy source/sink. Happy to take
> patches that resolves it. Or you need to disable this checking feature.
> 

Something with kmem_cache_create_usercopy() (rather than
kmem_cache_create) - but I didn't use that myself so far.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

