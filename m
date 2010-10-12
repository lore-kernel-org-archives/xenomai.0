From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4CB473E4.8020709@domain.hid>
References: <4CB33738.206@domain.hid>	<4CB338AB.3070803@domain.hid>
	<4CB339F9.5080202@domain.hid>	<4CB33F04.3000600@domain.hid>
	<4CB34031.5090505@domain.hid>	<4CB3424A.5090504@domain.hid>
	<4CB4299D.70600@domain.hid> <4CB43704.4020504@domain.hid>
	<4CB45B06.2070905@domain.hid> <4CB46855.4010401@domain.hid>
	<4CB473E4.8020709@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 12 Oct 2010 17:33:26 +0200
Message-ID: <1286897606.1759.8.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai and capabilities
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, 2010-10-12 at 16:42 +0200, Anders Blomdell wrote:
> On 2010-10-12 15.53, Gilles Chanteperdrix wrote:
> > Anders Blomdell wrote:
> >> CAP_DAC_OVERRIDE fixes this issue (and how safe is that :-( )
> >>
> >> How necessary are CAP_SYS_RAWIO and CAP_DAC_OVERRIDE [the two capabiltities i
> >> think have the most severe security implications] when main has started running,
> >> i.e. could I drop them after initialization and still do something useful?
> > 
> > Again: you have just found some reason why Xenomai is unsecure, it just
> > proves that it is unsecure and there are probably other reasons why it
> > is unsecure. So, here I do not concur with Jan. Security *is* a
> > black-and-white domain. Any security hole makes the system unsecure,
> > there is no gray area, no "partially secure" code.
> Hence it's essentially a black area, but plugging holes still makes sense in
> order to eventually arrive at a secure system.
> 
> > Either you are ready to make a thourough auditing of the code and plug
> > all the security holes you find, or you consider Xenomai unsecure.
> See my questions and comments as a step in this direction, but I am not and will
> never be competent enough to find all holes.
> 
> > Plugging two holes you have found and say "I stop now, this is
> > 'reasonably' secure" does not really make sense.
> I totally agree, but plugging the obvious holes is at least not a step backward
> in this respect.
> 
> CAP_DAC_OVERRIDE -> write anything anywhere in the filesystem
> CAP_SYS_RAWIO -> trash memory at will

Sloppy design triggered by x86 constraints: mainly to allow people to
call ioperm() for user-space drivers, without having to supply any
kernel code. Opening /dev/mem and friends comes next, but less common.

> 
> Does anybody know why these capabilities are required (execept for the MAYDAY page?)
> 
> Regards
> 
> Anders
> 

-- 
Philippe.



