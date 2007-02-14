Message-ID: <45D2DD6E.5030800@domain.hid>
Date: Wed, 14 Feb 2007 10:59:10 +0100
From: Markus Franke <Markus.Franke@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] CONFIG_PREEMPT & irqbench
References: <45D25145.3000407@domain.hid>
	<45D2CE27.5040303@domain.hid>
In-Reply-To: <45D2CE27.5040303@domain.hid>
Content-Type: multipart/mixed; boundary="------------070208000803020907070802"
Reply-To: Markus.Franke@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-help@domain.hid

This is a multi-part message in MIME format.
--------------070208000803020907070802
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> Markus Franke wrote:
>>I am running some latency tests with irqbench/irqloop. I am wondering
>>whether it would be possible to achieve better results when activating
>>CONFIG_PREEMPT and CONFIG_PREEMPT_VOLUNTARILY during the kernel
>>configuration and running irqloop in User Mode over this kernel?
> 
> 
> Nope.
> 
> 
>>Does it make any sense?
> 
> 
> Nope. :)
> The Linux kernel is already fully preemptible by Xenomai once you
> applied the I-pipe patch. Therefore, you are free to pick the Linux
> preemption strategy according to your *Linux* load, independent of what
> the real-time part needs.

Well, "Native-API-Tour.pdf" states that everytime a mode switch from
Primary Domain to Secondary Domain is made (e.g. Linux system call like
ioctl()), Xenomai can ease from the
"continuous trend of improvements of Linux 2.6 regarding
preemptability". So CONFIG_PREEMPT should have an impact on measurements
with Xenomai, maybe not with irqbench/irqloop. The problem here is that
we don't have a mode switch, right? When running irqloop as User-Task it
simply runs in Secondary Mode, right?

> Do you have CONFIG_DEBUG_PREEMPT set as well then? This option still as
> a small but measurable impact on Xenomai due to micro-dependencies that
> as scheduled to be removed in the near future.

I cannot see anything like

CONFIG_DEBUG_PREEMPT=y
or
#CONFIG_DEBUG_PREEMPT is not set

in my config-file. The parameter simply doesn't exist.

Markus

--------------070208000803020907070802
Content-Type: text/x-vcard; charset=utf-8;
 name="Markus.Franke.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="Markus.Franke.vcf"

begin:vcard
fn:Markus Franke
n:Franke;Markus
adr;quoted-printable:;;Vettersstra=C3=9Fe 64/722;Chemnitz;Saxony;09126;Germany
email;internet:Markus.Franke@domain.hid
x-mozilla-html:FALSE
url:http://www.tu-chemnitz.de/~franm
version:2.1
end:vcard


--------------070208000803020907070802--

