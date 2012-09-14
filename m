Message-ID: <5053502C.2000900@iit.it>
Date: Fri, 14 Sep 2012 17:41:32 +0200
From: "Alessio Margan @ IIT" <alessio.margan@iit.it>
MIME-Version: 1.0
References: <5053404B.9000006@iit.it> <5053493D.3040000@xenomai.org>
In-Reply-To: <5053493D.3040000@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] segfault using rt_printf service
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
Cc: xenomai <xenomai@xenomai.org>

On 09/14/2012 05:11 PM, Gilles Chanteperdrix wrote:
> On 09/14/2012 04:33 PM, Alessio Margan @ IIT wrote:
>> Hi all,
>>
>> I'm switching from xenomai 2.5.6 to 2.6.1 using
>> adeos-ipipe-2.6.38.8-x86-2.11-01.patch
>> In this test I have 2 threads :
>> - rx_udp receive udp packets from dsp boards at 1kHz
>> - boards_test send udp packets at 1kHz
>>
>> I got segfault in printer_loop thread, the point is that if I change env
>> var RT_PRINT_PERIOD to about 10 or 1000 (default is 100 ms) I do not
>> have segfault.
>>
>> Any suggestion ?
>>
>> Program received signal SIGSEGV, Segmentation fault.
>> [Switching to Thread 0xb7d1ab70 (LWP 5998)]
>> 0xb7d7cb0c in fwrite () from /lib/i686/cmov/libc.so.6
>> (gdb) bt
>> #0  0xb7d7cb0c in fwrite () from /lib/i686/cmov/libc.so.6
>> #1  0xb7fccbf9 in print_buffers () from /usr/xenomai/lib/libxenomai.so.0
>> #2  0xb7fcd867 in printer_loop () from /usr/xenomai/lib/libxenomai.so.0
>> #3  0xb7fb5955 in start_thread () from /lib/i686/cmov/libpthread.so.0
>> #4  0xb7dec5ee in clone () from /lib/i686/cmov/libc.so.6
> Since you seem to be able to catch the error with gdb, maybe try and
> understand the reason for the segfault? The first, quick check, is to
> type "info register", type cat /proc/pid/maps in another terminal, and
> check that the stack pointer is in a valid mapping, to check if we do
> not have a stack overflow.
>
> If you fail to find the error, please try and reduce the test program to
> a simple test case, as simple as needed for the bug to happen and post
> it on this mailing list, this would allow us to reproduce the issue.
>

Thanks ...

try to learn how to read debug info ...
here is what I got

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0xb7d1ab70 (LWP 1789)]
0xb7d7cb0c in fwrite () from /lib/i686/cmov/libc.so.6
(gdb) info register
eax            0xc9cfa3b    211614267
ecx            0xe634c0    15086784
edx            0x19db    6619
ebx            0xb7e62ff4    -1209651212
esp            0xb7d1a23c    0xb7d1a23c
ebp            0xb7d1a258    0xb7d1a258
esi            0xe634c0    15086784
edi            0xe    14
eip            0xb7d7cb0c    0xb7d7cb0c <fwrite+44>
eflags         0x210202    [ IF RF ID ]
cs             0x73    115
ss             0x7b    123
ds             0x7b    123
es             0x7b    123
fs             0x0    0
gs             0x33    51
(gdb) info threads
   4 Thread 0xb7d0db70 (LWP 1791)  0xb7fe2424 in __kernel_vsyscall ()
   3 Thread 0xb7d12b70 (LWP 1790)  0xb7fe2424 in __kernel_vsyscall ()
* 2 Thread 0xb7d1ab70 (LWP 1789)  0xb7d7cb0c in fwrite () from 
/lib/i686/cmov/libc.so.6
   1 Thread 0xb7d1e6e0 (LWP 1786)  0xb7fe2424 in __kernel_vsyscall ()
(gdb)



embedded@ccub-deb:~$ cat /proc/1789/maps
08048000-0808e000 r-xp 00000000 00:10 10629494   
/home/embedded/robolli_nfs/v2.0/examples/test_main
0808e000-08090000 rw-p 00045000 00:10 10629494   
/home/embedded/robolli_nfs/v2.0/examples/test_main
08090000-0c9ef000 rw-p 00000000 00:00 0          [heap]
b6f4d000-b7d09000 rw-p 00000000 00:00 0
b7d09000-b7d0a000 ---p 00000000 00:00 0
b7d0a000-b7d0e000 rw-p 00000000 00:00 0
b7d0e000-b7d0f000 ---p 00000000 00:00 0
b7d0f000-b7d13000 rw-p 00000000 00:00 0
b7d13000-b7d14000 ---p 00000000 00:00 0
b7d14000-b7d1b000 rw-p 00000000 00:00 0
b7d1b000-b7d1e000 rw-s f800d000 00:05 88         /dev/rtheap
b7d1e000-b7d20000 rw-p 00000000 00:00 0
b7d20000-b7e60000 r-xp 00000000 08:01 114961     
/lib/i686/cmov/libc-2.11.3.so
b7e60000-b7e61000 ---p 00140000 08:01 114961     
/lib/i686/cmov/libc-2.11.3.so
b7e61000-b7e63000 r--p 00140000 08:01 114961     
/lib/i686/cmov/libc-2.11.3.so
b7e63000-b7e64000 rw-p 00142000 08:01 114961     
/lib/i686/cmov/libc-2.11.3.so
b7e64000-b7e67000 rw-p 00000000 00:00 0
b7e67000-b7e84000 r-xp 00000000 08:01 89965      /lib/libgcc_s.so.1
b7e84000-b7e85000 rw-p 0001c000 08:01 89965      /lib/libgcc_s.so.1
b7e85000-b7ea9000 r-xp 00000000 08:01 114943     
/lib/i686/cmov/libm-2.11.3.so
b7ea9000-b7eaa000 r--p 00023000 08:01 114943     
/lib/i686/cmov/libm-2.11.3.so
b7eaa000-b7eab000 rw-p 00024000 08:01 114943     
/lib/i686/cmov/libm-2.11.3.so
b7eab000-b7eac000 rw-p 00000000 00:00 0
b7eac000-b7f95000 r-xp 00000000 08:01 82575      
/usr/lib/libstdc++.so.6.0.13
b7f95000-b7f99000 r--p 000e9000 08:01 82575      
/usr/lib/libstdc++.so.6.0.13
b7f99000-b7f9a000 rw-p 000ed000 08:01 82575      
/usr/lib/libstdc++.so.6.0.13
b7f9a000-b7fa1000 rw-p 00000000 00:00 0
b7fa1000-b7fa3000 r-xp 00000000 08:01 114942     
/lib/i686/cmov/libdl-2.11.3.so
b7fa3000-b7fa4000 r--p 00001000 08:01 114942     
/lib/i686/cmov/libdl-2.11.3.so
b7fa4000-b7fa5000 rw-p 00002000 08:01 114942     
/lib/i686/cmov/libdl-2.11.3.so
b7fa5000-b7fa6000 r-xp 00000000 08:01 149583     
/usr/xenomai/lib/librtdm.so.1.0.0
b7fa6000-b7fa7000 rw-p 00000000 08:01 149583     
/usr/xenomai/lib/librtdm.so.1.0.0
b7fa7000-b7fae000 r-xp 00000000 08:01 114960     
/lib/i686/cmov/librt-2.11.3.so
b7fae000-b7faf000 r--p 00006000 08:01 114960     
/lib/i686/cmov/librt-2.11.3.so
b7faf000-b7fb0000 rw-p 00007000 08:01 114960     
/lib/i686/cmov/librt-2.11.3.so
b7fb0000-b7fc5000 r-xp 00000000 08:01 114951     
/lib/i686/cmov/libpthread-2.11.3.so
b7fc5000-b7fc6000 r--p 00014000 08:01 114951     
/lib/i686/cmov/libpthread-2.11.3.so
b7fc6000-b7fc7000 rw-p 00015000 08:01 114951     
/lib/i686/cmov/libpthread-2.11.3.so
b7fc7000-b7fca000 rw-p 00000000 00:00 0
b7fca000-b7fcf000 r-xp 00000000 08:01 149564     
/usr/xenomai/lib/libxenomai.so.0.0.0
b7fcf000-b7fd0000 rw-p 00005000 08:01 149564     
/usr/xenomai/lib/libxenomai.so.0.0.0
b7fd0000-b7fda000 r-xp 00000000 08:01 149576     
/usr/xenomai/lib/libpthread_rt.so.1.0.0
b7fda000-b7fdb000 rw-p 00009000 08:01 149576     
/usr/xenomai/lib/libpthread_rt.so.1.0.0
b7fdb000-b7fdc000 rw-p 00000000 00:00 0
b7fdc000-b7fdf000 rw-s f8885000 00:05 88         /dev/rtheap
b7fdf000-b7fe0000 r-xs f8012000 00:05 88         /dev/rtheap
b7fe0000-b7fe2000 rw-p 00000000 00:00 0
b7fe2000-b7fe3000 r-xp 00000000 00:00 0          [vdso]
b7fe3000-b7ffe000 r-xp 00000000 08:01 89948      /lib/ld-2.11.3.so
b7ffe000-b7fff000 r--p 0001b000 08:01 89948      /lib/ld-2.11.3.so
b7fff000-b8000000 rw-p 0001c000 08:01 89948      /lib/ld-2.11.3.so
bffdf000-c0000000 rw-p 00000000 00:00 0          [stack]

TIA

Alessio

-- 

ISTITUTO ITALIANO
DI TECNOLOGIA

Alessio Margan
/Senior Technician/
/Advanced Robotics/

Via Morego, 30 16163 Genova 
<http://maps.google.com/maps?f=q&hl=en&geocode=&q=via+morego,+30+genova&sll=37.0625,-95.677068&sspn=85.420533,191.601563&ie=UTF8&ll=44.474913,8.907037&spn=0.004685,0.011652&t=h&z=17&iwloc=addr>
alessio.margan[at]iit <mailto:alessio.margan@iit.it>

www.iit.it <http://www.iit.it>

*Legal Disclaimer*
This electronic message contains information that is confidential. The 
information is intended for the use of the addressee only. If you are 
not the addressee we would appreciate your notification in this respect. 
Please note that any disclosure, copy, distribution or use of the 
contents of this message is prohibited and may be unlawful. We have 
taken every reasonable precaution to ensure that any kind of attachment 
to this e-mail has been swept for viruses. However, we cannot accept 
liability for any damage sustained as a result of software viruses and 
would advise you to carry out your own virus checks before opening any 
attachment.
*Avvertenza legale*
Questo messaggio Email contiene informazioni confidenziali riservate ai 
soli destinatari. Qualora  veniate in possesso di tali informazioni 
senza essere definito come destinatario vi reghiamo di leggere le 
seguenti note. Ogni apertura, copia, distribuzione del contenuto del 
messaggio e dei suoi allegati è proibito e potrebbe violare le presenti 
leggi. Abbiamo attivato ogni possibile e ragionevole precauzione per 
assicurare che gli allegati non contengano virus. Comunque non 
assumeremo alcuna responsabilità per ogni eventuale danno causato da 
virus software e simili in quanto è onere del destinatario verificarne 
l’assenza in ogni allegato attuando propri indipendenti controlli.

