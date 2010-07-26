Message-ID: <4C4D97AC.2030609@domain.hid>
Date: Mon, 26 Jul 2010 16:11:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1279046702.31665.65.camel@domain.hid>
	<4C3CB655.1020801@domain.hid>	<1279048661.31665.81.camel@domain.hid>
	<1280149567.1856.15.camel@domain.hid>	<4C4D9131.7080504@domain.hid>
	<1280153187.1856.25.camel@domain.hid>
In-Reply-To: <1280153187.1856.25.camel@domain.hid>
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
To: flavio.alves@domain.hid
Cc: xenomai@xenomai.org

Flavio Alves wrote:
> I'm sorry for this question, but shoud I execute:
> 
> git clone http://opensource.freescale.com/pub/scm/imx/linux-2.6-imx.git
> 
> When I perform this instruction, the terminal blocks. I can access this
> link using the browser. (As you can see, I am not very good git user).
> 
> Thank you for your help.

git over http is very slow... Using denx git may be better after all. We
just have to understand why the patch does not apply.

-- 
					    Gilles.

