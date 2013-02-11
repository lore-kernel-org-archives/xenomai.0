Message-ID: <511944AC.6060800@xenomai.org>
Date: Mon, 11 Feb 2013 20:21:16 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <718DFA7882181D45B8BD18F31C46D55427A67586@MBX204.domain.local>	<718DFA7882181D45B8BD18F31C46D55427A675C0@MBX204.domain.local>,
	<C2B9A61F-3727-4B5F-9AC4-8212B803A725@mah.priv.at>
	<718DFA7882181D45B8BD18F31C46D55427A67767@MBX204.domain.local>
In-Reply-To: <718DFA7882181D45B8BD18F31C46D55427A67767@MBX204.domain.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Question about 2.6.2.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gregory Perry <Gregory.Perry@govirtual.tv>
Cc: Michael Haberler <mah@mah.priv.at>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 02/11/2013 06:50 PM, Gregory Perry wrote:
>> ________________________________________ From: Michael Haberler
>> [mah@mah.priv.at] Sent: Monday, February 11, 2013 6:06 AM To:
>> Gregory Perry Subject: Re: [Xenomai] Question about 2.6.2.1
>> 
>> Am 11.02.2013 um 06:23 schrieb Gregory Perry:
>> 
>>> How do I go about finding out what the most recent kernel for ARM
>>> that is supported by 2.6.2.1?  Is it still 3.2.21?  Can someone
>>> point me to the file in the Xenomai >distro which describes the
>>> most recent kernel released with each Xenomai?
>>> 
>>> I am going to take the plunge and patch each release up to 3.2.21
>>> on the BeagleBone with the TI support patches, and then attempt a
>>> Xenomai integration on that >optimized TI kernel.
>> 
>> are you aware of this:
>> 
>> http://wiki.linuxcnc.org/cgi-bin/wiki.pl?BeagleboneDevsetup
>> 
>> and this
>> 
>> http://git.mah.priv.at/gitweb?p=linuxcnc-kernel.git;a=summary ?
>> 
>> - Michael
> 
> Yeah I've been following the EMC project for a while now as well as
> other initiatives to build Xenomai on the BeagleBone and BeagleBoard.
> In fact I think that Stephan Kappertz has posted the best integration
> to date for the BeagleBone and Xenomai on Angstrom; however I am not
> aware of anyone to date that's been able to successfully integrate
> all of the TI patches into the kernel and then patch the kernel with
> Xenomai.  So either you get the BeagleBone kernel with all all TI
> optimizations, or a generic kernel with Xenomai support, but not
> both.  Typically this breaks support for additional things in the
> kernel, probably sysfs support for sysfs-based GPIO access and PWM
> toggling etc.

sysfs-base GPIO access and PWM is a bad example, as except for powering
on/off things once in a while, you do not really want the overhead of a
system call for toggling a GPIO, besides the fact that it would cause a
real-time task to cease being a real-time task.

> 
> So according to Robert Nelson (the TI patch maintainer for the
> BeagleBoard/Bone kernel), the only way to do this is to start with
> the Aragon kernel, apply each kernel revision patch from 3.2.0 ->
> 3.2.21, with the TI patch branch applied at each to arrive at a
> 3.2.21 kernel that has all of the TI patches integrated.
> 
> I think this is the right approach, or maybe I am just shooting fish
> in a barrel here with this.

The right approach is to get the code from the TI branch merged into the
mainline kernel. Failing that, provide a pre and post patches (like
Michael provided) for the target kernel, patches which we can ship with
Xenomai. Merging the I-pipe with a vendor kernel should not be a really
hard job, you should only get conflicts between the processor-specific
files modified by the I-pipe kernel, which should be say, less than 10
files.

-- 
					    Gilles.

