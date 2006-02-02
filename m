Message-ID: <43E288AA.3050203@domain.hid>
Date: Thu, 02 Feb 2006 15:33:14 -0700
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] some results on my laptop
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


some random sucesses ..

Ive been running an ipipe kernel as the default since shortly after 1/7.
Since then, Ive had a couple of freezes on boot,
and sometimes bash's auto-complete takes longer to complete,
but other than that, things have been solid.

But that kernel wasnt configured using scripts/prepare-kernel.sh,
so was missing the xeno_* modules.

[jimc@domain.hid latency]$ sudo ./run -- -T 120 -h
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: periodic user-mode task
warming up...
RTT|  00:00:05  (periodic user-mode task, 100 us period)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat 
worst
RTD|       -4749|       -4585|       -3921|       0|       -4749|       
-3921
RTD|       -4749|       -4583|       -3015|       0|       -4749|       
-3015
RTD|       -4749|       -4578|       -2685|       0|       -4749|       
-2685
RTD|       -4750|       -4581|       -3015|       0|       -4750|       
-2685
RTD|       -4812|       -4578|       -3049|       0|       -4812|       
-2685
RTD|       -4757|       -4584|       -3785|       0|       -4812|       
-2685
RTD|       -4798|       -4584|       -2636|       0|       -4812|       
-2636
RTD|       -4757|       -4582|       -3029|       0|       -4812|       
-2636
RTD|       -4748|       -4582|       -3906|       0|       -4812|       
-2636
RTD|       -4751|       -4582|       -2666|       0|       -4812|       
-2636
RTD|       -4752|       -4582|       -2806|       0|       -4812|       
-2636
RTD|       -4748|       -4581|       -3157|       0|       -4812|       
-2636
RTD|       -4750|       -4583|       -2882|       0|       -4812|       
-2636
RTD|       -4779|       -4583|       -2816|       0|       -4812|       
-2636
RTD|       -4804|       -4585|       -2979|       0|       -4812|       
-2636
RTD|       -4747|       -4583|       -2684|       0|       -4812|       
-2636
RTD|       -4761|       -4583|       -2600|       0|       -4812|       
-2600
RTD|       -4763|       -4583|       -2782|       0|       -4812|       
-2600
RTD|       -4807|       -4584|       -2582|       0|       -4812|       
-2582
RTD|       -4787|       -4582|       -2721|       0|       -4812|       
-2582
RTD|       -4766|       -4584|       -2713|       0|       -4812|       
-2582
RTT|  00:01:04  (periodic user-mode task, 100 us period)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat 
worst
RTD|       -4750|       -4584|       -2936|       0|       -4812|       
-2582
RTD|       -4749|       -4585|       -2736|       0|       -4812|       
-2582
RTD|       -4814|       -4586|       -2935|       0|       -4814|       
-2582
RTD|       -4781|       -4584|       -2884|       0|       -4814|       
-2582
RTD|       -4749|       -4579|       -2743|       0|       -4814|       
-2582
RTD|       -4749|       -4580|       -2708|       0|       -4814|       
-2582
RTD|       -4750|       -4585|       -2870|       0|       -4814|       
-2582
RTD|       -4748|       -4584|       -2761|       0|       -4814|       
-2582
RTD|       -4766|       -4585|       -3152|       0|       -4814|       
-2582
RTD|       -4755|       -4584|       -3001|       0|       -4814|       
-2582
RTD|       -4749|       -4584|       -2810|       0|       -4814|       
-2582
RTD|       -4748|       -4584|       -2935|       0|       -4814|       
-2582
RTD|       -4754|       -4584|       -2734|       0|       -4814|       
-2582
RTD|       -4789|       -4586|       -3109|       0|       -4814|       
-2582
RTD|       -4765|       -4583|       -2835|       0|       -4814|       
-2582
RTD|       -4751|       -4584|       -2767|       0|       -4814|       
-2582
RTD|       -4750|       -4582|       -2831|       0|       -4814|       
-2582
RTD|       -4750|       -4585|       -2829|       0|       -4814|       
-2582
RTD|       -4782|       -4584|       -2751|       0|       -4814|       
-2582
RTD|       -4750|       -4584|       -2851|       0|       -4814|       
-2582
---|--param|----range-|--samples
HSD|    min|   4 -  5 |       41
---|--param|----range-|--samples
HSD|    avg|   2 -  3 |       60
HSD|    avg|   3 -  4 |      429
HSD|    avg|   4 -  5 |   416620
---|--param|----range-|--samples
HSD|    max|   2 -  3 |       30
HSD|    max|   3 -  4 |       11
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|        41|      4.000|      0.000
HSS|    avg|    417109|      3.999|      0.040
HSS|    max|        41|      2.268|      0.449
---|------------|------------|------------|--------|-------------------------
RTS|       -4814|       -4583|       -2582|       0|    00:02:00/00:02:00


This was run on a pentium-M laptop,
with cpu-clock running at 600 MHz, (capable of 1.7 GHz)
I presume this might explain the negative latancies.
Im aware this is un-supported ..

The only thing that looks wrong is the test-duration.
I asked for 120 sec, it gave me 40 samples.
The test did take 120 to run.


heres config, info, and -t1 and -t2 runs:


[jimc@domain.hid bin]$ xeno-info
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux harpo.jimc.earth 2.6.15.1-ipipe-103-sony #2 Thu Feb 2 14:50:16 MST 
2006 i686 i686 i386 GNU/Linux

Gnu C                  4.0.2
Gnu make               3.80
util-linux             2.12p
mount                  2.12p
module-init-tools      3.1
e2fsprogs              1.38
pcmcia-cs              3.2.8
PPP                    2.4.2
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         snd_seq_midi snd_rawmidi radeon sonypi nfsd 
exportfs lockd sunrpc ipv6 autofs4 eeprom pcmcia ipt_REJECT ipt_LOG 
ipt_state ip_conntrack iptable_filter ip_tables isofs zlib_inflate loop 
vfat fat video container button battery asus_acpi ac ohci1394 ieee1394 
yenta_socket rsrc_nonstatic pl2303 usbserial pcmcia_core uhci_hcd 
ohci_hcd ehci_hcd intel_agp shpchp i2c_i801 i2c_core snd_intel8x0m 
snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_oss 
snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss 
snd_pcm snd_timer snd soundcore snd_page_alloc ipw2200 ieee80211 hostap 
ieee80211_crypt e1000 joydev ext3 jbd


[jimc@domain.hid bin]$ xeno-config
xeno-config --verbose
    --version="2.0.92"
    --cc="gcc"
    --arch="i386"
    --prefix="/usr/xenomai"
    --xeno-cflags="-I. -I/usr/xenomai/include -O2 -D_GNU_SOURCE 
-D_REENTRANT -D__XENO__ -Wall -pipe -fstrict-aliasing -Wno-strict-aliasing"
    --xeno-ldflags="-L/usr/xenomai/lib -lpthread "
    --posix-cflags="-I. -I/usr/xenomai/include 
-I/usr/xenomai/include/posix -O2 -D_GNU_SOURCE -D_REENTRANT -D__XENO__ 
-Wall -pipe -fstrict-aliasing -Wno-strict-aliasing"
    --posix-ldflags="-L/usr/xenomai/lib -lpthread_rt -lpthread -lrt "
    --uvm-cflags="-I. -I/usr/xenomai/include -O2 -D_GNU_SOURCE 
-D_REENTRANT -D__XENO__ -Wall -pipe -fstrict-aliasing 
-Wno-strict-aliasing -D__XENO_UVM__ "
    --uvm-ldflags="-u__xeno_skin_init -L/usr/xenomai/lib -luvm -lnucleus 
-lpthread"
    --library-dir="/usr/xenomai/lib"
Usage xeno-config OPTIONS
Options :
        --help
        --v,--verbose
        --version
        --cc
        --arch
        --prefix
        --xeno-cflags
        --xeno-ldflags
        --posix-cflags
        --posix-ldflags
        --uvm-cflags
        --uvm-ldflags
        --lib*-dir,--libdir,--user-libdir


[jimc@domain.hid latency]$ sudo ./run -- -T 60 -h -t 1
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: in-kernel periodic task
warming up...
RTT|  00:00:05  (in-kernel periodic task, 100 us period)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat 
worst
RTD|       -5331|       -5171|       -4688|       0|       -5331|       
-4688
RTD|       -5331|       -5166|       -3350|       0|       -5331|       
-3350
RTD|       -5330|       -5169|       -3467|       0|       -5331|       
-3350
RTD|       -5331|       -5169|       -3265|       0|       -5331|       
-3265
RTD|       -5331|       -5170|       -3396|       0|       -5331|       
-3265
RTD|       -5331|       -5170|       -3530|       0|       -5331|       
-3265
RTD|       -5331|       -5171|       -3440|       0|       -5331|       
-3265
RTD|       -5331|       -5171|       -3511|       0|       -5331|       
-3265
RTD|       -5331|       -5172|       -3389|       0|       -5331|       
-3265
RTD|       -5330|       -5171|       -3801|       0|       -5331|       
-3265
RTD|       -5331|       -5171|       -3316|       0|       -5331|       
-3265
RTD|       -5331|       -5171|       -4631|       0|       -5331|       
-3265
RTD|       -5330|       -5169|       -3481|       0|       -5331|       
-3265
RTD|       -5331|       -5171|       -3419|       0|       -5331|       
-3265
RTD|       -5331|       -5169|       -3357|       0|       -5331|       
-3265
RTD|       -5331|       -5147|       -3027|       0|       -5331|       
-3027
RTD|       -5331|       -5141|       -3361|       0|       -5331|       
-3027
RTD|       -5331|       -5170|       -4652|       0|       -5331|       
-3027
RTD|       -5331|       -5168|       -3354|       0|       -5331|       
-3027
RTD|       -5330|       -5147|       -3117|       0|       -5331|       
-3027
---|--param|----range-|--samples
HSD|    min|   5 -  6 |       20
---|--param|----range-|--samples
HSD|    avg|   3 -  4 |       91
HSD|    avg|   4 -  5 |     6194
HSD|    avg|   5 -  6 |   199025
---|--param|----range-|--samples
HSD|    max|   3 -  4 |       17
HSD|    max|   4 -  5 |        3
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|        20|      5.000|      0.000
HSS|    avg|    205310|      4.969|      0.176
HSS|    max|        20|      3.150|      0.366
---|------------|------------|------------|--------|-------------------------
RTS|       -5331|       -5166|       -3027|       0|    00:01:00/00:01:00


[jimc@domain.hid latency]$ sudo ./run -- -T 60 -h -t 2
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: in-kernel timer handler
warming up...
RTT|  00:00:05  (in-kernel timer handler, 100 us period)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat 
worst
RTD|       -6502|       -6357|       -6146|       0|       -6502|       
-6146
RTD|       -6498|       -6357|       -6032|       0|       -6502|       
-6032
RTD|       -6503|       -6356|       -6133|       0|       -6503|       
-6032
RTD|       -6503|       -6357|       -6084|       0|       -6503|       
-6032
RTD|       -6504|       -6357|       -6140|       0|       -6504|       
-6032
RTD|       -6502|       -6357|       -6134|       0|       -6504|       
-6032
RTD|       -6501|       -6357|       -6031|       0|       -6504|       
-6031
RTD|       -6504|       -6357|       -6133|       0|       -6504|       
-6031
RTD|       -6502|       -6357|       -6144|       0|       -6504|       
-6031
RTD|       -6502|       -6356|       -6149|       0|       -6504|       
-6031
RTD|       -6501|       -6356|       -6128|       0|       -6504|       
-6031
RTD|       -6502|       -6356|       -6133|       0|       -6504|       
-6031
RTD|       -6504|       -6357|       -6112|       0|       -6504|       
-6031
RTD|       -6502|       -6357|       -6108|       0|       -6504|       
-6031
RTD|       -6503|       -6356|       -6159|       0|       -6504|       
-6031
RTD|       -6502|       -6357|       -5939|       0|       -6504|       
-5939
RTD|       -6503|       -6356|       -6112|       0|       -6504|       
-5939
RTD|       -6502|       -6357|       -6146|       0|       -6504|       
-5939
RTD|       -6499|       -6357|       -6156|       0|       -6504|       
-5939
RTD|       -6498|       -6357|       -6160|       0|       -6504|       
-5939
---|--param|----range-|--samples
HSD|    min|   6 -  7 |       20
---|--param|----range-|--samples
HSD|    avg|   5 -  6 |        1
HSD|    avg|   6 -  7 |   205310
---|--param|----range-|--samples
HSD|    max|   5 -  6 |        1
HSD|    max|   6 -  7 |       19
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|        20|      6.000|      0.000
HSS|    avg|    205311|      6.000|      0.002
HSS|    max|        20|      5.950|      0.224
---|------------|------------|------------|--------|-------------------------
RTS|       -6504|       -6356|       -5939|       0|    00:01:00/00:01:00
[jimc@domain.hid latency]$


hope this is usefull

