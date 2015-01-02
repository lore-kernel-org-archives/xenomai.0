Message-ID: <54A672BA.8090209@web.de>
Date: Fri, 02 Jan 2015 11:28:10 +0100
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <mailman.787.1420134217.6101.xenomai-git@xenomai.org>
In-Reply-To: <mailman.787.1420134217.6101.xenomai-git@xenomai.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [Xenomai-git] Philippe Gerum: copperplate: add
 configuration tunable for registry moint point
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2015-01-01 18:43, xenomai-git-request@xenomai.org wrote:
> Module: xenomai-3
> Branch: next
> Commit: d351f712bc9b03d621b454b55fe3e46a0000294a
> URL:    http://git.xenomai.org/?p=3Dxenomai-3.git;a=3Dcommit;h=3Dd351f712=
bc9b03d621b454b55fe3e46a0000294a
> =

> Author: Philippe Gerum <rpm@xenomai.org>
> Date:   Thu Jan  1 18:15:36 2015 +0100
> =

> copperplate: add configuration tunable for registry moint point
> =

> --enable-registry[=3D/registry-mount-point]
> =

> Defaults to /mnt/xenomai.

Do we really have to leave this as default? Then at least the debian
rules must be fixed to use a FHS-conforming path for distributed packages.

Jan


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150102/b6cefdb=
b/attachment.sig>
