Message-ID: <4D9F2804.5030205@domain.hid>
Date: Fri, 08 Apr 2011 17:21:40 +0200
From: Martin Elshuber <martine@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] ADEOS NIOS II port - definitions in
	include/asm-nios2/ipipe.h
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Hello,

I faced a problem with Xenomai xntimer when using the
http://download.gna.org/adeos/patches/v2.6/nios2/adeos-ipipe-2.6.30-nios2-1.2-00.patch
patch.

xntimer uses the ipipe abstractions for hrclock and hrtimer and relies 
on the constants

#define __ipipe_hrtimer_freq    1000000 /* 1 us */
#define __ipipe_hrclock_freq    nasys_clock_freq

defined in include/asm-nios2/ipipe.h to do a final adjustment.

The two definitions above will fail, if either the hrtimer is not 
clocked with 1Mhz, or
the hrclock is clocked with another frequency than nasys_clock_freq.
I am quite new to ADEOS, but guess that

#define __ipipe_hrtimer_freq    na_hrtimer_clock_freq
#define __ipipe_hrclock_freq    na_hrclock_clock_freq

is a better choice. At least for me this solves the problem.

Martin Elshuber


