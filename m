Message-ID: <4CC0967B.4070106@domain.hid>
Date: Thu, 21 Oct 2010 21:37:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1287655084.19729856@domain.hid>
In-Reply-To: <1287655084.19729856@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai and MEN IO Cards/MDIS drivers
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: edward.robbins@domain.hid
Cc: xenomai@xenomai.org

edward.robbins@domain.hid wrote:
> Hi again,
> 
> I've almost finished setting up xenomai on my machine. I get very
> little time to work on this project, so wont get back to it until
> Saturday, but the next stage for me is getting the IO cards to work,
> and I thought I'd throw out an email as a precursor.
> 
> In this system we have a MEN M32 digital input card and an M28
> digital output card. These come with Linux drivers, but they have to
> run through MEN's cross-platform driver API/framework, MDIS5.
> Previous versions of MDIS supported Xenomai and RTAI explicitly, but
> they seem to have dropped that support in the latest version, and I
> doubt the previous version will 'just work' with newer kernels. I
> have managed to successfully build the standard Linux MDIS drivers
> already.
> 
> MDIS adds so many layers of obfuscation and abstraction that on a
> previous occasion when I was attempting to get some M62 analogue
> output cards to work on a VMEbus VXworks platform I gave up on MDIS
> and wrote a new driver from scratch.
> 
> Since Linux drivers are more complex to start with, and then there is
> Xenomai as well, and time is tight, I'd rather not do that for these
> cards.
> 
> Does anyone have experience of using MEN drivers/IO cards in Xenomai?
> Can I simply wrap the MDIS API with the Xenomai API (described here
> http://www.xenomai.org/documentation/xenomai-2.5/html/api/index.html)
> once I've crawled my way through their code? Is there an easier way?

The driver should use the RTDM API. The porting involves using the API,
but also removing any piece of code which could have an effect on
determinism. So, you really have to read and understand the part of the
driver which will be used by real-time processes.

> 
> Also, I presume that as a temporary fall-back I can use the standard,
> non-RT drivers from Xenomai user-land processes?

You can do that of course.

-- 
                                                                Gilles.

