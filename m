Message-ID: <51062B1B.3050305@xenomai.org>
Date: Mon, 28 Jan 2013 08:39:07 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50EA9B9A.6000804@zultron.com> <50EB4FAD.2000804@xenomai.org>
	<50EBDAC8.8010006@zultron.com> <50EC80AD.3090301@xenomai.org>
	<50F26428.8040705@zultron.com> <50F2A650.7050700@xenomai.org>
	<50F30F19.1040901@zultron.com> <51062A21.3050208@zultron.com>
In-Reply-To: <51062A21.3050208@zultron.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Debian package build problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: John Morris <john@zultron.com>
Cc: xenomai@xenomai.org

On 01/28/2013 08:34 AM, John Morris wrote:

> On 01/13/2013 01:46 PM, John Morris wrote:
>> On 01/13/2013 06:19 AM, Gilles Chanteperdrix wrote:
>>> On 01/13/2013 08:37 AM, John Morris wrote:
>>>> On 01/08/2013 02:25 PM, Gilles Chanteperdrix wrote:
>>>>> So, we tried and improved the I-pipe patches so that a single or a pair
>>>>> of kernels (SMP and UP) can be generated for each architecture.
>>>>
>>>> Great!  This is the right way to go in order to increase adoption.
>>>>
>>>>> I started setting up a repository on the xenomai server, but obviously,
>>>>> can not do it for all distributions, so, any help is welcome. What I can
>>>>> propose is to set-up an inoticoming repository, give you access to an
>>>>> incoming repository through scp (you whould have to send me your ssh
>>>>> public key for that). Then, before a release, we would work to provide
>>>>> the corresponding debian and ubuntu packages. As for the fedora
>>>>> packages, I do not know the equivalent of reprepro and inoticoming.
>>>>
>>>> I've been thinking about what I can offer over the last few days.  I'm
>>>> really too inexperienced with Deb-like distros and I'm poor at
>>>> maintenance.  My solution would be to automate this chore with some type
>>>> of build infrastructure, but that would probably take me much longer
>>>> than someone else more at home with Debian.
>>>
>>>
>>> I have been thinking about that too. Actually, running my tests on x86
>>> from the Debian package instead of custom build kernels does not change
>>> much (except the compilation time for the kernel, so, it has to be done
>>> once I have a working kernel). Though I am going to test only Debian
>>> stable, not Ubuntu.
>>
>> Understood.  Actually, testing could be automated by installing the OS
>> with the kernel to be tested and run xeno-regression-test.  That's some
>> infrastructure that I don't have ATM, but wouldn't be a huge leap.
>>
>>>> On the other hand, it would be quite easy for me to do this for el6 and,
>>>> once I have packages, Fedora, since we do have the automated build
>>>> infrastructure (and the expertise) in the shop that it wouldn't be
>>>> difficult.  In this case, it would be easiest to keep a git repo of the
>>>> RPM files online (just like the one I recently pointed to in other
>>>> threads) to keep the development open, compile the packages on our
>>>> infrastructure, and rsync the resulting repo either to the xenomai.org
>>>> site, my site, or anywhere else suitable.  The only piece missing would
>>>> be a public view of the build system (called 'koji', the same as the
>>>> Fedora project uses), which could come in time if we choose.
>>>>
>>>> At any rate, I will certainly have my own el6 repo up soon, and I'll
>>>> announce it here for folks to try out.
>>>
>>>
>>> Ok, as you wish, it is not really a problem for us to provide you with a
>>> git access, and an access to set-up a repository. At any rate, whatever
>>> we do, we should also have a page in the wiki explaining how to get the
>>> Fedora packages.
>>
>> Ok, thanks.  Taking the lazy approach, let's wait until my repos are up,
>> and then see what looks like the best option.
> 
> Hi Gilles,
> 
> I put up an experimental PPA with 2.6.2.1 release packages for Ubuntu
> 12.04 Precise:
> 
> http://wiki.linuxcnc.org/cgi-bin/wiki.pl?XenomaiKernelPackages
> 
> The packages are not good for anything except initial testing, and I've
> asked the folks on the emc-devel list to give them a try.  The first
> success has been reported, but there may not be many testers until
> packages are available for Ubuntu 10.04 Lucid, where current LinuxCNC
> users are stuck.
> 
> I have working EL6 packages too, but haven't put up a repository yet;
> hopefully in the next couple of days.
> 
> My project depends on LinuxCNC and therefore Xenomai, and I plan to
> maintain the RedHat packages myself.  I haven't decided exactly what to
> do about the Debian packages yet, but I need to ensure quality,
> up-to-date .deb packages are maintained for x86 architecture for at
> least a couple of years.


I have compiled and tested the xenomai packages for Debian stable (for
amd64 and i686), and am going to put them in the repository. The plan is
to push them with every release.

Though, I confirmed the issue reported with the i915 graphic card, and
need to investigate this.


-- 
                                                                Gilles.

