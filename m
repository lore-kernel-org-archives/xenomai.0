MIME-Version: 1.0
In-Reply-To: <4e64e78c-0b25-c6e6-90cb-f48c7cdd5051@xenomai.org>
References: <CAOuPNLiWw7R9j75OvFWq6RAcwgiaGaOt_4Ep0hXOz-ZOMkrrww@mail.gmail.com>
 <4e64e78c-0b25-c6e6-90cb-f48c7cdd5051@xenomai.org>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Tue, 5 Jun 2018 18:34:44 +0530
Message-ID: <CAOuPNLgw8NurkqsMUK49NTKiLx1YqidQZ=i7vMMpF=Nxu1ZROg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] Applying arch specific ipipe patches - commit by
	commit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Dear Philippe,

Thank you so much for your reply.
Yes, I already cloned the common ipipe.git and looked into it.

I tried to do the following:
1) git clone https://git.xenomai.org/ipipe.git
2) git checkout ipipe-4.9.y  => I think it points to 4.9.92
    [But I need only 4.9.51]

3) cd ipipe

4) ./scripts/ipipe/genpatches.sh --split
reference: v4.9.92, kernel version: 4.9.92
fatal: ambiguous argument 'v4.9.92': unknown revision or path not in
the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
ipipe-core-4.9.92-noarch.patch
rm: missing operand
Try 'rm --help' for more information.


I get the above error, when I run this script.
I am not sure what does it indicates.
I wanted all arch patches only for kernel 4.9.51
How to use this script to generate that?

If you have any suggestions please help!

Thanks,
Pintu


On Tue, Jun 5, 2018 at 5:55 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 06/04/2018 12:24 PM, Pintu Kumar wrote:
>> Dear Greg,
>>
>> I have one specific requirement regarding applying ipipe and xenomai
>> patches to our kernel.
>>
>> I am using kernel version: 4.9.51> I have all arch (x86, arm, arm64) changes in single kernel itself.
>>
>> On this kernel I want to first apply "ipipe_4.9.51_x86" patches and
>> then in the same kernel I want to apply "ipipe_4.9.51_arm" and
>> "ipipe_4.9.51_arm64" patches.
>>
>> I cannot do it because it may create several conflicts. It can contain
>> non-arch specific common changes that it will try to apply twice.
>>
>
> The tree at [1] precisely provides such integrated combo with all the
> supported archs. All patches are extracted from it. Rebasing your code
> on top of that tree would spare you those issues.
>
>> So, if you have any suggestions about applying the patches commit by
>> commit for each arch please let me know.
>> Or, if we can modify the prepare_kernel script to handle this case,
>> then that is also fine.
>>
>> Currently, my idea is:
>> - First apply arch/x86 patches from ipipe-x86 kernel
>> - Then apply arch/arm patches from ipipe-arm kernel
>> - Then apply common patches between x86 and arm
>> - Then apply x86 specific non-arch patches
>> - Then apply arm specific non-arch patches
>> - Then resolve some of the conflicts
>>
>> Do you think this process will work out easily?
>> Can I use prepare_kernel for the same?
>> If I have to apply commit by commit, how to decide which commit to start with?
>>
>> If you have any better method please let me know.
>>
>
> Try this from the cloned top level directory of [1]:
>
> $ ./scripts/ipipe/genpatches.sh --split
>
> This is another way of getting the noarch and arch-specific bits of the
> I-pipe separately. If the script aborts in error, just pick the script
> from the latest I-pipe version in the series (e.g. 4.9.92 for the 4.9
> series).
>
> [1] git://git.xenomai.org/ipipe.git
>
> --
> Philippe.

