From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <23736732.1178175965905.JavaMail.ngmail@domain.hid>
References: <1178117237.5111.123.camel@domain.hid>
	<26575694.1178110645829.JavaMail.ngmail@domain.hid>
	<23736732.1178175965905.JavaMail.ngmail@domain.hid>
Content-Type: text/plain
Date: Thu, 03 May 2007 10:29:26 +0200
Message-Id: <1178180966.29605.0.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and MSI enabled crashes kernel
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

On Thu, 2007-05-03 at 09:06 +0200, M. Koehrer wrote:
> Hi Philippe,
> 
> I have restored the original kernel configuration and I got the crash again.
> As it happens during the boot, it is reproducible.
> Enclosed is the console log (including the oops), the relevant disassemble part,
> the output of "nm vmlinux" and my kernel config.
> If you like I can mail you privately the vmlinux aswell.
> What I see from the disassembler listing
> c010f10b:       e8 5e ae 02 00          call   c0139f6e <__ipipe_walk_pipeline>
> c010f110:       ff 15 68 70 3d c0       call   *0xc03d7068
> is that ipipe_walk_pipeline is called followed by a indirect call to 0xc03d7068.
> I looked at `nm vmlinux` and found out that 0xc03d7068 is __ipipe_logical_cpuid.
> 
> I hope that helps to get closer to this bug...
> 

Should be ok, thanks. I will have a close look at this.

-- 
Philippe.



