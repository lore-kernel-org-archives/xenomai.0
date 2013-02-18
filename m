Message-ID: <512222AE.9050308@xenomai.org>
Date: Mon, 18 Feb 2013 13:46:38 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <511C911B.2080609@zultron.com> <511CD558.2000409@xenomai.org>
	<511D2777.107@zultron.com> <511D3D04.7080902@xenomai.org>
	<511EACB8.30000@zultron.com>
In-Reply-To: <511EACB8.30000@zultron.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Announcing beta x86 Xenomai kernel packages: squeeze,
 precise, lucid
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: John Morris <john@zultron.com>
Cc: emc-developers@lists.sourceforge.net, Xenomai <xenomai@xenomai.org>

On 02/15/2013 10:46 PM, John Morris wrote:

> On 02/14/2013 01:37 PM, Gilles Chanteperdrix wrote:
>> On 02/14/2013 07:05 PM, John Morris wrote:
>>> On 02/14/2013 06:15 AM, Gilles Chanteperdrix wrote:
>>> I'm hoping that someone else will volunteer to take over package
>>> maintenance once the dust settles a little.
>>
>>
>> To be completely frank, I hope we find a volunteer for the debian
>> packages too... So, actually, we could add such an announce to the wiki.
> 
> There's a request for volunteer package maintainers on the LinuxCNC
> wiki, but probably not in a prominent enough position.
> 
> Once the packages are tested and working, I'll be around to help fix
> problems.  However I'm quite eager to pass basic maintenance along to
> someone else, so I'm trying to make maintenance as easy as possible to
> help encourage volunteers.
> 
> When a new Xenomai is released, the steps to update the kernel packages
> are simple (I might forget something small):
> 
> - Rebuild xenomai package; just a few minor tweaks
> - Unpack new vanilla kernel and check out /debian directory from git
> - Fix version numbers in new debian/changelog entry
> - Update the vanilla kernel .config, either:
>   - pull a config verbatim from a similar Debian/Ubuntu kernel package
>   - or else update the existing config by running 'make fooconfig'
> - Rebuild.  Xeno patch is grabbed from /usr/src, and Xeno config is
>     automatically overlaid upon the vanilla config.
> 
> I'm also working on a Makefile that will automatically assemble all the
> ingredients and build the packages in a chroot (using
> pbuilder/debootstrap) for all combos of squeeze/precise/lucid and
> i386/amd64.  Whether the next maintainer uses it as is, or sets up a
> buildbot or buildd, it should make the job trivial.


The thing that worries me is that I have to test the debian packages as
part of each release, which means booting on the kernel, and running
xeno-regiression-test. But you are right: I should automate building and
testing the debian packages. I have everything needed at hand to do it.

>>>> We will also try and address the issues which were identified since you
>>>> started working on this, namely:
>>>> - allowing enabling the SMI workaround without kernel re-compilation
>>>
>>> Great!  I'm working around this for now by packaging Jan's smictrl
>>> utility.  That could actually be sufficient; I'd rather put effort into
>>> a more user-friendly wrapper, and maybe a config file and init script
>>> for persistent settings across reboots.
>>
>> I guess I have some little piece of code somewhere to handle
>> configuration files with the "windows ini" style, if you are interested.
> 
> I'm interested.  It may sit on the back burner for a little, but if it's
> easy for you to find, send it over and I'll certainly borrow from it
> when the time comes.


http://sisyphus.hd.free.fr/~gilles/conf.tar.bz2

conf.[ch] is the "configuration parser"
bm_conf.[ch] is an example.

I thought I had another version with the windows ini "[sections]", but I
do not find it, you only have "key = value", but it may be sufficient.

> 
>> The kernel-based approach has a big advantage though: recent kernels
>> have a driver for the LPC part of the Intel ICH, which is where the
>> register controlling SMI is found (drivers/mfd/lpc_ich.c), so, basing
>> our work on this driver in the I-pipe kernel, we could share the table
>> and avoid the double maintenance.
> 
> Is the advantage that the lpc_ich driver has more control than Jan's
> smictrl?  Anyway, I don't expect to get to the config/init script for a
> bit unless there's a lot of demand for it, so for now maybe I can be
> lazy here and wait for you to make the first move.  ;)


The advantage of the lpc_ich is that it has an exhaustive list of all
the Intel LPCs product IDs, which has always been the weak point of
Xenomai's SMI workaround module.

-- 
                                                                Gilles.

