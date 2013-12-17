Message-ID: <52B06343.4050505@xenomai.org>
Date: Tue, 17 Dec 2013 15:44:19 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <3A58CFC9-23B9-4B72-A071-3790BEB0912A@mah.priv.at>
 <52B0590F.5050108@xenomai.org> <201312171528.10577.leo@alaxarxa.net>
In-Reply-To: <201312171528.10577.leo@alaxarxa.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] debian xenomai package
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: xenomai@xenomai.org

On 12/17/2013 03:28 PM, Leopold Palomo-Avellaneda wrote:
> A Dimarts, 17 de desembre de 2013, Gilles Chanteperdrix va escriure:
>> On 12/17/2013 12:19 PM, Michael Haberler wrote:
>>> we're considering how to package LinuxCNC such that it can eventually
>>> be included in debian
>>>
>>> the core package will support RT-PREEMPT because an RT-PREEMPT kernel
>>> is available stock in debian; the other RT kernels will be covered by
>>> separate packages (Xenomai, RTAI).
>>>
>>> so far we've used the xenomai userland support straight off the git
>>> repo, but it might make sense to switch to
>>> http://packages.debian.org/jessie/xenomai-runtime for one less
>>> external raw repo dependency
>>>
>>> question - is this a recommendable route?
>>>
>>> (depends a bit on how well the debian package tracks the repo - does
>>> this happen 'occasionally', or per-release?; so far we havent had
>>> major issues with userland support but better ask before relying on
>>> something only loosely maintained)
>>
>> I think the user-space run-time is not really a problem, Xenomai 2.6
>> does not need any particular option on configure command line to avoid
>> issues, the defaults are fine for all architectures. Even the Debian
>> project rule files, which passes options which either no longer even
>> exists or are not useful, gets a working build.
>>
>> What is much harder, and not really already available in the Debian
>> project is to package a kernel compiled with the right options to avoid
>> any issues, and avoid the hassle to all users to have to find out these
>> options by themselves,
>
> I like the " right options to avoid any issues".
>
> Really, it's possible to provide a Xenomai patched kernel for the 95% of the
> users/hardware?

Yes. Starting with the I-pipe core patches, definitely. And if not, I 
think this is something we should work on. Because in the long run, if 
users installed pre-packaged kernels and did not have to follow the 
traditional trial-and-error process of configuring kernels for xenomai, 
we would have less questions on this subject on the mailing list.

>
>> whereas, at least on x86, we can provide one such
>> Debian-like kernel. I did it for Linux 3.5.7 on xenomai 2.6.2.1, but did
>> not renew the experience with xenomai 2.6.3 because nobody downloaded
>> the .debs. But the "reprepro" directory is still there, so restarting it
>> would be easy.
>
> Well, I use my own package, but I have not any problem to promote this ones.
> We can talk. I have no interest in maintain any kernel package, on the
> contrary.

That is my point, the same work, configuring the kernel, is replicated 
by almost every user of xenomai, for almost no good reason. It makes 
sense to optimize compilation for one processor on the ARM architecture, 
because you easily loose microseconds latency with the wrong option. On 
x86 however, I do not think there is not much to gain (except 
compilation time) by trimming down the configuration.


-- 
					    Gilles.

