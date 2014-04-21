Message-ID: <535599ED.3030409@zultron.com>
Date: Mon, 21 Apr 2014 17:21:33 -0500
From: John Morris <john@zultron.com>
MIME-Version: 1.0
References: <52CB0DA1.9080302@zultron.com> <52CB17A9.6080901@xenomai.org>
 <52CB30F9.50505@zultron.com> <5353FBA6.2060504@xenomai.org>
In-Reply-To: <5353FBA6.2060504@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Xenomai Red Hat packaging
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 04/20/2014 11:53 AM, Gilles Chanteperdrix wrote:
> Le 06/01/2014 23:40, John Morris a écrit :
>> On 01/06/2014 02:52 PM, Gilles Chanteperdrix wrote:
>>> On 01/06/2014 09:10 PM, John Morris wrote:
>>>> Here are the packaging materials I've been using on Red Hat Enterprise
>>>> Linux clones for some time now, also recently updated for Fedora.
>>>>
>>>> https://github.com/zultron/xenomai-rpm
>>>>
>>>> The packaging is pretty straightforward, and follows the Debian
>>>> packaging for the xenomai-devel subpackage.
>>>>
>>>> A significant addition is the 'xenomai-gid-ctl' script for configuring
>>>> non-root access to Xenomai services, plus sysv and systemd boot init
>>>> scripts.
>>>
>>> Are these specific to Red Hat, or can we put them in the set of files
>>> installed by default?
>>
>> The 'xenomai-gid-ctl' script should work anywhere.
>>
>> The 'xenomai.default' file (installed into /etc/default/xenomai) works
>> with RH- & Debian-derivatives, and other distros with the /etc/default
>> directory.  /etc/default/xenomai is only used to override the default
>> 'xenomai' group, is semi-optional, and may be relocated.
>>
>> Installing 'xenomai-gid-ctl' (and 'xenomai.default', if /etc/default
>> exists) from 'make install' could be useful to the end user, since it is
>> a stand-alone utility.
>>
>> The EL6 sysv init script needs modification to support Debian's LSB init
>> system, simple for someone more familiar.
>>
>> Other projects I'm familiar with often ship system init scripts in a
>> e.g. 'contrib' directory, and don't include complex makefile logic to
>> detect distro and install the correct init script.  Manual installation
>> is left up to the end user or the packager.
>>
>>>    I'd appreciate comments on the control script's correctness
>>>> and the init scripts' utility.
>>>
>>> You do not need to pass --enable-x86-tsc as it is enabled by default
>>> now.
>>
>> Thanks!
>>
>>> As for building the doc, xenomai sources contain generated
>>> documentation, so if you do not enable any option, you will have some
>>> documentation installed. If you still want to generate the doxygen
>>> documentation, what is the problem with --enable-dox-doc?
>>
>> I'll find time to revisit doc generation and report back.
>
> Hi John,
>
> despite the long response time, I am still interested in merging support
> for redhat packaging. I guess we coud add a "make rpm" rule which builds
> the redhat package. However, looking at the spec file, it see that it
> works by looking for the release tarball on gna download site, so, is it
> possible to get the spec file to use the sources from the .. directory,
> or failing that, use a tarball generated locally (we would then simply
> have to get the rpm target depend on the dist target).

Hi Gilles,

Rpmbuild actually doesn't try to download a tarball; that is expected to 
be in the local directory.  The URL is for recording the tarball's 
origin, for use by humans and Fedora Project infrastructure, and ignored 
by the rpm-build system.

When the RPM is built from git, the Release: tag should be changed to 
indicate as much.  A little work on the specfile would need to be done 
to make that easier.

A script could run 'git archive' to build a tarball, tweak the Release: 
in a copy of the specfile, and then perform some annoying acrobatics 
needed to build the packages.  Is the purpose of the script for the 
end-user?

I'm actually setting up a Wandboard right now, and will be building 
Xenomai for it tomorrow.  While I'm at it, I'll work some of the changes 
into the specfile itself.

Additionally, I did finally get that buildbot running for RHEL6 and 
current Fedoras, x86_64 and i686 architectures, but backed down to 
2.6.2.1 to do so.  In the process, most of the issues I identified 
running 2.6.3 were also encountered in 2.6.2.1 and solved (operator 
error, of course :P ), so it might be time to take another stab at 
building against 2.6.3.

	John

