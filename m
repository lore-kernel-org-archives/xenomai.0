Message-ID: <4CB46855.4010401@domain.hid>
Date: Tue, 12 Oct 2010 15:53:25 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4CB33738.206@domain.hid>	<4CB338AB.3070803@domain.hid>	<4CB339F9.5080202@domain.hid>	<4CB33F04.3000600@domain.hid>	<4CB34031.5090505@domain.hid>	<4CB3424A.5090504@domain.hid>	<4CB4299D.70600@domain.hid>
	<4CB43704.4020504@domain.hid> <4CB45B06.2070905@domain.hid>
In-Reply-To: <4CB45B06.2070905@domain.hid>
Content-Type: text/plain; charset=UTF-8
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

Anders Blomdell wrote:
> CAP_DAC_OVERRIDE fixes this issue (and how safe is that :-( )
> 
> How necessary are CAP_SYS_RAWIO and CAP_DAC_OVERRIDE [the two capabiltities i
> think have the most severe security implications] when main has started running,
> i.e. could I drop them after initialization and still do something useful?

Again: you have just found some reason why Xenomai is unsecure, it just
proves that it is unsecure and there are probably other reasons why it
is unsecure. So, here I do not concur with Jan. Security *is* a
black-and-white domain. Any security hole makes the system unsecure,
there is no gray area, no "partially secure" code.

Either you are ready to make a thourough auditing of the code and plug
all the security holes you find, or you consider Xenomai unsecure.
Plugging two holes you have found and say "I stop now, this is
'reasonably' secure" does not really make sense.

-- 
					    Gilles.

