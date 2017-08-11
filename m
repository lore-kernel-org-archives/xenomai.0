Date: Fri, 11 Aug 2017 14:48:46 +0000
Message-ID: <20170811144846.Horde.66dch8abhtYH2TqPGAFCOFD@office.mrmoco.com>
From: Paul Wilkinson <paul.w@mrmoco.com>
References: <CAKJ14Ndf43hdOcFSVP_S-ZLji=smtpj7bih=s8618Yfsh5OG7g@mail.gmail.com>
 <0a153821-210d-0add-e986-3f424b7cf4ed@ixblue.com>
In-Reply-To: <0a153821-210d-0add-e986-3f424b7cf4ed@ixblue.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"; delsp="Yes"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Description: Plaintext Message
Subject: Re: [Xenomai] UDP comms via Xenomai 3.0.5 + RTnet ? (Paul Wilkinson)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

  Thank you Andreas and Christophe for helping resolve the rtroute issue.

The messed up routing table was likely as a result of my various attempts
to get it working.

Unfortunately, now that I've hopefully corrected the RTnet routing table,
rtping hangs after printing, "Real-time PING 10.0.0.2 56(84) bytes of
data".

Perhaps related, the receiver side (@10.0.0.2) of a trivial UDP
client/server
utility does not receive the UDP packets the server side is sending (both
when
sent locally to receiver (compiled and linked against cobalt), and when
sent
from 10.0.0.5 - these I can see being sent using wireshark).

I've only configured the rteth0 interface, not rtlo.

# ./rtroute
Host Routing Table
Hash    Destination    HW Address        Device
02    10.0.0.2      5C:F9:DD:74:9C:27    rteth0 - local
Xenomai/RTnet NIC
05    10.0.0.5      D4:BE:D9:1F:88:C2    rteth0 - remote Linux
07    192.168.1.71     98:DE:D0:03:80:CA    rteth0 - local 2nd NIC
3F    10.255.255.255    FF:FF:FF:FF:FF:FF    rteth0

# ./rtping 10.0.0.2/ - never returns/
Real-time PING 10.0.0.2 56(84) bytes of data.
^C
--- 10.0.0.2 rtping statistics ---
3 packets transmitted, 0 received, 100% packet loss
worst case rtt = 0.0 us

# ./rtping 10.0.0.5/ - and 10.0.0.5 can ping successfully Xenomai/RTnet/
Real-time PING 10.0.0.5 56(84) bytes of data.
64 bytes from 10.0.0.5: icmp_seq=1 time=494.3 us
64 bytes from 10.0.0.5: icmp_seq=2 time=442.9 us
64 bytes from 10.0.0.5: icmp_seq=3 time=600.4 us
^C
--- 10.0.0.5 rtping statistics ---
3 packets transmitted, 3 received, 0% packet loss
worst case rtt = 600.4 us

# ./rtping 192.168.1.71/ - never returns/
Real-time PING 192.168.1.71 56(84) bytes of data.
^C
--- 192.168.1.71 rtping statistics ---
5 packets transmitted, 0 received, 100% packet loss
worst case rtt = 0.0 us

# lsmod
Module                  Size  Used by
rt_loopback             1325  1
rtpacket                6714  0
rtudp                  10708  1/ - in use by UDP receiver
app/
rt_e1000e             100022  1
rtipv4                 22182  1 rtudp
rtnet                  44399  5
rtipv4,rt_loopback,rt_e1000e,rtpacket,rtudp
uio_netx                2273  0
uio                     8037  1 uio_netx
x86_pkg_temp_thermal     5495  0
r8169                  68092  0

(gdb) r 10.0.0.2
Starting program: udpreceiver 10.0.0.2
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
[New Thread 0x7ffff71ea700 (LWP 18990)]
^C
Program received signal SIGINT, Interrupt.
0x00007ffff7bcbf31 in do_recvmsg () from /usr/xenomai/lib/libcobalt.so.2
(gdb)

# dmesg

*** RTnet for Xenomai v3.0.5 ***

[163539.835443] RTnet: initialising real-time networking
[163539.838668] rt_e1000e: Intel(R) PRO/1000 Network Driver - 1.5.1-k-rt
[163539.838669] rt_e1000e: Copyright(c) 1999 - 2011 Intel Corporation.
[163540.117612] RTnet: registered rteth0
[163540.117614] rt_e1000e: (PCI Express:2.5GT/s:Width x1) 5c:f9:dd:74:9c:27
[163540.117615] rt_e1000e: Intel(R) PRO/1000 Network Connection
[163540.117658] rt_e1000e: MAC: 10, PHY: 11, PBA No: E041FF-0FF
[163540.121339] initializing loopback...
[163540.121346] RTnet: registered rtlo
[163542.116317] e1000e: rteth0 NIC Link is Up 100 Mbps Full Duplex, Flow
Control: Rx/Tx
[163542.116318] rt_e1000e: 10/100 speed: disabling TSO
[170147.661471] RTnet: host 10.0.0.5 unreachable
[170148.662587] RTnet: host 10.0.0.5 unreachable
[170149.663781] RTnet: host 10.0.0.5 unreachable
[170150.664909] RTnet: host 10.0.0.5 unreachable
[170151.666105] RTnet: host 10.0.0.5 unreachable
[170152.667286] RTnet: host 10.0.0.5 unreachable

# lsmod
Module                  Size  Used by
rt_loopback             1325  1
rtpacket                6714  0
rtudp                  10708  1
rt_e1000e             100022  1
rtipv4                 22182  1 rtudp
rtnet                  44399  5
rtipv4,rt_loopback,rt_e1000e,rtpacket,rtudp
uio_netx                2273  0
uio                     8037  1 uio_netx
x86_pkg_temp_thermal     5495  0
r8169                  68092  0

# strace ./rtping 10.0.0.2
execve("./rtping", ["./rtping", "10.0.0.2"], [/* 44 vars */]) = 0
brk(0)                                  =
0x14b3000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
directory)
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x7f2bd17d0000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=114787, ...}) = 0
mmap(NULL, 114787, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f2bd17b3000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
directory)
open("/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3,
"\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0P\34\2\0\0\0\0\0"...,
832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=1738176, ...}) = 0
mmap(NULL, 3844640, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
0x7f2bd1207000
mprotect(0x7f2bd13a8000, 2097152, PROT_NONE) = 0
mmap(0x7f2bd15a8000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_DENYWRITE, 3, 0x1a1000) = 0x7f2bd15a8000
mmap(0x7f2bd15ae000, 14880, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_ANONYMOUS, -1, 0) = 0x7f2bd15ae000
close(3)                                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x7f2bd17b2000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x7f2bd17b1000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x7f2bd17b0000
arch_prctl(ARCH_SET_FS, 0x7f2bd17b1700) = 0
mprotect(0x7f2bd15a8000, 16384, PROT_READ) = 0
mprotect(0x7f2bd17d2000, 4096, PROT_READ) = 0
munmap(0x7f2bd17b3000, 114787)          = 0
open("/dev/rtnet", O_RDWR)              = 3
fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 0), ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x7f2bd17cf000
write(1, "Real-time PING 10.0.0.2 56(84) b"..., 46Real-time PING 10.0.0.2
56(84)
 bytes of data.
) = 46
rt_sigaction(SIGINT, {0x400b13, [INT], SA_RESTORER|SA_RESTART,
0x7f2bd123c0e0},
{SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGALRM, {0x400b2a, [ALRM], SA_RESTORER|SA_RESTART,
0x7f2bd123c0e0}
, {SIG_DFL, [], 0}, 8) = 0
setitimer(ITIMER_REAL, {it_interval={1, 0}, it_value={0, 1}}, NULL) = 0
--- SIGALRM {si_signo=SIGALRM, si_code=SI_KERNEL} ---
ioctl(3, 0xc0500285, 0x601640)          = -1 ETIME (Timer expired)
rt_sigreturn()                          = 0
pause()                                 = ?
ERESTARTNOHAND
(To be restarted if no handler)
--- SIGALRM {si_signo=SIGALRM, si_code=SI_KERNEL} ---
ioctl(3, 0xc0500285, 0x601640)          = -1 ETIME (Timer expired)
rt_sigreturn()                          = -1 EINTR
(Interrupted system call)
pause()                                 = ?
ERESTARTNOHAND
(To be restarted if no handler)
--- SIGALRM {si_signo=SIGALRM, si_code=SI_KERNEL} ---
ioctl(3, 0xc0500285, 0x601640)          = -1 ETIME (Timer expired)
rt_sigreturn()                          = -1 EINTR
(Interrupted system call)
pause()                                 = ?
ERESTARTNOHAND
(To be restarted if no handler)
--- SIGALRM {si_signo=SIGALRM, si_code=SI_KERNEL} ---
ioctl(3, 0xc0500285^CProcess 18738 detached
 <detached ...>

Quoting Christophe Carton <christophe.carton@ixblue.com>:

> Le 10/08/2017 à 15:36, Andreas Glatz a écrit :
>>> # ./rtping 10.0.0.1
>>> Real-time PING 10.0.0.1 56(84) bytes of data.
>>> ioctl: No route to host
>>
>> You should populate your RTnet routing table with some meaningful
>> combinations of IP address and MAC address after bringing it up.
>>
>> The other non-persistent option is to ping your RTnet device from a
>> non-RTnet device, which auto populates the RTnet routing table with
>> the IP & mac pair of the sender. After that you can rtping the other
>> device as well.
>>
>>> However, if I use 'rtnet start', rtping succeeds :-
>>>
>>> # ./rtping 10.0.0.1
>>> Real-time PING 10.0.0.1 56(84) bytes of data.
>>> 64 bytes from 127.0.0.1: icmp_seq=1 time=4.8 us
>>> 64 bytes from 127.0.0.1: icmp_seq=2 time=4.4 us
>>> 64 bytes from 127.0.0.1: icmp_seq=3 time=3.4 us
>>> 64 bytes from 127.0.0.1: icmp_seq=4 time=3.7 us
>>> 64 bytes from 127.0.0.1: icmp_seq=5 time=4.2 us
>>
>> Somehow your rtnet start script does not populate the routing table
>> properly. Hence if you ping 10.0.0.1, you actually get a reply from
>> localhost (127.0.0.1).
>>
>>> # ./rtroute
>>> Host Routing Table
>>> Hash?? ?Destination?? ?HW Address?? ??? ?Device
>>> 00?? ?0.0.0.0 ??? ?00:00:00:00:00:00?? ?rtlo
>>> 01?? ?127.0.0.1 ??? ?00:00:00:00:00:00?? ?rtlo
>>> 02?? ?10.0.0.2 ??? ?00:00:00:00:00:00?? ?rtlo
>>> 3F?? ?10.255.255.255?? ?FF:FF:FF:FF:FF:FF?? ?rteth0
>>
>> See:
>> rtroute --help
>>
>> E.g (assuming that 02:00:00:00:01:02 is the MAC of 10.0.0.1):
>>
>> rtroute add 10.0.0.1 02:00:00:00:01:02 dev rteth0
>>
>> ... after that rtping should work.
>
> If you do not know the MAC of 10.0.0.1 you may also execute:
>
> rtroute solicit 10.0.0.1 dev rteht0 #See: rtroute --help
>
> This will force an ARP exchange.
>
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> https://xenomai.org/mailman/listinfo/xenomai
>
> --
>
> *Christophe*
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.orghttps://xenomai.org/mailman/listinfo/xenomai
