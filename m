Resent-To: Xenomai help <xenomai@xenomai.org>
Resent-Message-Id: <4B855D58.6090009@domain.hid>
Message-ID: <4B8548E4.3060505@domain.hid>
Date: Wed, 24 Feb 2010 16:42:28 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20100224161747.77015rxwv9jyh5a8@domain.hid>
In-Reply-To: <20100224161747.77015rxwv9jyh5a8@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [Adeos-main] port to s3c2440  /  mini2440
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Michel He <michel.he@domain.hid>
Cc: adeos-main@gna.org

Michel He wrote:
> hello all,
> 
>     Is there anyone who managed to port Adeos I-Pipe to the arm9  
> S3C2440 of the Mini2440 board (Friendly-ARM) ?

The s3c24xx support is still in the I-pipe patch, if it was not, the
compilation of the kernel with CONFIG_IPIPE would not even work.

> 
>     The boot is blocked in the __delay function. Something maybe wrong  
> with the interrupt scheduling ...

This port has been contributed a long time ago. Since then, we use an
"optimistic testing strategy", we make sure that the port compiles, but
 we assume people really having that board are in charge of testing our
releases. Not having a board based on this chip, it would be hard for us
to test it. IOW, I have no idea whether it is supposed to work.

I suggest you assume nothing, read:
http://www.xenomai.org/index.php/I-pipe:ArmPorting

And try and debug your port. It even contains a tip for the particular
case you are mentioning.

-- 
					    Gilles.


