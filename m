Message-ID: <4C04EDAF.1080800@domain.hid>
Date: Tue, 01 Jun 2010 13:23:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4C04E8D8.8030101@domain.hid>
In-Reply-To: <4C04E8D8.8030101@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Linux kernel 2.6.32.14 and Xenomai 2.5.2 does
	not boot
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniele Nicolodi <daniele@domain.hid>
Cc: xenomai@xenomai.org

Daniele Nicolodi wrote:
> Hello.
> 
> In the process of upgrading my data acquisition system from Xenomai
> 2.5.0 to Xenomai 2.5.2, I also upgraded the kernel from the 2.6.30
> release to 2.6.32.14.

Latest Xenomai is 2.5.3, latest 2.6.32 patch is
adeos-ipipe-2.6.32.13-x86-2.6-04.patch [1]. Make sure you have both.

> 
> However the new kernel, compiled with the same options as the old one,
> does not boot on my hardware, a x86 PC with a Celeron CPU. After the
> boot loader I'm left with a black screen.
> 
> I have noticed that going from the 2.6.30 to the 2.6.32 kernel the Adeos
> Ipipe patch goes from version 2.4 to 2.6. Can this be related to my problem?
> 
> How can I investigate, and eventually solve, this problem?
> 
> Thanks. Cheers,

Jan

[1]http://download.gna.org/adeos/patches/v2.6/x86/adeos-ipipe-2.6.32.13-x86-2.6-04.patch

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

