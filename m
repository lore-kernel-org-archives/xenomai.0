Message-ID: <5213C9AD.2010903@xenomai.org>
Date: Tue, 20 Aug 2013 21:55:25 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <52138425.2030000@steinkuehler.net> <5213B7D3.5030606@xenomai.org>
	<5213C836.403@steinkuehler.net>
In-Reply-To: <5213C836.403@steinkuehler.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Building BeagleBone kernel from git
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Charles Steinkuehler <charles@steinkuehler.net>
Cc: xenomai@xenomai.org

On 08/20/2013 09:49 PM, Charles Steinkuehler wrote:
> On 8/20/2013 1:39 PM, Gilles Chanteperdrix wrote:
>> On 08/20/2013 04:58 PM, Charles Steinkuehler wrote:
>>> I am currently working with LinuxCNC in a xenomai real-time
>>> environment on the BeagleBone:
>>> 
>>> http://bb-lcnc.blogspot.com/p/machinekit_16.html
>>> 
>>> Everything is working well, but the kernel is being built using
>>> an out-of-tree patch set obtained by Michael Haberler.
>>> 
>>> I would like to switch to using a more 'official' xenomai build
>>> from git, but am unclear how to proceed.
>>> 
>>> Which git repository/branch would be the most appropriate for
>>> use in building a xenomai kernel for the BeagleBone / AM335x
>>> SoC?
>>> 
>>> Are there any 'gotchas' when using xenomai from git, or do the 
>>> instructions and procedures for using a released version
>>> apply?
>> 
>> You can use kernel from the I-pipe git at: 
>> git://git.xenomai.org/ipipe.git branch ipipe-3.8
> 
> Thanks!  I wasn't sure if I could use one of the ipipe branches or
> if I still needed to use one of the personal branches.
> 
>> And xenomai from the xenomai 2.6 git at: 
>> git://git.xenomai.org/xenomai-2.6.git branch master
>> 
>> The only difference in the installation procedure when using this
>> kernel with this version of Xenomai is that the
>> "prepare-kernel.sh" script will not apply the I-pipe patch to the
>> kernel, since the kernel is already patched, so the argument to
>> the "--adeos" parameter of prepare-kernel.sh is ignored.
> 
> OK, stupid question:
> 
> I see the ipipe branch has the kernel source, but I need to apply
> the patches to a non-stock kernel (ie: a mainline 3.8.13 kernel
> patched with the BeagleBone patch set).  Is there a way to get the
> prepare-kernel.sh script and/or a patch set to apply to a mainline
> kernel out of the ipipe git branch?
> 
> Sorry if this is a total newbie question, but I see instructions
> for using the prepare-kernel.sh script on a kernel directory, and 
> instructions for using the ipipe kernel source directly, but not
> how to get from one to the other.
> 
You want the I-pipe patch. To generate it, in the I-pipe tree, try:

./scripts/ipipe/genpatches.sh

You should then find a file ipipe-core-3.8.13-arm-1.patch which you
can try and apply to another tree, possibly additionally patching with
pre and post patches (respectively before and after the I-pipe patch).

-- 
                                                                Gilles.

