Message-ID: <2ff1a98a0801180716k13452c6fq4a8e20cdf0fb6629@domain.hid>
Date: Fri, 18 Jan 2008 16:16:56 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1965539821@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1965539821@domain.hid>
Subject: Re: [Xenomai-help] boot hang up cannot open dev/console
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andreas Vogt <A_C_V@web.de>
Cc: xenomai@xenomai.org

On Jan 18, 2008 4:08 PM, Andreas Vogt <A_C_V@web.de> wrote:
> Hello,
>
> I  installed Xenomai 2.4.1 with Linux Kernel 2.6.22.16 and Adeos patch  2.6.22...-1.9-03.patch. I maked an image with mkinitrd but when the system start its hang up with the message:
> cannot open dev/console
>
> Anybody an idea?
> Thanks
>
> in log there is a description of my cpu and in log2 is my config file.

Cannont open /dev/console is a kind of generic error and may have many
reasons. The ones that I can think of are:
- there is no /dev/console in the initrd
- kernel is compiled without support for console (on virtual terminal
or serial port, depending on your configuration).

You may find an answer in the full boot logs.

-- 
                                               Gilles Chanteperdrix

