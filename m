Message-ID: <2ff1a98a0805160701r7abb278ek5d8c2096f4536c72@domain.hid>
Date: Fri, 16 May 2008 16:01:22 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1165975808@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1165975808@domain.hid>
Subject: Re: [Xenomai-help] at91sam9263 and user-space support compile fails
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Paradoxxa2001@domain.hid
Cc: xenomai@xenomai.org

On Fri, May 16, 2008 at 3:53 PM,  <Paradoxxa2001@domain.hid> wrote:
> Finally i got it. Thanks a lot.
> I flashed this Image to the target and booted it.
> After the Message "Starting kernel" it seems like the system hung up.
> Nothing more happens.
>
> ----------------------------------------------------------------
> LCD init done, video memory at 0x70000000
> In:    serial
> Out:   serial
> Err:   serial
> AT91 Ethernet PHY: DP83848 (1)
> operating at 100M full duplex mode
> End of Autonegociation
> MAC: 02:00:11:53:d0:85
> Hit any key to stop autoboot:  0
> ## Booting image at 10050000 ...
>   Image Name:   Xenomai Linux Kernel
>   Image Type:   ARM Linux Kernel Image (gzip compressed)
>   Data Size:    1682870 Bytes =  1.6 MB
>   Load Address: 20008000
>   Entry Point:  20008000
>   Verifying Checksum ... OK
>   Uncompressing Kernel Image ... OK
>
> Starting kernel ...

By the way, if your boot loader is uboot, the Linux kernel makefiles
have a uImage target which produces an image which u-boot can use.


-- 
 Gilles

