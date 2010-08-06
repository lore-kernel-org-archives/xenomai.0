Message-ID: <4C5C2BBC.7000502@domain.hid>
Date: Fri, 06 Aug 2010 17:35:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTimPXWv2octL1y5Hy+rW1yOwEwxo3fY8g_cNrY9v@domain.hid>
In-Reply-To: <AANLkTimPXWv2octL1y5Hy+rW1yOwEwxo3fY8g_cNrY9v@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problems with the installation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ana Carolina Cardoso de Sousa <anacsousa1@domain.hid>
Cc: xenomai@xenomai.org

Ana Carolina Cardoso de Sousa wrote:
> I tried to install using the following steps:
> http://www.lara.unb.br/wiki/index.php/Ubuntu_Real-time_Xenomai
> 
> I did the same thing in two others pcs and everything works fine, but in
> this one I can't boot my kernel with xenomai.
> 
> I received this message:/
> mout: mount /dev/disk/by_uuid/25fd1958-(...)-c4277c07a785 on root
> failed: Invalid argument
> mount: mounting /dev on /root/dev failed: No such file or directory/
> 
> Before that I received yet another message saying something about the
> temperature in the CPU.
> 
> I don't really understand much about xenomai and I'm really lost about
> what to do now.
> I could use some help.

We provide instructions to install Xenomai on Debian (Ubuntu is based on
Debian) here:
http://www.xenomai.org/index.php/Building_Debian_packages

If you want to know a bit more about Xenomai, you are advised to read
the documents at this address:
http://www.xenomai.org/index.php/Included_documentation_summary

If you intend to send a bug report, we need the full kernel log, from
the bootloader startup to the bug itself.

-- 
					    Gilles.

