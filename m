References: <0CF46CB0-D92C-4DCE-B93F-4291374D8328@korgrd.com>
 <44y3lywp2s.fsf@lowell-desk.lan>
 <0DC99152-08CA-4152-BE75-CA0CE39D654F@korgrd.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d56f3f8e-44e0-be07-b832-bb84d93d4df7@siemens.com>
Date: Tue, 19 Dec 2017 20:24:42 +0100
MIME-Version: 1.0
In-Reply-To: <0DC99152-08CA-4152-BE75-CA0CE39D654F@korgrd.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Cobalt core and Yocto
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steve Pavao <stevep@korgrd.com>, Lowell Gilbert <kludge@be-well.ilk.org>
Cc: xenomai@xenomai.org

On 2017-12-19 19:49, Steve Pavao wrote:
> Hi Lowell,
> 
> Thanks for that tip.  That’s what I was thinking I might need to do.
> 
> I guess the solution in Yocto terms is to rework my I-PIPE patch recipe to not directly apply the I-PIPE patch, but rather to call prepare-kernel.sh and allow it to apply the patch, plus do the other things it needs to do.  I guess that should happen in a do_configure() {} block.

Actually, I would move the kernel patching out of the xenomai recipe and
rather have one recipe for the userspace packages and a
xenomai-kernel.inc which appends the kernel preparation task with the
prepare-kernel.sh invocation. It would also bring in (once again) the
xenomai sources so that its kernel elements get pulled into the kernel
build. In your kernel recipe, you would simply include that file.

This way, the kernel could come from various sources, including
git.xenomai.org/ipipe.git, and just needs to have the I-pipe patch
already applied, either in it git source or by adding a corresponding
patch to the custom kernel recipe.

This seems similar to how ELDK modeled this:
http://git.denx.de/?p=eldk.git;a=tree;f=meta-eldk/recipes-kernel/xenomai;h=bf965c6d2fa5132413b498161c90f337be8fb174;hb=refs/heads/5.8-eldk

That is outdated now, unfortunately. Do you plan to publish your layer
afterwards? I suppose some people would be happy about a meta-xenomai
with support for Xenomai 3.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

