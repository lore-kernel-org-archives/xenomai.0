From: Sebastian Smolorz <smolorz@domain.hid>
Date: Fri, 20 Nov 2009 16:09:12 +0100
References: <4B058624.6000401@domain.hid>
In-Reply-To: <4B058624.6000401@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_YErBL2jwn5SImxr"
Message-Id: <200911201609.12842.smolorz@domain.hid>
Subject: Re: [Xenomai-help] problem with RT-Socket-CAN xeno_can_isa module
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Alessio Margan @ IIT" <alessio.margan@domain.hid>
Cc: xenomai@xenomai.org

--Boundary-00=_YErBL2jwn5SImxr
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit

Alessio Margan @ IIT wrote:
> I've got a problem using RT-Socket-CAN with module xeno_can_isa.
> The system has a pcan-pc/104 board with a sja1000
> The first tme I load to module with
> sudo modprobe xeno_can_isa io=0x300,0x320 irq=10,11
> everything work fine, then if I try to unload the module seems that the
> ioport region remain allocated from xeno_can_isa
> but the module is unloaded and if I try to load it again the command
> fail with "Device or resource busy" and I have to reboot.

Does this patch work for you?

-- 
Sebastian

--Boundary-00=_YErBL2jwn5SImxr
Content-Type: text/x-patch;
  charset="UTF-8";
  name="rtcan_isa.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rtcan_isa.patch"

--- rtcan_isa.c~	2009-11-20 15:58:31.000000000 +0100
+++ rtcan_isa.c	2009-11-20 15:59:21.000000000 +0100
@@ -189,6 +189,7 @@ static void rtcan_isa_exit(void)
 		if (!dev)
 			continue;
 		rtcan_sja1000_unregister(dev);
+                release_region(io[i], RTCAN_ISA_PORT_SIZE);
 		rtcan_dev_free(dev);
 	}
 }

--Boundary-00=_YErBL2jwn5SImxr--

