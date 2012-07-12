Message-ID: <4FFE8B7C.6090101@antcom.de>
Date: Thu, 12 Jul 2012 10:31:56 +0200
From: Roland Stigge <stigge@antcom.de>
MIME-Version: 1.0
References: <4FFC89CA.70809@xenomai.org> <4FFDA171.3010201@nta-inc.net>
	<4FFDAF59.9010000@xenomai.org>
	<20120711174844.GG19565@csclub.uwaterloo.ca>
	<4FFE1841.1070409@xenomai.org>
In-Reply-To: <4FFE1841.1070409@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Debian packaging bug in Xenomai v2.6.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 07/12/2012 02:20 AM, Gilles Chanteperdrix wrote:
> The problem is that we use to have files in the /usr/share/xenomai
> directory, the debian files were written with this assumption, we now no
> longer install any file in /usr/share/xenomai, and we did not change the
> debian files, simply because nobody tested the debian package
> generation, or more accurately someone did but forgot to report the bug.

>From the Debian perspective, the debian/ directory in "upstream" Xenomai
is a bit confusing. At Debian, this one is ignored anyway and replaced
with Debian's up-to-date variant.

I unfortunately don't have the ressources to regularly sync/update
debian/* in the xenomai.org dev repository.

FYI: Unfortunate coincidence that the freeze for the next Debian release
("wheezy") was shortly before the Xenomai 2.6.1 release. So I'll be
stuck with 2.6.0 for a while now.

Will put 2.6.1 into Debian "experimental", however, shortly.

Roland

