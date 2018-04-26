References: <CAOuPNLg60S+am654fq55vTMoFV1=PfMp3as5MZtt5BHUacFRBQ@mail.gmail.com>
 <2ee8fa04-7ad4-58d5-603b-1d41ad2533ec@siemens.com>
 <CAOuPNLiE-Fy3LJrozgsLE9ga0ibC+GOSHO6ciJppU_bnZtbx0g@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <73a5c9f6-5014-5113-1ddd-2fcf974273bb@siemens.com>
Date: Thu, 26 Apr 2018 18:23:05 +0200
MIME-Version: 1.0
In-Reply-To: <CAOuPNLiE-Fy3LJrozgsLE9ga0ibC+GOSHO6ciJppU_bnZtbx0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Kernel oops during rtnet loopback usage on x86_64
	(e1000e)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pintu Kumar <pintu.ping@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 2018-04-25 13:36, Pintu Kumar wrote:
> Dear Jan,
> 
> Thank you so much for your reply.
> I will try the latest stable version to check again.
> Is ipipe patches (linux: 4.9.51) also needs to be upgraded for this
> issue? Or only xenomai-3/kernel patches are enough?

This particular issue was addressed in the Xenomai core, not the I-pipe
patch.

> 
> Actually, now I am stuck with another question.
> Hope if you could help me.
> 
> As I said, I applied xenomai-3.0.6, kernel patches (using
> prepare_kernel script) to my x86_64 kernel, around 4 months back.
> I am using it since then. After that I never upgraded any patches.
> 
> Now my concern is, how do I apply/upgrade only the latest patches?
> I did not remember the last commit until which I applied the patches.
> 
> Is prepare_kernel script in intelligent enough to find the patch
> difference, and apply on the latest patches ?
> 
> Normally how you people upgrade to the latest xenomai patches.
> If you have any suggestions, please guide me.

Well, best practice is versioning control and build automation. You can
pull the patch into your local kernel or use the i-pipe kernel git tree
as feed (if you have no own patches). Then you just need
prepare-kernel.sh to refresh the xenomai core.

And building everything can also be automated by scripts or more
advanced systems that also track the source revisions for you. Can be
git, can be something like yocto, buildroot etc.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

