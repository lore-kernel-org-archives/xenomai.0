MIME-Version: 1.0
Date: Mon, 23 Apr 2012 03:51:06 +0200
Message-ID: <CAKvQZ_2H38BtL++2LMhnh_1YOFcia4tR-5FyuQ1SskO3er2RrA@mail.gmail.com>
From: Willy Lambert <lambert.willy@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] Smi workaround on ICH8M
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

I have a message  in dmesg about SMI workaround :
Xenomai: SMI-enabled chipset found, but SMI workaround disabled
         (check CONFIG_XENO_HW_SMI_WORKAROUND). You may encounter
         high interrupt latencies!

My kernel should be configured properly and following the "In case of
high latencies" of
http://www.xenomai.org/index.php/Configuring_x86_kernels thread, I did
some tests.

Latency test is here (if it is us it should be ok no ?):

RTT|  00:00:22  (periodic user-mode task, 100 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
RTD|      1.238|      1.365|      4.778|       0|     0|      0.605|      9.414
RTD|      1.238|      1.388|      5.292|       0|     0|      0.605|      9.414
RTD|      0.847|      1.365|      6.113|       0|     0|      0.605|      9.414
RTD|      1.238|      1.363|      4.676|       0|     0|      0.605|      9.414
RTD|      1.229|      1.365|      4.489|       0|     0|      0.605|      9.414
RTD|      1.237|      1.368|      4.194|       0|     0|      0.605|      9.414
RTD|      1.231|      1.386|      5.625|       0|     0|      0.605|      9.414
RTD|      0.681|      1.365|      6.020|       0|     0|      0.605|      9.414
RTD|      1.238|      1.365|      4.762|       0|     0|      0.605|      9.414
RTD|      1.165|      1.366|      6.987|       0|     0|      0.605|      9.414
RTD|      1.237|      1.364|      5.453|       0|     0|      0.605|      9.414
RTD|      1.093|      1.382|      5.567|       0|     0|      0.605|      9.414
RTD|      0.629|      1.365|      6.437|       0|     0|      0.605|      9.414
RTD|      1.236|      1.364|      4.584|       0|     0|      0.605|      9.414
RTD|      1.237|      1.366|      6.671|       0|     0|      0.605|      9.414
RTD|      1.238|      1.372|      4.436|       0|     0|      0.605|      9.414
RTD|      0.981|      1.384|      5.949|       0|     0|      0.605|      9.414
RTD|      0.626|      1.363|      5.844|       0|     0|      0.605|      9.414
RTD|      1.217|      1.364|      4.448|       0|     0|      0.605|      9.414
RTD|      1.237|      1.365|      4.451|       0|     0|      0.605|      9.414
RTD|      1.236|      1.368|      4.619|       0|     0|      0.605|      9.414

So I did a lspci -nn | grep LPC which gives :
00:1f.0 ISA bridge [0601]: Intel Corporation 82801HEM (ICH8M) LPC
Interface Controller [8086:2815] (rev 04)

It is adviced to edit the ksrc/arch/x86/smi.c file. Is it still up to
date ? If yes could you help me to edit it ? I suppose it is this
section :
static struct pci_device_id rthal_smi_pci_tbl[] = {
        {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_0)},
        {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_0)},
        {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0)},
        {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_10)},
        {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801E_0)},
        {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_0)},
        {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12)},
        {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_0)},
        {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_12)},
        {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_0)},
        {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_0)},
        {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_1)},
        {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_2)},
        {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB2_0)},
        {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_0)},
        {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_1)},
        {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH8_4)},
        {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH9_1)},
        {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH9_5)},
        {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH10_1)},
        {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_PCH_LPC_MIN+7)},
        {0,},
};

I suppose I should add a line, with something from : pci_ids.h, but
it's not very clear to me which one to select.

