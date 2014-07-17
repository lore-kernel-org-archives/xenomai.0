Message-ID: <53C83323.7030508@xenomai.org>
Date: Thu, 17 Jul 2014 22:33:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <FEB36BE3-3DA6-4594-9064-213B66B059ED@gmail.com>
 <53C65420.6040608@xenomai.org>
 <0106E84F-4693-4A95-8219-298D9E932C17@gmail.com>
 <53C7A6FA.5000603@xenomai.org>
 <64BD7359-2A19-416C-8877-DEE2EB988EE6@gmail.com>
In-Reply-To: <64BD7359-2A19-416C-8877-DEE2EB988EE6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] modprobe cannot find RTDM kernel module during boot
 sequence
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Jaap Kempenaar <janjaapkempenaar@gmail.com>, xenomai@xenomai.org

On 07/17/2014 01:19 PM, Jan Jaap Kempenaar wrote:
>> On 07/17/2014 09:48 AM, Jan Jaap Kempenaar wrote:
>>> Hello,
>>> 
>>> Thank you for your reply.
>>> 
>>>> 
>>>> You should not use kernel 3.2.21, the I-piep patch is known to 
>>>> contain a bug. Please update to a more recent patch.
>>>> 
>>> 
>>> We are trying newer kernel versions, however have not been able
>>> yet to create one that runs the xeno-test stable.
>> 
>> What happens exactly?
>> 
> 
> The initial goal was to have a configuration with linux 3.8.13, and
> emdebian wheezy and to compile for armhf. Reason we chose for 3.8.13,
> is that it is the latest provided patch. Reason we want armhf is that
> on other setups we are running a linux 3.6.x configuration with
> wheezy armhf(without xenomai).

3.8 is not the latest patch for Xenomai 2.6.3, the latest patch is the
patch for 3.10.

The armhf debian packaging is broken in xenomai 2.6.3, you may want to
switch to Xenomai 2.6 git, which contains several fixes for Debian
packaging, including the one for this issue.

> 
> Several issues occur here. We use this guide as a reference for
> building the kernel and obtaining the file system: 
> http://wiki.gumstix.org/index.php?title=Installing_Debian_and_Xenomai_on_gumstix_Overo

This looks horribly complicated.

> 
We automated most of the steps with scripts.
> Several problems we have:
> 
> == Wheezy Xenomai userspace compilation:
> 
> ** The problem with Wheezy, both armhf and armel architectures is
> that we cannot build the debian packages as is suggested in the
> installation guide. When running the script with chroot to create the
> debian packages, the script fails. Based on the output of the script
> it goes wrong when it tries to write the udev rules, however I think
> that this might not be the problem(it complains that it cannot stat
> the xenomai.rules file as it does not exist).
> 
> For this particular issue I am working on a reproduce script which I
> will post to the mailing list. With that in mind, is there any
> additional information that would be useful to include with this?
> 
> ** Apart from trying to create debian packages with chroot, we also
> tried cross compiling which worked, however with this userspace,
> running xeno-test results in segmentation faults. I do not have
> traces or logs of this to post, we simply tried this because the
> creation of debian packages failed.

This probably comes from the fact that there is an ABI difference
between what you compiled and what was already on the target, for
instance using armhf on the target, and compiling Xenomai with the
softfp ABI. As a simple solution, if you make a root filesystem with a
toolchain, you can use the libraries (glibc, libstdc++) of the toolchain
on the filesystem. I understand this is not simple with a Debian
filesystem though.

> 
> ** Another thing we tried is to compile the userspace libraries on
> target. This also fails with the configure script, not being able to
> create a Makefile.

Do you have the log of this? Are you sure the user used to compile has
write access where you want the Makefile to be created?

-- 
                                                                Gilles.

