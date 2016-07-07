MIME-Version: 1.0
From: marc favereau <favereau.marc.m2gl@gmail.com>
Date: Thu, 7 Jul 2016 14:40:03 +0200
Message-ID: <CALZu-7YbLMszbw+82nWzZ+9W=VYKY0s81UGmq=UvQw_fg3XHrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai]  Serial port problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I have to use a MOXA CP-134 card to communicate with a device (1 port for
writing and 1 port for reading) in RS422.
I'm using Xenomai 2.6.4 on a kernel linux 3.8.13 installed on a Xeon
E5-2430 multicore desktop.
I plug the card on a PCIe slot, that's why i configure kernel options like
this :

Real-time sub-system->Drivers->Serial Drivers->16550A UART driver *
Real-time sub-system->Drivers->Serial Drivers->Hardware acces mode = Any
acces mode
Real-time sub-system->Drivers->Serial Drivers->PCI board support *
Real-time sub-system->Drivers->Serial Drivers->Moxa PCI boards *


So my card seems be good :

ll /proc/xenomai/rtdm give me RTSER0, RTSER1, RTSER2 and RTSER3

cat /sys/module/xeno_16550A/parameters/irq give me 19,19,19,19,0,0,0,0
cat /sys/module/xeno_16550A/parameters/baud_base give me
921600,921600,921600,921600,0,0,0,0

All seems to be good but when I try test with the xenomai example
cross-link.c
i open RTSER0 without problems but i can't open an other RTSER : "Device or
ressource busy"

when i read the driver code source (16550A.c) i think there is a problem
with 'rtdm_irq_request' function. It's like the IRQ was not shared between
the 4 ports of the card !!!

I don't understand why !

 Any advice would be greatly appreciated.

Best regards,
Marc.
