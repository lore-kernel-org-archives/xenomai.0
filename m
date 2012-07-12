Message-ID: <4FFE9477.5070002@xenomai.org>
Date: Thu, 12 Jul 2012 11:10:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4FFC89CA.70809@xenomai.org> <4FFDA171.3010201@nta-inc.net>
	<4FFDAF59.9010000@xenomai.org>
	<20120711174844.GG19565@csclub.uwaterloo.ca>
	<4FFE1841.1070409@xenomai.org> <4FFE8B7C.6090101@antcom.de>
In-Reply-To: <4FFE8B7C.6090101@antcom.de>
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
To: Roland Stigge <stigge@antcom.de>
Cc: xenomai@xenomai.org

On 07/12/2012 10:31 AM, Roland Stigge wrote:
> On 07/12/2012 02:20 AM, Gilles Chanteperdrix wrote:
>> The problem is that we use to have files in the /usr/share/xenomai
>> directory, the debian files were written with this assumption, we now no
>> longer install any file in /usr/share/xenomai, and we did not change the
>> debian files, simply because nobody tested the debian package
>> generation, or more accurately someone did but forgot to report the bug.
> 
> From the Debian perspective, the debian/ directory in "upstream" Xenomai
> is a bit confusing. At Debian, this one is ignored anyway and replaced
> with Debian's up-to-date variant.

We maintain our own debian directory for convenience, because we like
the idea of a self-contained package. But obviously this only makes
sense if this debian directory is maintained.

> 
> I unfortunately don't have the ressources to regularly sync/update
> debian/* in the xenomai.org dev repository.

I understand that. You already maintain a debian directory on your side,
you have absolutely no reason to maintain the debian directory of the
xenomai project.

Anyway, what I would like to know if people find useful the "feature" of
shipping with a debian directory.

> FYI: Unfortunate coincidence that the freeze for the next Debian release
> ("wheezy") was shortly before the Xenomai 2.6.1 release. So I'll be
> stuck with 2.6.0 for a while now.
> 
> Will put 2.6.1 into Debian "experimental", however, shortly.

Too bad. But maybe you could say that Debian uses Xenomai 2.6, and the
third version numbers are just security updates ;-) I am just half
kidding, after all, the policy is that all releases in the same branch
are binary compatibles.

-- 
					    Gilles.

