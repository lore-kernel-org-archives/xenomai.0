Message-ID: <2ff1a98a0803180326h4ef2c65o1f46342751838394@domain.hid>
Date: Tue, 18 Mar 2008 11:26:35 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <bd3df7a40803180236n4e35f6a3m29cd77bda6f3927e@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bd3df7a40803180236n4e35f6a3m29cd77bda6f3927e@domain.hid>
Subject: Re: [Xenomai-help] ARM9 and xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Arnaud Riess <arnaud.riess@domain.hid>
Cc: xenomai@xenomai.org

On Tue, Mar 18, 2008 at 10:36 AM, Arnaud Riess <arnaud.riess@domain.hid> wrote:
> Hello,
>
> I'm currently using an ARM9 core from freescale (i.MX27) on a Phycore-i.MX27
> board
> (http://www.phytec.com/products/sbc/ARM-XScale/phyCORE-ARM9-i.MX27.html)
> under linux. I need hard real-time response time and I wonder if I can
> install xenomai on my board. Does anybody have info about that?

That is an FAQ/

Xenomai is not currently ported on IMX27. But IMX21 was ported on old
versions of the I-pipe (on top of Linux 2.6.14). So, to port it, take
whatever version of Linux you are using (either vanilla, or Freescale
BSP), apply whatever I-pipe patch is relevant (actually, you do not
have much choice, it will be I-pipe for Linux 2.6.20 or I-pipe for
Linux 2.6.24), then read the wiki page about porting I-pipe on ARM
[1], and try to follow this guide, adapting the patch for IMX21 if at
all possible. The guide is not yet up to date for 2.6.24, but will be
updated shortly.

[1] http://www.xenomai.org/index.php/I-pipe:ArmPorting

-- 
 Gilles Chanteperdrix

