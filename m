Date: Tue, 26 Oct 2004 10:31:07 -0400 (EDT)
From: Currie Reid <curriereid@domain.hid>
Message-ID: <Pine.LNX.4.44L.0410261021030.2972-100000@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Adeos-main] Spurious interrupts on boot
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: adeos-main@gna.org

Hello all,

I have applied adeos-linuxppc-2.6.8rc1-r6c8.patch to my kernel, and
everything seems to be working fine so far, but I notice that the
ppc_spurious_interrupts count runs up on boot:

           CPU0
 19:       2239   OpenPIC   Level     ide0
 20:         12   OpenPIC   Level     ide1
 25:      10855   OpenPIC   Level     VIA-PMU
 41:       4415   OpenPIC   Level     eth0
 47:          0   OpenPIC   Level     GPIO1/ADB
BAD:       1426

The good news is that it doesn't increase, but without the patch, the
BAD count stays at 0.  Is this a known issue?  I haven't found any
reference to it on the mailing list.

My machine g4 powermac:
processor       : 0
cpu             : 7400, altivec supported
temperature     : 7-9 C (uncalibrated)
clock           : 400MHz
revision        : 2.8 (pvr 000c 0208)
bogomips        : 794.62
machine         : PowerMac3,3
motherboard     : PowerMac3,3 MacRISC2 MacRISC Power Macintosh
detected as     : 65 (PowerMac G4 AGP Graphics)
pmac flags      : 00000004
L2 cache        : 1024K unified
memory          : 1024MB
pmac-generation : NewWorld

Thanks

Currie Reid


