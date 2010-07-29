Message-ID: <4C50D87B.2010008@domain.hid>
Date: Wed, 28 Jul 2010 18:25:15 -0700
From: Bob Feretich <bob.feretich@domain.hid>
MIME-Version: 1.0
References: <4C4F7930.90408@domain.hid> <4C4F7AF8.8090500@domain.hid>
	<4C4F949F.9090200@domain.hid> <4C4FDFD2.4010405@domain.hid>
In-Reply-To: <4C4FDFD2.4010405@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------020300010506020806080804"
Subject: Re: [Xenomai-help] Xenomai xeno-test hangs on 2.6.31 on BeagleBoard,
 same works on 2.6.33
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------020300010506020806080804
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

  OK, --enable-arm-eabi fixed the latency program, but xeno-test still 
hangs at generate_loads on 2.6.31 (below). xeno-test worked on 2.6.33
.
The Angstrom Distribution beagleboard ttyS2

Angstrom 2010.4-test-20100518 beagleboard ttyS2

beagleboard login: root
root@domain.hid:~# ls /proc
1              28             9              irq            self
10             286            buddyinfo      kallsyms       slabinfo
11             29             bus            kmsg           softirqs
12             3              cmdline        kpagecount     stat
13             4              cpu            kpageflags     swaps
14             49             cpuinfo        loadavg        sys
15             5              crypto         locks          sysrq-trigger
16             6              devices        meminfo        sysvipc
17             662            diskstats      misc           timer_list
18             7              driver         modules        tty
19             790            execdomains    mounts         uptime
2              793            filesystems    mtd            version
20             795            fs             net            vmallocinfo
21             797            interrupts     pagetypeinfo   vmstat
211            798            iomem          partitions     xenomai
212            8              ioports        sched_debug    zoneinfo
27             800            ipipe          scsi
root@domain.hid:~# /usr/xenomai/bin/latency
== Sampling period: 1000 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat 
best|--lat worst
RTD|     17.999|     18.846|     28.615|       0|     0|     17.999|     
28.615
RTD|     12.538|     13.307|     27.923|       0|     0|     12.538|     
28.615
RTD|     12.384|     13.307|     26.461|       0|     0|     12.384|     
28.615
RTD|     12.461|     13.307|     21.538|       0|     0|     12.384|     
28.615
RTD|     12.538|     14.384|     33.923|       0|     0|     12.384|     
33.923
RTD|     12.461|     13.307|     24.230|       0|     0|     12.384|     
33.923
RTD|     12.461|     13.307|     25.923|       0|     0|     12.384|     
33.923
RTD|     12.538|     13.307|     22.769|       0|     0|     12.384|     
33.923
RTD|     12.461|     13.307|     23.769|       0|     0|     12.384|     
33.923
RTD|     12.461|     14.307|     26.769|       0|     0|     12.384|     
33.923
RTD|     12.461|     13.307|     22.923|       0|     0|     12.384|     
33.923
RTD|     12.461|     13.307|     21.384|       0|     0|     12.384|     
33.923
RTD|     12.461|     13.307|     23.384|       0|     0|     12.384|     
33.923
RTD|     12.461|     13.230|     22.153|       0|     0|     12.384|     
33.923
RTD|     12.461|     14.307|     26.615|       0|     0|     12.384|     
33.923
RTD|     12.538|     13.307|     22.538|       0|     0|     12.384|     
33.923
RTD|     12.461|     13.307|     23.461|       0|     0|     12.384|     
33.923
RTD|     12.461|     13.307|     21.923|       0|     0|     12.384|     
33.923
RTD|     12.461|     13.307|     22.769|       0|     0|     12.384|     
33.923
RTD|     12.461|     14.307|     26.923|       0|     0|     12.384|     
33.923
RTD|     12.461|     13.307|     22.538|       0|     0|     12.384|     
33.923
RTT|  00:00:22  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat 
best|--lat worst
RTD|     12.461|     13.230|     21.230|       0|     0|     12.384|     
33.923
RTD|     12.538|     13.307|     21.076|       0|     0|     12.384|     
33.923
RTD|     12.461|     13.307|     20.692|       0|     0|     12.384|     
33.923
RTD|     12.538|     14.230|     27.538|       0|     0|     12.384|     
33.923
RTD|     12.461|     13.230|     22.692|       0|     0|     12.384|     
33.923
RTD|     12.461|     13.307|     20.846|       0|     0|     12.384|     
33.923
RTD|     12.461|     13.230|     21.692|       0|     0|     12.384|     
33.923
RTD|     12.384|     13.307|     21.384|       0|     0|     12.384|     
33.923
RTD|     12.384|     14.230|     26.615|       0|     0|     12.384|     
33.923
RTD|     12.538|     13.307|     22.461|       0|     0|     12.384|     
33.923
---|-----------|-----------|-----------|--------|------|-------------------------
RTS|     12.384|     13.615|     33.923|       0|     0|    
00:00:32/00:00:32
root@domain.hid:~#  /usr/xenomai/bin/xeno-test -s -h -T 20
xeno-test: started -s -h -T 20
withBusybox is 1
xeno-test: running tests
/usr/xenomai/bin/xeno-test: eval: line 1: -h: not found

Tue May 18 20:59:04 UTC 2010
running: /usr/xenomai/bin/xeno-config --verbose
xeno-config --verbose
         --version="2.5.3"
         --cc="arm-angstrom-linux-gnueabi-gcc -march=armv7-a 
-mtune=cortex-a8 -mfpu=neon -mfloat-abi=softfp"
         --arch="arm"
         --prefix="/usr/xenomai"
         --xeno-cflags="-I/usr/xenomai/include -D_GNU_SOURCE 
-D_REENTRANT -Wall -pipe -D__XENO__"
         --xeno-ldflags="-L/usr/xenomai/lib -lxenomai -lpthread "
         --posix-cflags=""
         --posix-ldflags="-Wl,@/usr/xenomai/lib/posix.wrappers 
-L/usr/xenomai/lib -lpthread_rt -lxenomai -lpthread -lr
t "
         --library-dir="/usr/xenomai/lib"

Tue May 18 20:59:04 UTC 2010
running: /usr/xenomai/bin/xeno-info
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

BusyBox v1.13.2 (2010-05-18 15:45:51 PDT) multi-call binary
Linux beagleboard 2.6.31-omap1 #1 Sun Jul 25 16:58:55 PDT 2010 armv7l 
unknown

module-init-tools      3.4
Modules Loaded         omap2_mcspi

Tue May 18 20:59:04 UTC 2010
running: cat /proc/cpuinfo
Processor       : ARMv7 Processor rev 3 (v7l)
BogoMIPS        : 498.07
Features        : swp half thumb fastmult vfp edsp neon vfpv3
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x1
CPU part        : 0xc08
CPU revision    : 3

Hardware        : OMAP3 Beagle Board
Revision        : 0020
Serial          : 0000000000000000

Tue May 18 20:59:04 UTC 2010
running: md5sum /proc/cpuinfo # cpuinfo fingerprint
6f0a1a5525e65155ee727ef0c3403ba9  /proc/cpuinfo

Tue May 18 20:59:04 UTC 2010
running: cat /proc/ipipe/Linux
        +----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)
        |+---- Sticky
        ||+--- Locked
        |||+-- Exclusive
        ||||+- Virtual
[IRQ]  |||||
    0:  A....
    1:  A....
... IRQ counts, values are the same ...
  401:  A....
  416:  G...V
  417:  G...V
[Domain info]
id=0x00000000
priority=100

Tue May 18 20:59:04 UTC 2010
running: cat /proc/ipipe/Xenomai
        +----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)
        |+---- Sticky
        ||+--- Locked
        |||+-- Exclusive
        ||||+- Virtual
[IRQ]  |||||
   37:  W..X.
  418:  W...V
[Domain info]
id=0x58454e4f
priority=topmost

Tue May 18 20:59:04 UTC 2010
running: cat /proc/ipipe/version
1.16-01

Tue May 18 20:59:05 UTC 2010
running: generate_loads 1
dd workload started, pids 905 stored in /var/lock/xeno-test.804.pids


Regards,
Bob Feretich

On 7/28/2010 12:44 AM, Gilles Chanteperdrix wrote:
> Bob Feretich wrote:
>>    On 2.6.33.......... (2.6.31 gives the same result)
>> root@domain.hid:~# /usr/xenomai/bin/latency
>> Xenomai or CONFIG_XENO_OPT_PERVASIVE disabled.
>> (modprobe xeno_nucleus?)
>>
>> BUT, neither are disabled... And, xeno_nucleus is built-in to the kernel.
> Ok. If you are using an EABI toolchain, did you pass --enable-arm-eabi
> to the configure script?
>
>

--------------020300010506020806080804
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#ffffff" text="#000000">
    OK, --enable-arm-eabi fixed the latency program, but xeno-test still
    hangs at generate_loads on 2.6.31 (below). xeno-test worked on
    2.6.33<br>
    .<br>
    <small><tt>The Angstrom Distribution beagleboard ttyS2<br>
        <br>
        Angstrom 2010.4-test-20100518 beagleboard ttyS2<br>
        <br>
        beagleboard login: root<br>
        root@domain.hid:~# ls /proc<br>
        1              28             9              irq            self<br>
        10             286            buddyinfo      kallsyms      
        slabinfo<br>
        11             29             bus            kmsg          
        softirqs<br>
        12             3              cmdline        kpagecount     stat<br>
        13             4              cpu            kpageflags    
        swaps<br>
        14             49             cpuinfo        loadavg        sys<br>
        15             5              crypto         locks         
        sysrq-trigger<br>
        16             6              devices        meminfo       
        sysvipc<br>
        17             662            diskstats      misc          
        timer_list<br>
        18             7              driver         modules        tty<br>
        19             790            execdomains    mounts        
        uptime<br>
        2              793            filesystems    mtd           
        version<br>
        20             795            fs             net           
        vmallocinfo<br>
        21             797            interrupts     pagetypeinfo  
        vmstat<br>
        211            798            iomem          partitions    
        xenomai<br>
        212            8              ioports        sched_debug   
        zoneinfo<br>
        27             800            ipipe          scsi<br>
        root@domain.hid:~# /usr/xenomai/bin/latency<br>
        == Sampling period: 1000 us<br>
        == Test mode: periodic user-mode task<br>
        == All results in microseconds<br>
        warming up...<br>
        RTT|  00:00:01  (periodic user-mode task, 1000 us period,
        priority 99)<br>
        RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat
        best|--lat worst<br>
        RTD|     17.999|     18.846|     28.615|       0|     0|    
        17.999|     28.615<br>
        RTD|     12.538|     13.307|     27.923|       0|     0|    
        12.538|     28.615<br>
        RTD|     12.384|     13.307|     26.461|       0|     0|    
        12.384|     28.615<br>
        RTD|     12.461|     13.307|     21.538|       0|     0|    
        12.384|     28.615<br>
        RTD|     12.538|     14.384|     33.923|       0|     0|    
        12.384|     33.923<br>
        RTD|     12.461|     13.307|     24.230|       0|     0|    
        12.384|     33.923<br>
        RTD|     12.461|     13.307|     25.923|       0|     0|    
        12.384|     33.923<br>
        RTD|     12.538|     13.307|     22.769|       0|     0|    
        12.384|     33.923<br>
        RTD|     12.461|     13.307|     23.769|       0|     0|    
        12.384|     33.923<br>
        RTD|     12.461|     14.307|     26.769|       0|     0|    
        12.384|     33.923<br>
        RTD|     12.461|     13.307|     22.923|       0|     0|    
        12.384|     33.923<br>
        RTD|     12.461|     13.307|     21.384|       0|     0|    
        12.384|     33.923<br>
        RTD|     12.461|     13.307|     23.384|       0|     0|    
        12.384|     33.923<br>
        RTD|     12.461|     13.230|     22.153|       0|     0|    
        12.384|     33.923<br>
        RTD|     12.461|     14.307|     26.615|       0|     0|    
        12.384|     33.923<br>
        RTD|     12.538|     13.307|     22.538|       0|     0|    
        12.384|     33.923<br>
        RTD|     12.461|     13.307|     23.461|       0|     0|    
        12.384|     33.923<br>
        RTD|     12.461|     13.307|     21.923|       0|     0|    
        12.384|     33.923<br>
        RTD|     12.461|     13.307|     22.769|       0|     0|    
        12.384|     33.923<br>
        RTD|     12.461|     14.307|     26.923|       0|     0|    
        12.384|     33.923<br>
        RTD|     12.461|     13.307|     22.538|       0|     0|    
        12.384|     33.923<br>
        RTT|  00:00:22  (periodic user-mode task, 1000 us period,
        priority 99)<br>
        RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat
        best|--lat worst<br>
        RTD|     12.461|     13.230|     21.230|       0|     0|    
        12.384|     33.923<br>
        RTD|     12.538|     13.307|     21.076|       0|     0|    
        12.384|     33.923<br>
        RTD|     12.461|     13.307|     20.692|       0|     0|    
        12.384|     33.923<br>
        RTD|     12.538|     14.230|     27.538|       0|     0|    
        12.384|     33.923<br>
        RTD|     12.461|     13.230|     22.692|       0|     0|    
        12.384|     33.923<br>
        RTD|     12.461|     13.307|     20.846|       0|     0|    
        12.384|     33.923<br>
        RTD|     12.461|     13.230|     21.692|       0|     0|    
        12.384|     33.923<br>
        RTD|     12.384|     13.307|     21.384|       0|     0|    
        12.384|     33.923<br>
        RTD|     12.384|     14.230|     26.615|       0|     0|    
        12.384|     33.923<br>
        RTD|     12.538|     13.307|     22.461|       0|     0|    
        12.384|     33.923<br>
---|-----------|-----------|-----------|--------|------|-------------------------<br>
        RTS|     12.384|     13.615|     33.923|       0|     0|   
        00:00:32/00:00:32<br>
        root@domain.hid:~#  /usr/xenomai/bin/xeno-test -s -h -T 20 <br>
        xeno-test: started -s -h -T 20<br>
        withBusybox is 1<br>
        xeno-test: running tests<br>
        /usr/xenomai/bin/xeno-test: eval: line 1: -h: not found<br>
        <br>
        Tue May 18 20:59:04 UTC 2010<br>
        running: /usr/xenomai/bin/xeno-config --verbose<br>
        xeno-config --verbose<br>
                --version="2.5.3"<br>
                --cc="arm-angstrom-linux-gnueabi-gcc -march=armv7-a
        -mtune=cortex-a8 -mfpu=neon -mfloat-abi=softfp"<br>
                --arch="arm"<br>
                --prefix="/usr/xenomai"<br>
                --xeno-cflags="-I/usr/xenomai/include -D_GNU_SOURCE
        -D_REENTRANT -Wall -pipe -D__XENO__"<br>
                --xeno-ldflags="-L/usr/xenomai/lib -lxenomai -lpthread "<br>
                --posix-cflags=""<br>
                --posix-ldflags="-Wl,@/usr/xenomai/lib/posix.wrappers
        -L/usr/xenomai/lib -lpthread_rt -lxenomai -lpthread -lr<br>
        t "<br>
                --library-dir="/usr/xenomai/lib"<br>
        <br>
        Tue May 18 20:59:04 UTC 2010<br>
        running: /usr/xenomai/bin/xeno-info<br>
        If some fields are empty or look unusual you may have an old
        version.<br>
        Compare to the current minimal requirements in
        Documentation/Changes.<br>
         <br>
        BusyBox v1.13.2 (2010-05-18 15:45:51 PDT) multi-call binary<br>
        Linux beagleboard 2.6.31-omap1 #1 Sun Jul 25 16:58:55 PDT 2010
        armv7l unknown<br>
         <br>
        module-init-tools      3.4<br>
        Modules Loaded         omap2_mcspi<br>
        <br>
        Tue May 18 20:59:04 UTC 2010<br>
        running: cat /proc/cpuinfo<br>
        Processor       : ARMv7 Processor rev 3 (v7l)<br>
        BogoMIPS        : 498.07<br>
        Features        : swp half thumb fastmult vfp edsp neon vfpv3 <br>
        CPU implementer : 0x41<br>
        CPU architecture: 7<br>
        CPU variant     : 0x1<br>
        CPU part        : 0xc08<br>
        CPU revision    : 3<br>
        <br>
        Hardware        : OMAP3 Beagle Board<br>
        Revision        : 0020<br>
        Serial          : 0000000000000000<br>
        <br>
        Tue May 18 20:59:04 UTC 2010<br>
        running: md5sum /proc/cpuinfo # cpuinfo fingerprint<br>
        6f0a1a5525e65155ee727ef0c3403ba9  /proc/cpuinfo<br>
        <br>
        Tue May 18 20:59:04 UTC 2010<br>
        running: cat /proc/ipipe/Linux<br>
               +----- Handling ([A]ccepted, [G]rabbed, [W]ired,
        [D]iscarded)<br>
               |+---- Sticky<br>
               ||+--- Locked<br>
               |||+-- Exclusive<br>
               ||||+- Virtual<br>
        [IRQ]  |||||<br>
           0:  A....<br>
           1:  A....<br>
        ... IRQ counts, values are the same ...<br>
         401:  A....<br>
         416:  G...V<br>
         417:  G...V<br>
        [Domain info]<br>
        id=0x00000000<br>
        priority=100<br>
        <br>
        Tue May 18 20:59:04 UTC 2010<br>
        running: cat /proc/ipipe/Xenomai<br>
               +----- Handling ([A]ccepted, [G]rabbed, [W]ired,
        [D]iscarded)<br>
               |+---- Sticky<br>
               ||+--- Locked<br>
               |||+-- Exclusive<br>
               ||||+- Virtual<br>
        [IRQ]  |||||<br>
          37:  W..X.<br>
         418:  W...V<br>
        [Domain info]<br>
        id=0x58454e4f<br>
        priority=topmost<br>
        <br>
        Tue May 18 20:59:04 UTC 2010<br>
        running: cat /proc/ipipe/version<br>
        1.16-01<br>
        <br>
        Tue May 18 20:59:05 UTC 2010<br>
        running: generate_loads 1<br>
        dd workload started, pids 905 stored in
        /var/lock/xeno-test.804.pids</tt></small><br>
    <br>
    <br>
    Regards,<br>
    Bob Feretich<br>
    <br>
    On 7/28/2010 12:44 AM, Gilles Chanteperdrix wrote:
    <blockquote cite="mid:4C4FDFD2.4010405@domain.hid" type="cite">
      <pre wrap="">Bob Feretich wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">  On 2.6.33.......... (2.6.31 gives the same result)
root@domain.hid:~# /usr/xenomai/bin/latency
Xenomai or CONFIG_XENO_OPT_PERVASIVE disabled.
(modprobe xeno_nucleus?)

BUT, neither are disabled... And, xeno_nucleus is built-in to the kernel.
</pre>
      </blockquote>
      <pre wrap="">
Ok. If you are using an EABI toolchain, did you pass --enable-arm-eabi
to the configure script?


</pre>
    </blockquote>
  </body>
</html>

--------------020300010506020806080804--

