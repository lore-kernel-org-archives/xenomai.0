Message-ID: <5144D524.4000302@web.de>
Date: Sat, 16 Mar 2013 21:25:08 +0100
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <5144D3E9.2050205@xenomai.org>
In-Reply-To: <5144D3E9.2050205@xenomai.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] __get_user/__put_user
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

On 2013-03-16 21:19, Gilles Chanteperdrix wrote:
> =

> Hi,
> =

> xenomai asm-generic/syscall.h defines __xn_put_user/__xn_get_user as
> aliases for __put_user/__get_user, which implementation, for the ARM
> architecture calls might_fault() which triggers an ipipe_root_only() chec=
k.
> =

> So, the question is, what is the best way of avoiding this issue? Remove
> the call to might_fault() when compiling with CONFIG_IPIPE enabled?
> Define __ipipe_safe_put_user which avoids the call to might_fault() ?

Adjust might_fault() in a way that it only considers atomic non-root
contexts as problematic.

Jan


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130316/3caec3c=
4/attachment.pgp>
