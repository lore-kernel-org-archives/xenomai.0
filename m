Message-ID: <4A7AF4C4.30001@domain.hid>
Date: Thu, 06 Aug 2009 17:20:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4A72BFBA.8040209@domain.hid>
In-Reply-To: <4A72BFBA.8040209@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] high latencies with Intel P45 ICH10
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Theo Veenker <T.J.G.Veenker@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Theo Veenker wrote:
> Hi,
> 
> I'm replacing a number of old machines in our lab by new ones with an
> MSI P45 Neo3 mobo. On the new hardware I'm seeing high latencies with
> Xenomai 2.4.8 on kernel 2.6.29.5. The latency thingy reports many
> overruns:
> RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
> RTD|       4.083|       9.100|       9.807|       0|       4.083|       9.807
> RTD|       4.137|       9.280|    1804.493|      18|       4.083|    1804.493
> RTD|       3.451|       9.099|      14.337|      18|       3.451|    1804.493
> RTD|       3.864|       9.281|    1820.762|      36|       3.451|    1820.762
> RTD|       4.017|       9.102|       9.917|      36|       3.451|    1820.762
> RTD|       4.121|       9.273|    1742.710|      53|       3.451|    1820.762
> 
> I've tried UP/SMP both with and without disabling SMI. No CONFIG_ACPI_PROCESSOR
> etc. PCI_MSI is disabled too. I do not see the "Xenomai: SMI-enabled chipset
> found..." message in the messages log file. Is that correct or is this hardware
> too new for this version of Xenomai?

Probably, the table of supported PCI ids is in arch/x86/smi.c

-- 
                                          Gilles


