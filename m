Message-ID: <50F115E6.30209@web.de>
Date: Sat, 12 Jan 2013 08:51:02 +0100
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <50F05652.4000002@siemens.com> <50F0CCD6.80609@xenomai.org>
In-Reply-To: <50F0CCD6.80609@xenomai.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [PREVIEW] x86/ipipe queue for 3.5
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

On 2013-01-12 03:39, Gilles Chanteperdrix wrote:
> On 01/11/2013 07:13 PM, Jan Kiszka wrote:
> =

>>       x86/ipipe: Disallow transparent huge pages when I-pipe is active
>> # if you copy a distro .config, this can bite you... (we need to account=
 for THP later)
> =

> =

> What is wrong with transparent huge pages?

I didn't look at all details yet: we do not account for huge pages while
unCOW'ing e.g. Also, we once had THP enabled in some test setup and
quickly got crashes. Once understood, it's probably trivial to resolve.
But that needs to be done first. Huge page support is on our todo list.

Jan


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 261 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130112/3900fd1=
6/attachment.pgp>
