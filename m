From: Philippe Gerum <rpm@xenomai.org>
References: <CAOuPNLiWw7R9j75OvFWq6RAcwgiaGaOt_4Ep0hXOz-ZOMkrrww@mail.gmail.com>
Message-ID: <4e64e78c-0b25-c6e6-90cb-f48c7cdd5051@xenomai.org>
Date: Tue, 5 Jun 2018 14:25:02 +0200
MIME-Version: 1.0
In-Reply-To: <CAOuPNLiWw7R9j75OvFWq6RAcwgiaGaOt_4Ep0hXOz-ZOMkrrww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Applying arch specific ipipe patches - commit by commit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pintu Kumar <pintu.ping@gmail.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>, Greg Gallagher <greg@embeddedgreg.com>

On 06/04/2018 12:24 PM, Pintu Kumar wrote:
> Dear Greg,
> 
> I have one specific requirement regarding applying ipipe and xenomai
> patches to our kernel.
> 
> I am using kernel version: 4.9.51> I have all arch (x86, arm, arm64) changes in single kernel itself.
> 
> On this kernel I want to first apply "ipipe_4.9.51_x86" patches and
> then in the same kernel I want to apply "ipipe_4.9.51_arm" and
> "ipipe_4.9.51_arm64" patches.
> 
> I cannot do it because it may create several conflicts. It can contain
> non-arch specific common changes that it will try to apply twice.
> 

The tree at [1] precisely provides such integrated combo with all the
supported archs. All patches are extracted from it. Rebasing your code
on top of that tree would spare you those issues.

> So, if you have any suggestions about applying the patches commit by
> commit for each arch please let me know.
> Or, if we can modify the prepare_kernel script to handle this case,
> then that is also fine.
> 
> Currently, my idea is:
> - First apply arch/x86 patches from ipipe-x86 kernel
> - Then apply arch/arm patches from ipipe-arm kernel
> - Then apply common patches between x86 and arm
> - Then apply x86 specific non-arch patches
> - Then apply arm specific non-arch patches
> - Then resolve some of the conflicts
> 
> Do you think this process will work out easily?
> Can I use prepare_kernel for the same?
> If I have to apply commit by commit, how to decide which commit to start with?
> 
> If you have any better method please let me know.
> 

Try this from the cloned top level directory of [1]:

$ ./scripts/ipipe/genpatches.sh --split

This is another way of getting the noarch and arch-specific bits of the
I-pipe separately. If the script aborts in error, just pick the script
from the latest I-pipe version in the series (e.g. 4.9.92 for the 4.9
series).

[1] git://git.xenomai.org/ipipe.git

-- 
Philippe.

