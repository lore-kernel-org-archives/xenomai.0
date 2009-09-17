Message-ID: <4AB22A6C.5030801@domain.hid>
Date: Thu, 17 Sep 2009 14:24:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4303dd240909110600tf787b85td93b46086953a0d9@domain.hid>	<4AAA4AE9.5070101@domain.hid>
	<4303dd240909160555l5f53839g6bf917a17370bb09@domain.hid>
In-Reply-To: <4303dd240909160555l5f53839g6bf917a17370bb09@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problems with instalation of xenomai in ubuntu
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Flavio de Castro Alves Filho <flavio.alves@domain.hid>
Cc: xenomai@xenomai.org

Flavio de Castro Alves Filho wrote:
> Hello,
> Sorry for the delay in the response.
> 
> In fact, I believe it is not really a kernel panic, 

And you believe wrong. The keyboard leds blinking are the sign of a
kernel panic. Without any doubt.

because the login
> message appears at the screen just before the screen is cleared (and the
> computer is blocked). Sometimes I can see the mouse pointer for X, but the
> computer is also blocked.
> 
> The boot behavior is something like this:
> 
> - normal boot, which the messages on the screen (I suppose the messages are
> correct)
> - login message (terminal mode)
> - switch to X mode
> - system block
> 
> Build information:
> - Linux kernel 2.6.30
> - Xenomai version 2.4.9.1 (I have tried also with xenomai 2.4.9 and I had
> similar results)
> - GCC version 4.3.2
> - Ubuntu 8.10
> 
> Which information can I send to you in order to be more specific?

I already answered this question: send us the console output up to the
panic. Using serial console or network console and a second computer.

-- 
					    Gilles.

