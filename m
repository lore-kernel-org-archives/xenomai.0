Message-ID: <509A7C51.9010702@xenomai.org>
Date: Wed, 07 Nov 2012 16:20:49 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CANzNmi-P+pXRT0ECC-0CPtZyR8f4cmMt+ZkbzHvJU_9sgWtD9g@mail.gmail.com>
	<50980A35.8090607@xenomai.org> <509A7839.40509@gmail.com>
In-Reply-To: <509A7839.40509@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Compiling the Xenomai examples 2.0
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

On 11/07/2012 04:03 PM, Sebastian Pavez wrote:
> El 05/11/2012 15:49 p.m., Gilles Chanteperdrix escribió:
>> On 11/05/2012 04:09 PM, Sebastian Pavez wrote:
>>
>>> make -C /usr/src/linux-3.2.32 ARCH= CROSS_COMPILE=
>>> (...)
>>> What should I do??
>>
>> Read the documentation? Documentation/kbuild/modules.txt in the kernel
>> sources for starters. The above line can not work.
>>
> Thank you for your answer.
> I've been reading the documentation you suggest me and also something 
> about the Makefile stuff.
> It's imperative to do the process with the modules?

If is not imperative at all to compile the examples, xenomai comes with
a testsuite which allows you to test whether your system runs correctly.
The aim of the examples is to show you how to compile code outside
xenomai build system.

 I mean, I've
> followed the instructions on http://www.xenomai.org/index.php/Examples 
> but not for
> cross-compiling and I supposed that with those instructions would be enough.
> 
> The native examples compile fine, but the posix ones don't (and I'm 
> planning to u se posix). I understand the line
> 
> make -C /usr/src/linux-3.2.32 ARCH= CROSS_COMPILE=
> 
> looks weird and there's a problem because after that it gives me 
> "/usr/src/linux-3.2.32/arch//Makefile: No such file or directory", but 
> if I'm not cross-compiling what should I do?

What about passing a correct value for the ARCH variable, as described
in Documentation/kbuild/kbuild.txt?

-- 
					    Gilles.

