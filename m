MIME-Version: 1.0
From: Ashwin Narayan <ashwinnarayan1994@gmail.com>
Date: Tue, 11 Apr 2017 18:22:18 +0800
Message-ID: <CAKbLDQOXrHX2bZd0jZ=WEBG7rDZ8OeKuFHpSDZy98s6NxR50FQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Advantech PCM3680I with Xenomai: Probe failed with error
	-5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Dear All,

I'm having trouble getting the Advantech PCM3680I working under
xenomai. I scanned the dmesg log and this is what I get:

[    1.344697] RT-Socket-CAN 0.90.2 - (C) 2006 RT-Socket-CAN Development Team
[    1.344794] RTCAN SJA1000 driver initialized
[    1.344989] ADV-PCI-CAN 0000:01:04.0: RTCAN Registering card
[    1.345281] ADV-PCI-CAN 0000:01:04.0: RTCAN detected Advantech PCI
card at slot #4
[    1.345295] ADV-PCI-CAN: Initializing device 13fe:c002:c002
[    1.345310] ADV-PCI-CAN: base_addr=000000000001ef00 conf_addr=
    (null) irq=16 ocr=0xfa cdr=0xc0
[    1.345373] rtcan: registered rtcan0
[    1.345386] Unregistering SJA1000 device rtcan0
[    1.345403] RTCAN: unregistered rtcan0
[    1.345646] ADV-PCI-CAN: probe of 0000:01:04.0 failed with error -5
[    1.345793] rtcan: registered rtcan0
[    1.345799] rtcan0: VIRT driver loaded
[    1.345818] rtcan: registered rtcan1
[    1.345824] rtcan1: VIRT driver loaded

At first I suspected that the problem could be that the kernel was
compiled with the Networking Devices -> CAN Subsystem enabled. So I
disabled that and recompiled the kernel and I got the same error
message.

To find out where the error message is coming from, I tried running
the command grep -rnw . -e "probe f" from the directory
xenomai-3.0.4/. Couldn't find that string anywhere in the source.

Does anyone have any experience with this CAN bus card and what it
might take to get it to work?

Thanks,
-Ashwin

