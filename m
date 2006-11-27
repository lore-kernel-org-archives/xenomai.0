Message-ID: <456AD5EB.5040901@domain.hid>
Date: Mon, 27 Nov 2006 13:11:23 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Adeos support for 2.6.18 merged PowerPC
	architecture.
References: <20061124105346.e442448d.benjamin.zores@domain.hid>	<4566C5AF.7030107@domain.hid>	<20061124113009.08c0a490.benjamin.zores@domain.hid>	<4569E699.6050003@domain.hid>	<20061127092143.e633cd91.benjamin.zores@domain.hid>	<456ACA35.8030206@domain.hid>
	<20061127125419.3852edd9.benjamin.zores@domain.hid>
In-Reply-To: <20061127125419.3852edd9.benjamin.zores@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Benjamin Zores <benjamin.zores@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Benjamin Zores wrote:
> On Mon, 27 Nov 2006 12:21:25 +0100
> Wolfgang Grandegger <wg@domain.hid> wrote:
> 
>>> Well, I hack a bit my patch to make it compile and the kernel already booted.
>>> Though it hangs when loading the SATA driver.
>>> I have no idea why atm.
>> Problems with IRQs?
> 
> Probably, as when unplugging the SATA drive, the boot goes further
> but then hang at USB detection (both are handlign IRQs a lot i guess).
> Would be interesting if someone could test on other board than just mine.

As I pointed out in my previous mail, the IRQ handling is not yet 
correct for powerpc. Try to correct his first.

Wolfgang.

