Message-ID: <50F30F19.1040901@zultron.com>
Date: Sun, 13 Jan 2013 13:46:33 -0600
From: John Morris <john@zultron.com>
MIME-Version: 1.0
References: <50EA9B9A.6000804@zultron.com> <50EB4FAD.2000804@xenomai.org>
	<50EBDAC8.8010006@zultron.com> <50EC80AD.3090301@xenomai.org>
	<50F26428.8040705@zultron.com> <50F2A650.7050700@xenomai.org>
In-Reply-To: <50F2A650.7050700@xenomai.org>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 01/13/2013 06:19 AM, Gilles Chanteperdrix wrote:
> On 01/13/2013 08:37 AM, John Morris wrote:
> 
>>
>>
>> On 01/08/2013 02:25 PM, Gilles Chanteperdrix wrote:
>>> On 01/08/2013 09:37 AM, John Morris wrote:
>>>> The most difficult part has been to create a kernel config that works on
>>>> everybody's hardware.  My approach to solving that problem is to create
>>>> a well-documented, minimal set of configuration changes that may be
>>>> applied to stock distro kernels.
>>>
>>>
>>> This minimal set of change is documented, for xenomai, on the website.
>>> If you find you need other changes, they may be bugs, and could need fixing.
>>
>> Actually, I spent a few days bisecting the RedHat 2.6.38.8 kernel
>> .config with those minimal changes applied to locate a few problems.
>> See the config snippet pasted at the end.
> 
> 
> I understand this, what I mean is that you should post (or have posted)
> the problems on the list. Disabling a configuration option is simply
> papering over the bug, and most of these issues can be fixed in a way
> that allow keeping the choice of enabling or disabling the option.

Ah yes, understood.  I did intend to bring this to the list, but to do
what I could by myself first.

>> As for 3.5.x, the only change was to disable CPUMASK_OFFSTACK, enabled
>> by default in RH kernels.
> 
> 
> Looking at the kernel headers, it simply means that Xenomai has to use
> set_cpus_allowed_ptr and provide a wrapper for older kernels which had
> only set_cpus_allowed.

Right.  I went through and fixed about half of them in Xenomai, but then
came upon one that looked like it touched the API, and realized I'd
better stop.  It's a pretty easy fix, though.

>> Also, there are many newbie pitfalls in generating a valid kernel
>> .config, as I'm finding out!
> 
> 
> The problem is that it is difficult for us to test every possible
> configurations combinations, so, when you find such a problem, please
> post about it.

Will do.  I predict I'll have a bunch of users reporting problems with
packages to me soon.

>>> So, we tried and improved the I-pipe patches so that a single or a pair
>>> of kernels (SMP and UP) can be generated for each architecture.
>>
>> Great!  This is the right way to go in order to increase adoption.
>>
>>> I started setting up a repository on the xenomai server, but obviously,
>>> can not do it for all distributions, so, any help is welcome. What I can
>>> propose is to set-up an inoticoming repository, give you access to an
>>> incoming repository through scp (you whould have to send me your ssh
>>> public key for that). Then, before a release, we would work to provide
>>> the corresponding debian and ubuntu packages. As for the fedora
>>> packages, I do not know the equivalent of reprepro and inoticoming.
>>
>> I've been thinking about what I can offer over the last few days.  I'm
>> really too inexperienced with Deb-like distros and I'm poor at
>> maintenance.  My solution would be to automate this chore with some type
>> of build infrastructure, but that would probably take me much longer
>> than someone else more at home with Debian.
> 
> 
> I have been thinking about that too. Actually, running my tests on x86
> from the Debian package instead of custom build kernels does not change
> much (except the compilation time for the kernel, so, it has to be done
> once I have a working kernel). Though I am going to test only Debian
> stable, not Ubuntu.

Understood.  Actually, testing could be automated by installing the OS
with the kernel to be tested and run xeno-regression-test.  That's some
infrastructure that I don't have ATM, but wouldn't be a huge leap.

>> On the other hand, it would be quite easy for me to do this for el6 and,
>> once I have packages, Fedora, since we do have the automated build
>> infrastructure (and the expertise) in the shop that it wouldn't be
>> difficult.  In this case, it would be easiest to keep a git repo of the
>> RPM files online (just like the one I recently pointed to in other
>> threads) to keep the development open, compile the packages on our
>> infrastructure, and rsync the resulting repo either to the xenomai.org
>> site, my site, or anywhere else suitable.  The only piece missing would
>> be a public view of the build system (called 'koji', the same as the
>> Fedora project uses), which could come in time if we choose.
>>
>> At any rate, I will certainly have my own el6 repo up soon, and I'll
>> announce it here for folks to try out.
> 
> 
> Ok, as you wish, it is not really a problem for us to provide you with a
> git access, and an access to set-up a repository. At any rate, whatever
> we do, we should also have a page in the wiki explaining how to get the
> Fedora packages.

Ok, thanks.  Taking the lazy approach, let's wait until my repos are up,
and then see what looks like the best option.

	John

