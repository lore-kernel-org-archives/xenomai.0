Message-ID: <50F297D1.2090800@web.de>
Date: Sun, 13 Jan 2013 12:17:37 +0100
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <50ED750B.4010606@siemens.com> <50F19966.9050008@xenomai.org>
In-Reply-To: <50F19966.9050008@xenomai.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [PATCH] prepare-kernel: Only purge links from target
	directories
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2013-01-12 18:12, Gilles Chanteperdrix wrote:
> On 01/09/2013 02:47 PM, Jan Kiszka wrote:
> =

>> Only remove files from the target directory of patch_link if they are
>> missing in Xenomai AND are actually symbolic links. This is required
>> when merging Xenomai directories into non-empty kernel dirs.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> This is not required for the current patch workload but helps us in 2.6
>> with integrating ftrace (we patch into include/trace/events there).
>> Would reduce our queue length by one if this could be merged
>> nevertheless.
> =

> =

> Despite the fact that it is a one-liner, I do not understand what this
> patch does, and I am not sure it is not going to break things.

One way to install Xenomai into a kernel source tree is by adding
symbolic links to the individual source files. In preparation of this
step, the prepare-kernel script first purges all files from affected
directories that are not present in the Xenomai sources (anymore). That
works fine for our current Xenomai dirs as they are exclusively used but
fails once we have to patch dirs that are also used by the original
kernel (like the cited trace event dir).

This patch addresses the issue by only purging symbolic links, not
regular files. We will also need it in forge once we add ftrace support
over there.

HTH,
Jan

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 261 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130113/ffd0ce1=
3/attachment.pgp>
