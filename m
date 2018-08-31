References: <368012593.481146.1535555747324.JavaMail.zimbra@wolfram.com>
 <8992f6ad-6627-cb28-32f8-a3e890567e3a@xenomai.org>
 <1401452424.613986.1535613456917.JavaMail.zimbra@wolfram.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <483207e1-3b1d-26d6-3e5d-ae5b292aa035@xenomai.org>
Date: Fri, 31 Aug 2018 12:19:52 +0200
MIME-Version: 1.0
In-Reply-To: <1401452424.613986.1535613456917.JavaMail.zimbra@wolfram.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Importance of missing modechk/cobolt.wrappers
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Per Oberg <pero@wolfram.com>, xenomai <xenomai@xenomai.org>

On 08/30/2018 09:17 AM, Per Oberg wrote:
> 
> ----- Den 29 aug 2018, på kl 18:01, Philippe Gerum rpm@xenomai.org skrev:
> 
>> On 08/29/2018 05:15 PM, Per Oberg wrote:
>>> Hello all
> 
> 
>>> I'm working with a Yocto build of xenomai. I have compiled a sdk for building on
>>> a build-host but I am doing something wrong because I get the wrong path to
>>> modechk.wrappers and cobalt.wrappers. I could probably fix this but I just want
>>> to know whether this is a real problem or not.
> 
>>> When I run xeno-config i get :
>>> Xenomai: wrappers cannot be read from /usr/lib/modechk.wrappers
>>> Xenomai: wrappers cannot be read from /usr/lib/cobalt.wrappers
> 
>>> The contents of the wrapper files are listed below for completeness. It seems
>>> like a lot of stuff that is not getting wrapped when these files are missing,
>>> and that would mean that I am missing a lot of wrapping and that I definitely
>>> need to fix it. Or is is just a warning?
> 
> 
>> It's an important warning, your build may be broken. This means that
>> wrapping failed for any executable depending on it, which retrieved its
>> linker flags from xeno-config --ldflags. Basically, all built-in Xenomai
>> apps (e.g. latency, switchtest), and any user application depending on
>> xeno-config for retrieving those flags.
> 
>>> How do I know if the final software is wrapping stuff the way I want?
> 
>> Dumping the executable's namelist should always refer to the wrapper for
>> any routine listed in the wrapper files. e.g.
> 
>> $ nm -u $executable | grep 'U __wrap_'
> 
>> U __wrap_clock_gettime
>> U __wrap_close
>> U __wrap_fclose
>> U __wrap_fprintf
>> U __wrap_fputc
>> U __wrap_fputs
>> U __wrap_free
>> U __wrap_fwrite
>> U __wrap_ioctl
>> U __wrap_kill
>> U __wrap_malloc
>> U __wrap_open
>> U __wrap_printf
>> U __wrap_pthread_attr_init
>> U __wrap_pthread_create
>> U __wrap_pthread_join
>> U __wrap_pthread_setname_np
>> U __wrap_puts
>> U __wrap_read
>> U __wrap_sem_close
>> U __wrap_sem_open
>> U __wrap_sem_post
>> U __wrap_sem_unlink
>> U __wrap_sem_wait
>> U __wrap_time
>> U __wrap_timerfd_create
>> U __wrap_timerfd_settime
>> U __wrap_write
> 
>> --
>> Philippe.
> 
> Thanks for that, I suspected this was the case. 
> 
> I did do some checking on the built-in Xenomai apps and they are compiled using the right flags. This does not puzzle me because we are usually able to trust the magic of the build system for solving this.

Contradicting my original concern about this, the build rules for the
built-in apps are picking the wrappers directly from the source tree, so
this can't fail (which makes sense, as they should have been built
before the installation process can take place anyway).

 (Meaning: Since there are no libraries, linker files, or other
dependencies in the "prefix" directories during the first build the
tools must all be referring to the build-dir instead of the prefix
destination.)
> 
> In my case, since I'm building for a target with no build tools installed (which I assume would be quite normal for a lot of people doing real time stuff) I need to prepare some kind of SDK. For the X86 platform I can install Xenomai on my laptop, and have the exact same setup on the target. But I rather not have it this way. Is there some kind of special flag I can use during build of the SDK or how do people generally go about this?
> 

Are you referring to a staging dir?
https://gitlab.denx.de/Xenomai/xenomai/wikis/Installing_Xenomai_3
discusses this I believe.

-- 
Philippe.

