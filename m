Message-ID: <4614C64E.6070905@domain.hid>
Date: Thu, 05 Apr 2007 11:50:06 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] large latencies on a Dell D620 dual core laptop
References: <20070403143122.4ac4ffaf@domain.hid>	<46124C61.3070107@domain.hid>	<20070403162752.2d4a1ae6@domain.hid>	<46126603.1050007@domain.hid>	<20070403170416.6c3f7ded@domain.hid>	<46126DC3.8070905@domain.hid>	<20070403171828.2da9c6fa@domain.hid>	<46127166.9040503@domain.hid>	<20070403175535.7340cc06@domain.hid>	<46127DD8.8060502@domain.hid>	<20070404181558.0ba333da@domain.hid>	<4613D7CC.2040703@domain.hid>	<20070405092815.15bd1af1@domain.hid>	<20070405101200.10084177@domain.hid>	<4614BA29.3010609@domain.hid>
	<20070405113420.0d2cc0ae@domain.hid>
In-Reply-To: <20070405113420.0d2cc0ae@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Simon <Daniel.Simon@domain.hid>
Cc: xenomai@xenomai.org

Daniel Simon wrote:
> On Thu, 05 Apr 2007 10:58:17 +0200
> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> 
> 
>>Does it still run correctly if there is some traffic on the network ?
>>You could try to ping flood the box for instance ?
> 
> 
> in runlevel 2, loading big files from a remote PC, the average latencies remain
> about 5us with occasionnal 20us peaks, as with no eth traffic
> 
> 
>>What does "date" and /proc/interrupt say ? Is the system timer still
>>ticking ?
> 
> 
> in runlevel3: date seems to normally increase time during the latency test.
> 
> after modprobing xeno_native  /proc/interrupts looks like that (twice the test,
> twice freezing the PC just after accessing this file...)
> 
>            CPU0       CPU1       
>   0:     220691          0   IO-APIC-edge      timer, rthal_broadcast_timer
>   1:          8          0   IO-APIC-edge      i8042
>   7:          0          0   IO-APIC-edge      parport0
>   8:          1          0   IO-APIC-edge      rtc
>   9:          3          0   IO-APIC-fasteoi   acpi
>  12:        115          0   IO-APIC-edge      i8042
>  14:       7726          0   IO-APIC-edge      libata
>  15:       2079          0   IO-APIC-edge      libata
>  18:       1105          0   IO-APIC-fasteoi   yenta, eth0
>  19:        428          0   IO-APIC-fasteoi   uhci_hcd:usb1, ehci_hcd:usb5
>  20:        172          0   IO-APIC-fasteoi   uhci_hcd:usb2, HDA Intel
>  21:          0          0   IO-APIC-fasteoi   uhci_hcd:usb3
>  22:          0          0   IO-APIC-fasteoi   uhci_hcd:usb4
> NMI:          0          0 
> LOC:     220571     220570 
> ERR:          0
> MIS:          0

It is funny that you get no interrupt on CPU1, but I have exactly the
same behaviour on my box, and even without I-pipe enabled.

I do not see a network card.

> 
> 
>>Could you send us your .config ?
> 
> in attachement

I see nothing suspicious.

-- 
                                                 Gilles Chanteperdrix

