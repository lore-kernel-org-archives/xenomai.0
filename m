Message-ID: <50A23100.5040003@xenomai.org>
Date: Tue, 13 Nov 2012 12:37:36 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50A188A3.90704@gmail.com>
In-Reply-To: <50A188A3.90704@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] module.h error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sebastian Pavez <sebastian.pavez.t@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On 11/13/2012 12:39 AM, Sebastian Pavez wrote:

> Hi everybody!
> 
> I have xenomai-2.6.1 with kernel 3.2.32 over an i7.
> I'm trying to compile the attached files, but with make I get this message:
> 
> cc -I/lib/modules/3.2.32/build/include/xenomai 
> -I/lib/modules/3.2.32/build/include/xenomai/compat
> -I/lib/modules/3.2.32/build/include/xenomai/posix     -c -o sinus.o sinus.c
> sinus.c:2:26: fatal error: linux/module.h: No such file or directory
> compilation terminated.
> make: *** [sinus.o] Error 1
> 
> How could I fix this?? This mean that I have some problems with 
> xenomai's installation?? or did I overlook something??


The makefiles in xenomai examples are makefiles for you to reuse, but to
reuse them, you have to understand how they work.

See Documentation/kbuild/modules.txt in the linux kernel sources to
understand how to compile modules.

-- 
                                                                Gilles.

