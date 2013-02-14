Message-ID: <511D2777.107@zultron.com>
Date: Thu, 14 Feb 2013 12:05:43 -0600
From: John Morris <john@zultron.com>
MIME-Version: 1.0
References: <511C911B.2080609@zultron.com> <511CD558.2000409@xenomai.org>
In-Reply-To: <511CD558.2000409@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Announcing beta x86 Xenomai kernel packages: squeeze, precise,
 lucid
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: emc-developers@lists.sourceforge.net, Xenomai <xenomai@xenomai.org>

On 02/14/2013 06:15 AM, Gilles Chanteperdrix wrote:
> On 02/14/2013 08:24 AM, John Morris wrote:
> 
>> Hello emc-dev and xenomai lists,
>>
>> I'm very pleased to announce the availability of one-size-fits-all
>> Xenomai kernel packages for x86 arch.  These packages have been
>> successfully tested on umpteen motherboards at this point, and are ready
>> for wider testing.
>>
>> * Beta status *
>> Distros: Ubuntu Precise and Lucid; Debian Squeeze
>> Architectures: i686 and amd64
>> Xenomai version: v2.6.2.1, released 2013/01/25
>> Kernel version: v3.5.7 vanilla
>> Kernel config:  Ubuntu 3.5 stock kernel with Xenomai additions
>>
>> The instruction wiki page on linuxcnc.org is somewhat oriented toward
>> LinuxCNC users, but most will apply to the general audience:
>>
>>   http://wiki.linuxcnc.org/cgi-bin/wiki.pl?XenomaiKernelPackages
> 
> 
> Hi John,
> 
> thanks to you and the LinuxCNC community at large for working on this.
> Is there any problem if we modify the page about Debian on Xenomai wiki
> to point to this page?

Of course you're welcome to do that.  Or if you like, you (or I) can
copy the information to the xenomai.org wiki and the linuxcnc wiki can
point to your page.

I'm hoping that someone else will volunteer to take over package
maintenance once the dust settles a little.  That will be a while, but
if you're interested in hosting the package repos on xenomai.org
eventually, moving the wiki material there makes sense.

> 
> We will also try and address the issues which were identified since you
> started working on this, namely:
> - allowing enabling the SMI workaround without kernel re-compilation

Great!  I'm working around this for now by packaging Jan's smictrl
utility.  That could actually be sufficient; I'd rather put effort into
a more user-friendly wrapper, and maybe a config file and init script
for persistent settings across reboots.

> - allow building Xenomai user-space support with _FORTIY_SOURCE

This affects RedHat-like distros, which turn this on by default in
package builds.  My RPM packages (forthcoming) have a workaround, so
low-priority for the packaging effort.

> - find the origin of the latency issue with i915 and opengl
> - the harcoded 80 in the tsc test

Great.  On my test machine (1.7GHz Celeron), 200 would have been 2x
enough.  Michael saw this problem on his machine too, but I didn't see
his numbers.

Thanks for the support Gilles.  I think this will help the community
greatly, and hopefully reduce the support headache for developers at the
same time!

	John

