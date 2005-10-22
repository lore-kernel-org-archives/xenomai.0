From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] [Fwd: Re: [Xenomai-help] timeout in native API
	calls (cond, sem, =?iso-8859-15?q?=09mutex?=, etc).]
Date: Sat, 22 Oct 2005 15:51:23 +0200
References: <435926CE.1090201@domain.hid>
In-Reply-To: <435926CE.1090201@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510221551.25114.dmitry.adamushko@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

On Friday 21 October 2005 19:35, Philippe Gerum wrote:
>
> Actually, there is a more general problem with the current coding style
> used throughout the code base: it's mine, it's not that standard,

then what's standard in this case?

> and now 
> thatmore people are contributing to it, I'm pondering whether we should
> just adoptthe conventional kernel coding style, without the ludicrous
> 8-space tabs, that is.

The "kernel coding style" is just yet another codding style. If more people 
are contributing to the project, then it should be a standard that satisfies 
the most part of them. Is it necessarily the linux way?
As I told you once, the important thing is how easily the code may be read, 
hence, understood. IMHO, how/where the braces, etc. are placed is not the 
matter of the first instance.
The use of any codding style doesn't result in neat and well-readable code 
automagically.

Nevertheless, if the ideas are as follows:

1) linux codding style as a part of the seamless integration with the linux 
kernel. err.., what about a possibility to be merged with the mainline 
kernel? ok, sounds almost impossible :) ;

2) linux people are reading/will read the code, there are a lot of 
style-adherents amongst them, so let's keep them satisfied and our mail boxes 
free of the messages like "first change your codding style before submitting 
anything" (btw, I remember one of the answers after publishing of first 
i-pipe patch was of that kind). btw, there are some parts of the kernel (e.g. 
some filesystems, if I'm not wrong) that use another style;

3) ok, I may assume, that if a person is familiar with some codding style, 
he/she gets a few percent speed-up when reading the code that is of the same 
style. At least, for the first few minutes :) But here we must assume that 
the most part of the potential readers/contributors like the linux codding 
way.

err.. to sum it up, I like the current codding style, but if 1-3) + smth else 
are worthy things, then why not. I'll get used to another style, if the code 
will remain err. well-readable :)

>
> --

>
> Philippe.
>

---
Best regards,
Dmitry

