Message-ID: <4FCEFFD5.6050105@xenomai.org>
Date: Wed, 06 Jun 2012 08:59:33 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20120606012640.3058C728001@webmail.sinamail.sina.com.cn>
	<4FCEF71D.7050704@xenomai.org>
In-Reply-To: <4FCEF71D.7050704@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] How to build user_space
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: wonder_code@sina.com
Cc: Xenomai <Xenomai@xenomai.org>

On 06/06/2012 08:22 AM, Gilles Chanteperdrix wrote:
> On 06/06/2012 03:26 AM, wonder_code@sina.com wrote:
>> I have followed your steps to ldd clocktest,and the result as follow:
>> $           not a dymamic executable
> 
> Ok. You probably picked the wrong ldd. You should have used the
> toolchain ldd. Try that instead:
> 
> LD_TRACE_LOADED_OBJECTS=1 /usr/bin/clocktest
> 

There are several way your installation could be wrong:
- you could be using a root filesystem with versions of the libraries
different from the ones with which the toolchain linked xenomai
binaries. For instance, your root filesystem could use
/lib/ld-linux.so.2 while your toolchain is using /lib/ld-linux.so.3. The
solution to this is to use, for the libc libraries, the ones used by
your toolchain.
- you could have a mismatch between the EABI setting of your kernel, and
the EABI setting of the toolchain, for instance, the kernel is compiled
without EABI, whereas you are using an EABI toolchain. But for such a
system to be able to boot, the root filesystem must have been built with
a toolchain different from the one you use to build xenomai.

-- 
                                                                Gilles.

