Message-ID: <48984179.20208@domain.hid>
Date: Tue, 05 Aug 2008 14:03:05 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20080804144936.45B241C066@domain.hid>
	<2b490f270808050422r2997ded4ta2ee4de6206bb0e5@domain.hid>
In-Reply-To: <2b490f270808050422r2997ded4ta2ee4de6206bb0e5@domain.hid>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai version 2.4.4 with linux
 kernel	2.6.25.11 under ubuntu problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dehann Fourie <dehann.fourie@domain.hid>
Cc: xenomai@xenomai.org

Dehann Fourie wrote:
> HI,
> 
> Im not the expert but I had the same problem under xubuntu 7.10. I tried
> mkinitrd, but this command doesn't come standard with Ubuntu. I resorted to
> Debian and installed under an unencrypted fs. I think that the fs encryption
> could be ur problem.

mkinitrd is and old package, replaced with mkinitramfs. There is no
reason fs encryption could be a problem with Xenomai, and if it is, then
it is a bug and needs fixing.

-- 
                                                 Gilles.

