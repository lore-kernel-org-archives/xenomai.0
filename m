Date: Wed, 8 Jul 2015 12:11:45 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150708101145.GL20176@hermes.click-hack.org>
References: <D1C206F1.39ADA%glen@jetsoftdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D1C206F1.39ADA%glen@jetsoftdev.com>
Subject: Re: [Xenomai] Xemomai 3 - posix demo programs don't seem to be
 loading the right socket program.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Glen Wernersbach <glen@jetsoftdev.com>
Cc: xenomai@xenomai.org

On Tue, Jul 07, 2015 at 10:45:05PM -0400, Glen Wernersbach wrote:
> Hi All,
> 
> Fooling around with Xenomai 3 RC4. I can get the TestSuite to work but when
> I run any of the standard posix demo examples I get the following error:
> ./bufp-readwrite 
> socket 1: Address family not supported by protocol
> socket 2: Address family not supported by protocol
> 
> Looking on the web this would indicate that the wrapper instruction is not
> in the linker flags but it is. I tried building my own copy just to make
> sure the wrapper was included but got the same error.
> make
> gcc -o RsConMain RsConMain.c -I/usr/xenomai/include/cobalt
> -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__COBALT__
> -Wl,@/usr/xenomai/lib/cobalt.wrappers   -L/usr/xenomai/lib -lcobalt
> -lpthread -lrt   

I do not think "RsConMain" is a "standard posix demo example", or I
do not know what you mean by that. Anyway, providing the source of
the code you compile would allow us to help you instead of making
educated guesses. But the obvious question is: do you have the
support for the socket family you are trying to use enabled in the
kernel configuration?

-- 
					    Gilles.
https://click-hack.org

