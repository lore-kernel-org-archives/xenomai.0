Message-ID: <2ff1a98a0805160542w44be76cbqc18668efa2c365d6@domain.hid>
Date: Fri, 16 May 2008 14:42:51 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1165867616@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1165867616@domain.hid>
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

On Fri, May 16, 2008 at 2:40 PM,  <Paradoxxa2001@domain.hid> wrote:
> The manual of my starterkit says i should do this with the vmlinux:
>
> arm-elf-objcopy -O binary -S vmImage vmlinux.bin

This step is the same as the one made by the Linux kernel Makefile.
So, of course, if you do not use the Linux kernel Makefiles, you
should use the same flags as the ones it uses.

-- 
 Gilles

