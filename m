Message-ID: <4FE43065.5060801@xenomai.org>
Date: Fri, 22 Jun 2012 10:44:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAHyVJyz4B9Z1nCLEg3G9u-r5d5iHdGwiA78w_enRc--MuVrgMQ@mail.gmail.com>	<4FE41B17.7030604@xenomai.org>
	<CAHyVJywmT80V8WK=2ERmqfj+OXdjLjv4Hatu+8sonvZn0KJ+mA@mail.gmail.com>
In-Reply-To: <CAHyVJywmT80V8WK=2ERmqfj+OXdjLjv4Hatu+8sonvZn0KJ+mA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai RT user application- POSIX interface
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mohit Jandwani <mohitjandwani@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On 06/22/2012 09:33 AM, Mohit Jandwani wrote:
> I am not able to install the rtnet because of the posix skin, I saw one of
> your posts on which you looked at the problem and in the end some person
> named jan gave a patch
> 
> http://www.mail-archive.com/rtnet-users@lists.sourceforge.net/msg02981.html

I do not see any relation in this message with xenomai posix skin.

> 
> but it is not working.Anyways I need a simple solution as I will have to
> reproduce this on my exynos board.I am using the makefile they gave for
> compiling the examples.It works fine in native skin.I have already tested a
> few simple example codes and my own code on that.
> I have read that rtnet has socket interface of its own.I just want to
> implement a raw socket(n need only socket and ioctl).Do you recommend I
> reinstall xenomai with posix skin as module
> Also is there any support for function like memcpy or memset(in string.h)
> or will I have to write my own functions?
> Thanks a lot for your continued help..you are a life saver!
> 

When writing applications for xenomai posix skin, the whole glibc is
avaiable. Only a few functions are substituted with xenomai specific
real-time services.

Anyway, I do not understand what you are trying to do and what fails.

Could you show us the code using the posix skin you are trying to
compile, with the makefile you use, so that we are able to investigate
the issue you face? Have you read the "porting posix applications to
xenomai" guide, in order to understand how to use xenomai posix skin?

Please no private mails.

Regards.

-- 
					    Gilles.

