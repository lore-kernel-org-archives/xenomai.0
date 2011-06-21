Message-ID: <4E007468.3040905@domain.hid>
Date: Tue, 21 Jun 2011 12:37:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4DF9CA75.1040903@domain.hid>	<4DF9DCE3.70703@domain.hid>		<BANLkTinki=NqJ1f1vyGNBMHLZuwiCtrmMw@domain.hid>		<4DFBA463.3090902@domain.hid>	<4DFBAEB9.8060106@domain.hid>		<4DFBB08B.5020005@domain.hid>	<4DFCC18F.3060207@domain.hid>		<BANLkTin00xA-LMikumq1C4_nFyFbCdgi+Q@mail.gmail.com>		<4DFF610F.5070602@domain.hid>	<4DFF664C.5030504@domain.hid>	<1308586589.2119.10.camel@domain.hid>	<4DFF84C0.6010008@domain.hid>	<4DFFBBDB.4030703@domain.hid>	<4DFFCFBC.6080703@domain.hid>	<4E004038.2010704@domain.hid>	<4E0053F1.2020206@domain.hid>
	<4E005881.7090407@domain.hid>
In-Reply-To: <4E005881.7090407@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai beagleboard xm ethernet  working!
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: David Wiebe <dwiebe2@domain.hid>
Cc: xenomai@xenomai.org

On 06/21/2011 10:38 AM, David Wiebe wrote:
> Hello,
> 
> In menuconfig, unselect realtime clock. lol! Boots fine, ethernet 
> support works! I also patched the kernel to support spi which works in 
> userland.
> 
> Now to make it all work as a rtos. If anyone has suggestions or 
> whatever, I need to work on a spi to ethernet bridge. I need to read 
> 360bytes every 1mS and send it out over ethernet. I've done this with a 
> non-rtos and achieved 360byte read and send every ~740uS. The problem 
> was sometimes it would vary between  700 and 900uS etc. I need this to 
> be isochronous and 1mS will work fine.
> 
> There you have it!
> Cheers!

If you want deterministic access to ethernet, you will need RTnet.
http://rtnet.org/

-- 
                                                                Gilles.

