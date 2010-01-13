Message-ID: <4B4DD1BA.2020508@domain.hid>
Date: Wed, 13 Jan 2010 14:59:22 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <001101ca930a$1052fa70$30f8ef50$@kalatchev@domain.hid>	<4B4BADDD.7070900@domain.hid>	<001f01ca9390$5fa20db0$1ee62910$@kalatchev@domain.hid>	<4B4C84AC.3020207@domain.hid>	<002001ca9399$99b07c40$cd1174c0$@kalatchev@domain.hid>	<4B4C96D5.7060902@domain.hid>	<002101ca93a1$a39d4050$ead7c0f0$@kalatchev@domain.hid>	<4B4CA076.1050205@domain.hid>	<002501ca93ae$2b168850$814398f0$@kalatchev@domain.hid>	<4B4CD5E8.7040904@domain.hid>
	<004301ca93d8$4f6ca660$ee45f320$@kalatchev@domain.hid>
	<4B4CFAF1.80204@domain.hid>
	<004401ca93d9$61d05530$2570ff90$@kalatchev@domain.hid>
	<4B4D11CF.7030007@domain.hid>
	<004b01ca9458$0240e240$06c2a6c0$@kalatchev@domain.hid>
In-Reply-To: <004b01ca9458$0240e240$06c2a6c0$@kalatchev@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Viper board (ARM XScale)
	problems	with	Xenomai-2.4.10
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ivan Kalatchev <ivan.kalatchev@domain.hid>
Cc: 'Xenomai help' <xenomai@xenomai.org>

Ivan Kalatchev wrote:
> Hi Gilles,
> 
> Repeating of the first argument did solved the problem! I've built
> 2.5.0 and will start to play with it. By the way, for some reason
> patch itself didn't work - said something about malformed patch at
> line 16:
> 
> @@ -46,17 +46,17 @@ rthal_arm_nodiv_ullimd(const unsigned long long
> op,
> 
> I couldn't see what the problem was, so just updated everything
> manually.

Sorry, my fault, I pasted the patch from terminal emulator, but this
does not work, my terminal emulator converts tabs to spaces, patch wants
tabs.

-- 
					    Gilles.

