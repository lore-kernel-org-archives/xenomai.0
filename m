Message-ID: <511D3D04.7080902@xenomai.org>
Date: Thu, 14 Feb 2013 20:37:40 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <511C911B.2080609@zultron.com> <511CD558.2000409@xenomai.org>
	<511D2777.107@zultron.com>
In-Reply-To: <511D2777.107@zultron.com>
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
To: John Morris <john@zultron.com>
Cc: emc-developers@lists.sourceforge.net, Xenomai <xenomai@xenomai.org>

On 02/14/2013 07:05 PM, John Morris wrote:

> On 02/14/2013 06:15 AM, Gilles Chanteperdrix wrote:
>> On 02/14/2013 08:24 AM, John Morris wrote:
>>
>>> Hello emc-dev and xenomai lists,
>>>
>>> I'm very pleased to announce the availability of one-size-fits-all
>>> Xenomai kernel packages for x86 arch.  These packages have been
>>> successfully tested on umpteen motherboards at this point, and are ready
>>> for wider testing.
>>>
>>> * Beta status *
>>> Distros: Ubuntu Precise and Lucid; Debian Squeeze
>>> Architectures: i686 and amd64
>>> Xenomai version: v2.6.2.1, released 2013/01/25
>>> Kernel version: v3.5.7 vanilla
>>> Kernel config:  Ubuntu 3.5 stock kernel with Xenomai additions
>>>
>>> The instruction wiki page on linuxcnc.org is somewhat oriented toward
>>> LinuxCNC users, but most will apply to the general audience:
>>>
>>>   http://wiki.linuxcnc.org/cgi-bin/wiki.pl?XenomaiKernelPackages
>>
>>
>> Hi John,
>>
>> thanks to you and the LinuxCNC community at large for working on this.
>> Is there any problem if we modify the page about Debian on Xenomai wiki
>> to point to this page?
> 
> Of course you're welcome to do that.  Or if you like, you (or I) can
> copy the information to the xenomai.org wiki and the linuxcnc wiki can
> point to your page.
> 
> I'm hoping that someone else will volunteer to take over package
> maintenance once the dust settles a little.


To be completely frank, I hope we find a volunteer for the debian
packages too... So, actually, we could add such an announce to the wiki.

>> We will also try and address the issues which were identified since you
>> started working on this, namely:
>> - allowing enabling the SMI workaround without kernel re-compilation
> 
> Great!  I'm working around this for now by packaging Jan's smictrl
> utility.  That could actually be sufficient; I'd rather put effort into
> a more user-friendly wrapper, and maybe a config file and init script
> for persistent settings across reboots.


I guess I have some little piece of code somewhere to handle
configuration files with the "windows ini" style, if you are interested.

The kernel-based approach has a big advantage though: recent kernels
have a driver for the LPC part of the Intel ICH, which is where the
register controlling SMI is found (drivers/mfd/lpc_ich.c), so, basing
our work on this driver in the I-pipe kernel, we could share the table
and avoid the double maintenance.

-- 
                                                                Gilles.

