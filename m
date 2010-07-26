From: Flavio Alves <flavio.alves@domain.hid>
In-Reply-To: <4C4D97AC.2030609@domain.hid>
References: <1279046702.31665.65.camel@domain.hid> <4C3CB655.1020801@domain.hid>
	<1279048661.31665.81.camel@domain.hid> <1280149567.1856.15.camel@domain.hid>
	<4C4D9131.7080504@domain.hid> <1280153187.1856.25.camel@domain.hid>
	<4C4D97AC.2030609@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 26 Jul 2010 11:31:37 -0300
Message-ID: <1280154697.1856.29.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Kernel compilation procedures for imx51
Reply-To: flavio.alves@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Indeed ... Very slow ... and no download indication ... but it is
coming.

Now I am checking the contents of the xenomai-2.5.3 package. The readme
indicates the use of the "adeos-ipipe-2.6.31-arm-1.15-02.patch" file.
But, looking at the files inside the ksrc/arch/arm/patches directory, I
have the following list:

adeos-ipipe-2.6.30-arm-1.15-02.patch
adeos-ipipe-2.6.33-arm-1.16-01.patch
adeos-ipipe-2.6.31-arm-1.15-01.patch
adeos-ipipe-2.6.31-arm-1.16-01.patch
README

Which option should I use? Or do I have to download the patch from
another place?

Best regards,

Flavio

On Mon, 2010-07-26 at 16:11 +0200, Gilles Chanteperdrix wrote:
> Flavio Alves wrote:
> > I'm sorry for this question, but shoud I execute:
> > 
> > git clone http://opensource.freescale.com/pub/scm/imx/linux-2.6-imx.git
> > 
> > When I perform this instruction, the terminal blocks. I can access this
> > link using the browser. (As you can see, I am not very good git user).
> > 
> > Thank you for your help.
> 
> git over http is very slow... Using denx git may be better after all. We
> just have to understand why the patch does not apply.
> 



