Message-ID: <4EAAFA3C.2080902@domain.hid>
Date: Fri, 28 Oct 2011 20:53:48 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <loom.20111028T160712-174@domain.hid>
	<4EAABB40.5050107@domain.hid> <4EAAD83D.3020503@domain.hid>
In-Reply-To: <4EAAD83D.3020503@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] twl4030-irq takes 50%cpu constantly on omap3
 gumstix overo
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: manfred@domain.hid
Cc: xenomai@xenomai.org

On 10/28/2011 06:28 PM, Manfred Quack wrote:
> I am using a modified version of the
> adeos-ipipe-2.6.33-arm-1.16-01 patch
> the modifications were made as described on this wiki:
> http://www.lara.unb.br/wiki/index.php/Overo_Xenomai
> and if I understand correctly, the modifications were necc.
> because the omap3-2.6.33 kernel differs from the
> vanilla 2.6.33 kernel.

Also note that around 1.18, latencies on omap3 were greatly improved,
going down from around 90us to 55us at 1kHz, and 35us at 10kHz.

-- 
					    Gilles.

