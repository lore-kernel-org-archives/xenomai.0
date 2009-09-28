Message-ID: <4AC0D90C.8090509@domain.hid>
Date: Mon, 28 Sep 2009 17:41:00 +0200
From: Peter Puchwein <peter.puchwein@domain.hid>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Xenomai-help] BUG: Scheduling while atomic
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org


Hi,

we've done some start/stop tests with our xenomai system 2.6.29.5 with 
Xenomai 2.4.9.1 on a SMP x86.

Sometimes on boot we get these messages:

[   28.474265] BUG: scheduling while atomic: ps/3549/0x10000100
[   28.474269] Modules linked in: ec_e1000e ec_master [last unloaded: 
e1000e]
[   28.474283] Pid: 3549, comm: ps Not tainted (2.6.29.5-xenomai-2.4.9 #8)
[   28.474287] EIP: 0060:[<c113df82>] EFLAGS: 00000206 CPU: 1
[   28.474296] EIP is at selinux_dentry_open+0x1/0xb8
[   28.474299] EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
[   28.474303] ESI: 00000000 EDI: 00000000 EBP: ead8bea4 ESP: c1ef9638
[   28.474307]  DS: 0000 ES: 0000 FS: 0000 GS: 0033 SS: 0068
[   28.474310] CR0: 8005003b CR2: b7ea6000 CR3: 2ad6d000 CR4: 00000690
[   28.474314] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   28.474317] DR6: ffff0ff0 DR7: 00000400
[   28.474320] Call Trace:

The trace stops here, so we don't see any calltrace.

after evaluating some of these messages, we found out, that they have 
maybe something to do with networking.

[   34.340268] BUG: scheduling while atomic: udevd/3641/0x10000101
[   28.870014] BUG: scheduling while atomic: insmod/3570/0x10000100
[   33.088267] BUG: scheduling while atomic: ifconfig/3594/0x10000100
[   28.330054] BUG: scheduling while atomic: ifconfig/3548/0x10000100
[   28.252017] BUG: scheduling while atomic: ifconfig/3549/0x10000100
[   31.191270] BUG: scheduling while atomic: ifconfig/3564/0x10000100
[   30.902267] BUG: scheduling while atomic: ifconfig/3573/0x10000100
[   31.299021] BUG: scheduling while atomic: udevd/3568/0x10000100
[   28.355319] BUG: scheduling while atomic: ifconfig/3538/0x10000100
[   28.277270] BUG: scheduling while atomic: ifconfig/3548/0x10000100
[   28.601013] BUG: scheduling while atomic: insmod/3579/0x10000100
[   33.356077] BUG: scheduling while atomic: ifconfig/3587/0x10000100


Sometimes (every 500 times) the system freezes after these messages, 
mostly it works completely normal.

Thanks,
Peter





