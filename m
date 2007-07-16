Message-ID: <2ff1a98a0707160225x7fa9f94fn70fe0de98d9c6055@domain.hid>
Date: Mon, 16 Jul 2007 11:25:17 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <2862c2c80707160150s1db21911y5cd7111a88213881@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2862c2c80707130245j3f9b09b3i2b461c4e1521c53d@domain.hid>
	<2862c2c80707152040v1cc27cb2kc33f1cbf21932cba@domain.hid>
	<18075.3438.734938.482223@domain.hid>
	<2862c2c80707160043w581aa4c5i20c2c7de1e0e2412@domain.hid>
	<2ff1a98a0707160128h37312a6and595d0b9a92312c1@domain.hid>
	<2862c2c80707160150s1db21911y5cd7111a88213881@domain.hid>
Subject: Re: [Xenomai-help] Enable I-PIPE - kernel boot hangs in the
	AT91RM9200
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Yeoh Chun Yeow <yeohchunyeow@domain.hid>
Cc: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

On 7/16/07, Yeoh Chun Yeow <yeohchunyeow@domain.hid> wrote:
>  On 7/16/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> > Thanks for the .config, could you also send us the full logs ?
>
> Dear Gilles,
>
> Here the full log messages:
> (...)
>
> Kernel command line: console=ttyS0,115200 root=/dev/nfs
> nfsroot=172.16.6.174:/home/yeow/kwikbyte/KB9202B/target_fs
> (...)
> IP-Config: Guessing netmask 255.255.0.0
> IP-Config: Complete:
>       device=eth0, addr=172.16.6.203, mask=255.255.0.0 , gw=255.255.255.255,
>      host=172.16.6.203, domain=, nis-domain=(none),
>      bootserver=255.255.255.255 , rootserver=172.16.6.174, rootpath=
> (...)
> Any ideas? What's going wrong?

This looks suspicious: you specifed nfsroot to be
/home/yeow/kwikbyte/KB9202B/target_fs and it seems that Linux does
not take it into account. On the server side did you export your whole
filesystem or only this directory ? If you exported your whole filesystem,
maybe linux is trying to execute your host /sbin/init and fails.

You also selected floating-point emulation, whereas I do not. I do not use
floating point emulation, it is very inefficient, instead, I compile
user-space applications with -msoft-float. I will try to enable it in
order to see if I get
the same behaviour as you.

-- 
                                               Gilles Chanteperdrix

