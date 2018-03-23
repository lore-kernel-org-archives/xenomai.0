Date: Fri, 23 Mar 2018 14:44:23 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20180323144423.07559e5f@mmd1pvb1c.ad001.siemens.net>
In-Reply-To: <CAOuPNLhfiTB7cXcs45yDMGceHzHc_Zvuv0Vx335Of9uPJb=W6g@mail.gmail.com>
References: <CAOuPNLhfiTB7cXcs45yDMGceHzHc_Zvuv0Vx335Of9uPJb=W6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Upgrading xenomai-3 patches in existing xenomai kernel
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

Am Fri, 23 Mar 2018 19:06:30 +0530
schrieb Pintu Kumar <pintu.ping@gmail.com>:

> Hi,
> 
> I just came across a situation about Xenomai upgrade, and wanted to
> know your opinion.
> 
> Some 4 months back, I applied Xenomai-3 (and ipipe) patches to my x86
> kernel 4.9.51, using the prepare_kernel script, and I am using it
> since then.

You will need an ipipe-enabled kernel anyways. Prepare kernel will just
install the xenomai-bits.
If you do not want to use an ipipe-kernel from upstream you can
rebase/merge the ipipe branch (in your case 4.9.y) onto/into your
kernel. All that should be under version control. Prepare-kernel is a
build step and should be done on a clean working copy when building.

Henning

> But, now I wanted to upgrade to latest Xenomai kernel patches from
> Xenomai-3 git.
> Can I simply cherrypick the patches from Xenomai and apply to my
> Kernel ? I guess the folder structures are different, so I guess it
> may not work cleanly.
> 
> So, what is the best way to apply the latest Xenomai Kernel patches,
> on to existing Xenomai converted kernel repo, without disturbing the
> previously applied patches ?
> 
> If there is any standard procedure you follow, please let me know.
> 
> 
> Thanks,
> Pintu
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


