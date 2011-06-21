Message-ID: <4E004038.2010704@domain.hid>
Date: Tue, 21 Jun 2011 08:54:48 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4DF9CA75.1040903@domain.hid>	<4DF9DCE3.70703@domain.hid>		<BANLkTinki=NqJ1f1vyGNBMHLZuwiCtrmMw@domain.hid>		<4DFBA463.3090902@domain.hid>	<4DFBAEB9.8060106@domain.hid>		<4DFBB08B.5020005@domain.hid>	<4DFCC18F.3060207@domain.hid>		<BANLkTin00xA-LMikumq1C4_nFyFbCdgi+Q@mail.gmail.com>		<4DFF610F.5070602@domain.hid>	<4DFF664C.5030504@domain.hid>	<1308586589.2119.10.camel@domain.hid>	<4DFF84C0.6010008@domain.hid>
	<4DFFBBDB.4030703@domain.hid> <4DFFCFBC.6080703@domain.hid>
In-Reply-To: <4DFFCFBC.6080703@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai beagleboard xm ethernet not working
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

On 06/21/2011 12:54 AM, David Wiebe wrote:
> Hello,
> 
> I haven't been able to get the ethernet to work with linux 2.6.35.9 
> patched with Xenomai. I've been in menuconfig turning on anything and 
> everything related to networking and usb and still nothing.

If you disable CONFIG_XENOMAI and CONFIG_IPIPE in the kernel
configuration, does ethernet work?

-- 
                                                                Gilles.

