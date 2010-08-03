Message-ID: <4C585D60.2040809@domain.hid>
Date: Tue, 03 Aug 2010 20:18:08 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1279046702.31665.65.camel@domain.hid>	<4C3CB655.1020801@domain.hid>	<1279048661.31665.81.camel@domain.hid>	<1280149567.1856.15.camel@domain.hid>	<4C4D9131.7080504@domain.hid>	<1280153187.1856.25.camel@domain.hid>	<4C4D97AC.2030609@domain.hid>	<1280154697.1856.29.camel@domain.hid>	<4C4D9E04.6060407@domain.hid>	<1280156219.1856.32.camel@domain.hid>	<4C4DA340.4030400@domain.hid>	<1280187666.1963.34.camel@domain.hid>	<4C4E8A64.1000701@domain.hid>	<1280239972.1865.7.camel@domain.hid>	<4C4EEBE3.9020806@domain.hid>	<AANLkTim4A+3sLGzgdhc_Xhfn0bAW+hLZtuUJVyVocLOZ@mail.gmail.com>	<AANLkTimGA5k4Vu_aQNXx1bBhT2X3KAZytAKZHWD-HNHK@mail.gmail.com>	<4C4F7B47.6040709@domain.hid>
	<AANLkTin-4N_AdZiEK+dqxsz=E_ZHxDnoGxQikOJCkVo9@domain.hid>
In-Reply-To: <AANLkTin-4N_AdZiEK+dqxsz=E_ZHxDnoGxQikOJCkVo9@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Kernel compilation procedures for imx51
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Leandro Favarin <leandro.favarin@domain.hid>
Cc: xenomai@xenomai.org

Leandro Favarin wrote:
> Hello,
> 
> I have successfully cross-compiled the linux-2.6-imx.git with
> Xenomai's patches (adeos-ipipe-2.6.31-arm-1.16-01.patch and
> adeos-ipipe-2.6.31-arm-1.15-01-imx51.patch, in this sequence) for
> iMX51EVK. Does this kernel works with this board?

It has been tested on the Babbage board, but there should be no
dependence on board code, except if the board has some custom
multiplexed GPIOs not handled by the MXC generic code. So, the answer
is: we do not know.

Note that some new versions of the patches have just been released in
Xenomai 2.5.4, which include some ironing of the GPIOs, necessary if you
intend to use the GPIOs concurrently in several drivers.

-- 
					    Gilles.

