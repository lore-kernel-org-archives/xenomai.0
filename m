From: Andreas Glatz <andreasglatz@domain.hid>
Content-Type: multipart/mixed; boundary="=-Ov3t/4N9PETJ6MJUcso7"
Date: Tue, 25 Aug 2009 19:45:37 -0400
Message-Id: <1251243937.10269.32.camel@domain.hid>
Mime-Version: 1.0
Subject: [Xenomai-help] Xenomai 2.4.9: Debugger freezes when stepping with
	gdb/gdbserver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>


--=-Ov3t/4N9PETJ6MJUcso7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

As I already told u, we upgraded to the newest Xenomai version (2.4.9)
and now we are experiencing problems when trying to step through 
the application with gdb/gdbserver which we haven't seen with previous
version of Xenomai/Linux kernel. Basically, if I run the whole thing
as described below on Xenomai 2.4.8 (with the alignment patch)
everything works fine...

Configuration:
- MPC8360
- Linux 2.6.30
- Ipipe 2.7-00
- Xenomai 2.4.9
- Alignment patch applied (see previous post)

I included some source code with this Email with
which I verified that it's not just on our side :p


1) I cross-compiled the source with:

<snip>
powerpc-linux-gnu-gcc --version
powerpc-linux-gnu-gcc (GCC) 4.1.3 20080704 (prerelease) (Debian
4.1.2-25)

powerpc-linux-gnu-gcc -Wall -O0 -g -o main
-I/opt/ROX-target/powerpc/usr/include/ -D_GNU_SOURCE -D_REENTRANT
-D__XENO__ -L/opt/ROX-target/powerpc//usr/lib -lpthread -lrtdk -lnative
main.c
</snip>


2) I started gdbserver 6.8 on the target with:

<snip>
/root/gdbserver --multi :2345 &
</snip>


3) I started powerpc-linux-gnu-gdb (6.8) on my host:

<snip>
powerpc-linux-gnu-gdb -x gdbinit_ROX_MPC83XX_hu
GNU gdb 6.8-debian
Copyright (C) 2008 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later
<http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show
copying"
and "show warranty" for details.
This GDB was configured as "--host=i486-linux-gnu
--target=powerpc-linux-gnu".
Breakpoint 1 at 0x10001c98: file main.c, line 37.
(gdb) b main.c:24
Breakpoint 2 at 0x10001b68: file main.c, line 24.
(gdb) run
Starting
program: /home/andreasglatz/ROX-RCLib/ROX-RCLibrary/ROX-MPC83XX/out/main 
[New Thread 3316]
Error while mapping shared library sections:
/usr/lib/librtdk.so.0: No such file or directory.
Error while mapping shared library sections:
/usr/lib/libnative.so.1: No such file or directory.
warning: .dynamic section for "/usr/powerpc-linux-gnu/lib/libgcc_s.so.1"
is not at the expected address (wrong library or version mismatch?)
[Switching to Thread 3316]

Breakpoint 1, main () at main.c:37
37		mlockall(MCL_CURRENT|MCL_FUTURE);
(gdb) c
Continuing.
[New Thread 3319]
[Switching to Thread 3319]

Breakpoint 2, first_task_body (cookie=0x10012390) at main.c:25
25								second_task_body, (void*)n2);
(gdb) s
rt_task_spawn (task=0x100123a0, name=0x10012398 "second", stksize=0,
prio=2, mode=0, 
    entry=0x10001b0c <second_task_body>, cookie=0x10012398)
    at /opt/ROX-target/powerpc/usr/include/native/task.h:322
322	    int err = rt_task_create(task,name,stksize,prio,mode);
(gdb) 



^C^CInterrupted while waiting for the program.
Give up (and stop debugging it)? (y or n) ^C^Cy


y
Ignoring packet error, continuing...
(gdb) Quit
(gdb) 
The program is not being run.
(gdb)
</snip>


4) That's how it looks on the remote side, which 
is still responsive:

<snip>
Remote debugging from host 10.200.19.189
Process /tmp/main created; pid = 3194
Info: In linux task
Info: In linux task
Info: In linux task
Info: In linux task
Info: In linux task
input_interrupt, count = 1 c = 36 ('$')
input_interrupt, count = 1 c = 63 ('?')
input_interrupt, count = 1 c = 35 ('#')
input_interrupt, count = 1 c = 51 ('3')
input_interrupt, count = 1 c = 102 ('f')
input_interrupt, count = 1 c = 36 ('$')
input_interrupt, count = 1 c = 63 ('?')

rx5000:~#
</snip>


5) Additionally, dmesg shows that there was no crash.
That's the info I got from /proc/xenomai :

<snip>
rx5000:~# cat /proc/xenomai/
affinity    faults      heap        irq         registry/   sched
timebases   timerstat/
apc         hal         interfaces/ latency     rtdm/       stat
timer       version
rx5000:~# cat /proc/xenomai/faults 
TRAP         CPU0
  0:            1    (Data or instruction access)
  1:            0    (Alignment)
  2:            0    (Altivec unavailable)
  3:            1    (Program check exception)
  4:            0    (Machine check exception)
  5:            0    (Unknown)
  6:            0    (Instruction breakpoint)
  7:            0    (Run mode exception)
  8:            0    (Single-step exception)
  9:            0    (Non-recoverable exception)
 10:            0    (Software emulation)
 11:            0    (Debug)
 12:            0    (SPE)
 13:            0    (Altivec assist)
 14:            0    (Cache-locking exception)
 15:            0    (Kernel FP unavailable)
rx5000:~# cat /proc/xenomai/sched 
CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT       NAME
  0  0       -1      0          0          master    R          ROOT
  0  3196     3      0          0          master    XT         first
rx5000:~# cat /proc/xenomai/stat  
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          1248       0     00500080  100.0  ROOT
  0  3196   1          1          0     00301380    0.0  first
  0  0      0          267261     0     00000000    0.0  IRQ512: [timer]
rx5000:~#
</snip>

Well, that's all I got for now... I'll try and recompile the
kernel with debugging enabled tomorrow.

Again, everything works fine with 2.6.26, Xeno 2.4.8, ... :S

Andreas






--=-Ov3t/4N9PETJ6MJUcso7
Content-Disposition: attachment; filename=main.c
Content-Type: text/x-csrc; name=main.c; charset=UTF-8
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN5cy9tbWFuLmg+DQojaW5jbHVkZSA8dW5pc3RkLmg+DQojaW5jbHVkZSA8c2ln
bmFsLmg+DQojaW5jbHVkZSA8c3RyaW5nLmg+DQojaW5jbHVkZSA8c3RkYXJnLmg+DQojaW5jbHVk
ZSA8bmF0aXZlL3Rhc2suaD4NCiNpbmNsdWRlIDxydGRrLmg+DQoNClJUX1RBU0sgZmlyc3RfdGFz
azsNClJUX1RBU0sgc2Vjb25kX3Rhc2s7DQpjb25zdCBjaGFyIG4xW10gPSAiZmlyc3QiOw0KY29u
c3QgY2hhciBuMltdID0gInNlY29uZCI7DQoNCnZvaWQgc2Vjb25kX3Rhc2tfYm9keSh2b2lkKiBj
b29raWUpDQp7DQoJd2hpbGUoMSkgew0KCQlydF9wcmludGYoIkluZm86IEluICVzIHRhc2tcbiIs
IChjaGFyKiljb29raWUpOw0KCQlydF90YXNrX3NsZWVwKDEwMDAwMDAwKTsNCgl9CQ0KfQ0KDQp2
b2lkIGZpcnN0X3Rhc2tfYm9keSh2b2lkKiBjb29raWUpDQp7DQoJaW50IGVyciA9IHJ0X3Rhc2tf
c3Bhd24oJnNlY29uZF90YXNrLCBuMiwgMCwgMiwgMCwNCgkJCQkJCQlzZWNvbmRfdGFza19ib2R5
LCAodm9pZCopbjIpOw0KCQ0KCXdoaWxlKCFlcnIpIHsNCgkJcnRfcHJpbnRmKCJJbmZvOiBJbiAl
cyB0YXNrXG4iLCAoY2hhciopY29va2llKTsNCgkJcnRfdGFza19zbGVlcCgxMDAwMDAwMCk7DQoJ
fQ0KfQ0KDQppbnQgbWFpbih2b2lkKQ0Kew0KCWludCBlcnI7DQoNCgltbG9ja2FsbChNQ0xfQ1VS
UkVOVHxNQ0xfRlVUVVJFKTsNCglydF9wcmludF9hdXRvX2luaXQoMSk7DQoNCgllcnIgPSBydF90
YXNrX3NwYXduKCZmaXJzdF90YXNrLCBuMSwgMCwgMywgMCwNCgkJCQkJCWZpcnN0X3Rhc2tfYm9k
eSwgKHZvaWQqKW4xKTsNCglpZighZXJyKSB7DQoJCXdoaWxlKDEpIHsNCgkJCXJ0X3ByaW50Zigi
SW5mbzogSW4gbGludXggdGFza1xuIik7DQoJCQlzbGVlcCgxKTsNCgkJfQ0KCX0NCglyZXR1cm4g
ZXJyOw0KfQ0KDQo=


--=-Ov3t/4N9PETJ6MJUcso7
Content-Disposition: attachment; filename=gdbinit_ROX_MPC83XX_hu
Content-Type: text/plain; name=gdbinit_ROX_MPC83XX_hu; charset=UTF-8
Content-Transfer-Encoding: base64

IyMNCiMgQXV0aG9yOiBhbmRyZWFzZ2xhdHpAcnVnZ2VkY29tLmNvbQ0KIyANCiMgVGhpcyBmaWxl
IGNvbnRhaW5zIGNvbW1hbmRzIHJlcXVpcmVkIGZvcg0KIyBzdGFydGluZyBhIHJlbW90ZSBkZWJ1
ZyBzZXNzaW9uLCBhc3N1bWluZyB0aGF0DQojIG9uIHRoZSB0YXJnZXQgZ2Ric2VydmVyIHdhcyBz
dGFydGVkIGFzIGZvbGxvd3M6DQojDQojIC4vZ2Ric2VydmVyIC0tbXVsdGkgOjIzNDUgJg0KIw0K
DQojIENvbm5lY3QgdG8gdGhlIHJlbW90ZSB0YXJnZXQNCnRhcmdldCBleHRlbmRlZC1yZW1vdGUg
MTAuMjAwLjE5LjIyODoyMzQ1DQoNCiMgQ29weSAnbWFpbicgdG8gcmVtb3RlIHRhcmdldA0KcmVt
b3RlIHB1dCBvdXQvbWFpbiAvdG1wL21haW4NCg0KIyBMb2FkIHN5bWJvbCB0YWJsZQ0KZmlsZSBv
dXQvbWFpbg0KDQojIFNldCAnbWFpbicgYXMgbWFpbiBleGVjdXRhYmxlDQpzZXQgcmVtb3RlIGV4
ZWMtZmlsZSAvdG1wL21haW4NCg0KIyBTZXQgYnJlYWtwb2ludCBhdCBtYWluKCkNCmIgbWFpbg0K



--=-Ov3t/4N9PETJ6MJUcso7--

