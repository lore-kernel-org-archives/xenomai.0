Message-ID: <465D43B4.6040901@domain.hid>
Date: Wed, 30 May 2007 11:28:20 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB0F3@domain.hid><1180360288.4727.50.camel@domain.hid><7289437c0705290130k627df2f9j2940c509311c75c5@domain.hid><465BE777.7010204@domain.hid><7289437c0705290347y20eeff5bq3e86cd0cd4984ddb@domain.hid><465C6268.1090704@domain.hid><18012.28254.882249.144005@domain.hid><7289437c0705292257u57e991a1l270d478fdf7f757d@domain.hid><7289437c0705300051i2634264avc5f2db1fcdb91da8@domain.hid><465D304D.6020606@domain.hid>	<7289437c0705300210n6c54b750sab11a005107e21b0@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01F54D06@domain.hid>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB01F54D06@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] =?iso-8859-1?q?Xenomai_with_=B5Clibc?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

Daniel Schnell wrote:
> Hi,
> 
> We had similar problems once. Try putting
> 
> -Wl,--start-group
> 
> before the first occurrence of any external library.

No, this is the wrong thing to do, since it makes Linux libraries use
Xenomai symbols.

-- 
                                                 Gilles Chanteperdrix

