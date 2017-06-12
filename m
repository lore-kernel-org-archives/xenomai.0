MIME-Version: 1.0
Date: Mon, 12 Jun 2017 14:46:33 +0200
From: raffaelemariotti@tiscali.it
Message-ID: <5da37596d984e6be5c74ed5102688c0a@tiscali.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Xenomai-3 installation problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

  

Hi all, 

as a linux newbie I'd need some clarification about the
installation of Xenomai on a BeagleBone Black board. The followings are
the steps I performed to get a Xenomai dual-kernel system (Cobalt) over
a prebuilted raw microSD image installed
(bone-debian-8.8-console-armhf-2017-05-21-2gb): 

	* 

installation of
xenomai prebuilt linux image:  

 ROOT@ARM:/# APT-GET INSTALL
LINUX-IMAGE-4.4.62-TI-XENOMAI-R104 

 Checking the version of the
patches I get: 

 ROOT@ARM:/# CAT /PROC/XENOMAI/VERSION 

 3.0.4 


ROOT@ARM:/# CAT /PROC/IPIPE/VERSION 

 7 

	* 

installation of
xenomai-runtime: 

 ROOT@ARM:/# APT-GET INSTALL XENOMAI-RUNTIME  

	*


carefully followed the xenomai.org guide "Building Debian Packages"
until the installation step:  

 ROOT@ARM:/# DPKG -I *.DEB 

	*


configuration, building and installation of the Xenomai library/tools
on the Beaglebone (I suppose no need here -host and -build options
because the application will be cross-compiled on a x86_32 desktop):  


ROOT@ARM:/XENOMAI/XENOMAI-3.0.4# ./CONFIGURE CFLAGS="-MARCH=ARMV7-A
-MTUNE=CORTEX-A8 -MFLOAT-ABI=HARD -MFPU=NEON -FFAST-MATH"
LDFLAGS="-MARCH=ARMV7-A -MTUNE=CORTEX-A8 -MFLOAT-ABI=HARD -MFPU=NEON
-FFAST-MATH" -WITH-CORE=COBALT --ENABLE-SMP --ENABLE-PSHARED
--DISABLE-DEBUG 

 ROOT@ARM:/XENOMAI/XENOMAI-3.0.4# MAKE 


ROOT@ARM:/XENOMAI/XENOMAI-3.0.4# MAKE INSTALL 

And here is the latency
test result: 

 ROOT@ARM:/USR/XENOMAI/BIN#./LATENCY 

== Sampling
period: 1000 us 

== Test mode: periodic user-mode task 

== All results
in microseconds 

warming up... 

RTT| 00:00:01 (periodic user-mode
task, 1000 us period, priority 99) 

RTH|----lat min|----lat avg|----lat
max|-overrun|---msw|---lat best|--lat worst 

RTD| 24.499| 37.344|
56.541| 0| 0| 24.499| 56.541 

RTD| 24.332| 37.047| 69.499| 0| 0|
24.332| 69.499 

RTD| 24.415| 37.641| 67.249| 0| 0| 24.332| 69.499


RTD| 24.290| 36.773| 68.249| 0| 0| 24.290| 69.499 

RTD| 24.207|
37.180| 68.957| 0| 0| 24.207| 69.499 

RTD| 24.373| 36.680| 72.915| 0|
0| 24.207| 72.915 

RTD| 24.248| 36.736| 72.706| 0| 0| 24.207| 72.915


RTD| 24.081| 36.374| 70.581| 0| 0| 24.081| 72.915 

RTD| 24.164|
36.783| 76.706| 0| 0| 24.081| 76.706 

RTD| 23.580| 36.188| 72.081| 0|
0| 23.580| 76.706 

RTD| 24.205| 36.345| 67.997| 0| 0| 23.580| 76.706


RTD| 24.247| 36.001| 69.580| 0| 0| 23.580| 76.706 

RTD| 24.288|
36.251| 68.205| 0| 0| 23.580| 76.706

Checking the kernel boot log I
get: 

 ROOT@ARM:/# DMESG | GREP -I XENOMAI 

 [ 0.000000] Linux version
4.4.62-ti-xenomai-r104 (root@a3-imx6q-wandboard-2gb) (gcc version 4.9.2
(Debian 4.9.2-10) ) #1 SMP Fri May 19 00:35:20 UTC 2017 

 [ 2.134461]
[Xenomai] scheduling class idle registered. 

 [ 2.134477] [Xenomai]
scheduling class rt registered. 

 [ 2.134662] I-pipe: head domain
Xenomai registered. 

 [ 2.137755] [Xenomai] Cobalt v3.0.4 (Washed Out
Harlequin) 

 [ 2.320257] usb usb1: Manufacturer: Linux
4.4.62-ti-xenomai-r104 musb-hcd 

Googling around I noticed that the
kernel boot log should show messages like "hal/arm started" as well as
related services (rtdm...posix). Even the Xenomai-3 Installation guide
states: 

 $ dmesg | grep -i xenomai 

 I-pipe:head domain Xenomai
registered. 

 [Xenomai] Cobalt vX.Y.Z ENABLED 

It seems that my
xenomai kernel won't boot. Did I missed some steps ? 

Lastly, I'm
developing a single-task realtime project (SPI, PWM and I2C will be
used) with the support of Qt libraries (Qt-5.2). To semplify debugging
and development I'd prefer to use the user-space. Is there any reason
why I should use the kernel-space instead?

I apologize in advance for
such naive questions...this is my first approach to linux embedded
systems. 

Any help will be greatly appreciated. 

Thanks for your time.


Raffaele  


Con Open 4 Giga a 9 euro/4 sett navighi veloce, chiami e invii SMS dal tuo smartphone verso tutti i fissi e mobili in Italia. Passa a Tiscali Mobile! http://casa.tiscali.it/mobile/

