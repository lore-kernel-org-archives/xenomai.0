MIME-Version: 1.0
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Mon, 4 Jun 2018 15:54:03 +0530
Message-ID: <CAOuPNLiWw7R9j75OvFWq6RAcwgiaGaOt_4Ep0hXOz-ZOMkrrww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] Applying arch specific ipipe patches - commit by commit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>, Greg Gallagher <greg@embeddedgreg.com>

Dear Greg,

I have one specific requirement regarding applying ipipe and xenomai
patches to our kernel.

I am using kernel version: 4.9.51.
I have all arch (x86, arm, arm64) changes in single kernel itself.

On this kernel I want to first apply "ipipe_4.9.51_x86" patches and
then in the same kernel I want to apply "ipipe_4.9.51_arm" and
"ipipe_4.9.51_arm64" patches.

I cannot do it because it may create several conflicts. It can contain
non-arch specific common changes that it will try to apply twice.

So, if you have any suggestions about applying the patches commit by
commit for each arch please let me know.
Or, if we can modify the prepare_kernel script to handle this case,
then that is also fine.

Currently, my idea is:
- First apply arch/x86 patches from ipipe-x86 kernel
- Then apply arch/arm patches from ipipe-arm kernel
- Then apply common patches between x86 and arm
- Then apply x86 specific non-arch patches
- Then apply arm specific non-arch patches
- Then resolve some of the conflicts

Do you think this process will work out easily?
Can I use prepare_kernel for the same?
If I have to apply commit by commit, how to decide which commit to start with?

If you have any better method please let me know.

Thanks,
Pintu

