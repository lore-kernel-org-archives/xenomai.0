Message-ID: <2ff1a98a0805230748g1e20a40dybc6f30bc6157e5f4@domain.hid>
Date: Fri, 23 May 2008 16:48:53 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <30723461.6495621211553763904.JavaMail.www@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <30723461.6495621211553763904.JavaMail.www@domain.hid>
Subject: Re: [Xenomai-help] I2C Bus and intel PXA255 (or other board)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "kerhoas.vincent" <kerhoas.vincent@domain.hid>
Cc: xenomai@xenomai.org

On Fri, May 23, 2008 at 4:42 PM, kerhoas.vincent
<kerhoas.vincent@domain.hid> wrote:
>
> Hi
>
> I'm working on a ep9302 board and I'm trying to install xenomai on it. For
> the moment there isn't a dedicated patch, so I've got to do it by hand. I
> continue doing it but I'm thinking about another solution.

As I already told you in the following mail:
https://mail.gna.org/public/xenomai-help/2008-05/msg00018.html
A patch already exists for ep9302, though it is not part of the I-pipe patch.

>
> My purpose is creating real time robotic labs ; I was considering (and I'm
> still considering) a qwerk solution (from charmed lab), but in the worst
> case I'm now considering korebot solution (from k-team). This robot use
> Intel PXA255 board, which seems to be ok for xenomai, but this board need
> I2C to communicate with other board.
>
> So I'm wondering If there is I2C driver to rewrite for xenomai or there is
> just special functions to use after patching the kernel ?

No, you will have to rewrite a driver for Xenomai.

-- 
 Gilles

