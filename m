From: Lowell Gilbert <kludge@be-well.ilk.org>
References: <0CF46CB0-D92C-4DCE-B93F-4291374D8328@korgrd.com>
Date: Tue, 19 Dec 2017 13:27:23 -0500
In-Reply-To: <0CF46CB0-D92C-4DCE-B93F-4291374D8328@korgrd.com> (Steve Pavao's
 message of "Tue, 19 Dec 2017 11:51:00 -0500")
Message-ID: <44y3lywp2s.fsf@lowell-desk.lan>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Xenomai] Cobalt core and Yocto
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steve Pavao <stevep@korgrd.com>
Cc: xenomai@xenomai.org

Steve Pavao <stevep@korgrd.com> writes:

> Here are my recipes, which work fine, but Cobalt core does not boot.  I must need something else in my recipe(s).
>
> For I-PIPE Patch, my recipe file is linux-intel_4.9.bbappend:
>
> FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
> SRC_URI += "file://ipipe-core-4.9.51-x86-4.patch"

This gets you the interrupt pipeline, but not Xenomai itself.
That's the prepare-kernel.sh script, typically.

Be well.

