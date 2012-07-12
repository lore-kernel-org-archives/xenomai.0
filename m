Message-ID: <4FFEE9E8.2040008@nta-inc.net>
Date: Thu, 12 Jul 2012 10:14:48 -0500
From: Jeff Webb <jeff.webb@nta-inc.net>
MIME-Version: 1.0
References: <4FFC89CA.70809@xenomai.org> <4FFDA171.3010201@nta-inc.net>
	<4FFDAF59.9010000@xenomai.org>
	<20120711174844.GG19565@csclub.uwaterloo.ca>
	<4FFE1841.1070409@xenomai.org> <4FFE8B7C.6090101@antcom.de>
	<4FFE9477.5070002@xenomai.org>
In-Reply-To: <4FFE9477.5070002@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: xenomai@xenomai.org

On 07/12/2012 04:10 AM, Gilles Chanteperdrix wrote:
> On 07/12/2012 10:31 AM, Roland Stigge wrote:
>> On 07/12/2012 02:20 AM, Gilles Chanteperdrix wrote:
>>> The problem is that we use to have files in the /usr/share/xenomai
>>> directory, the debian files were written with this assumption, we now no
>>> longer install any file in /usr/share/xenomai, and we did not change the
>>> debian files, simply because nobody tested the debian package
>>> generation, or more accurately someone did but forgot to report the bug.
>>
>>  From the Debian perspective, the debian/ directory in "upstream" Xenomai
>> is a bit confusing. At Debian, this one is ignored anyway and replaced
>> with Debian's up-to-date variant.
>
> We maintain our own debian directory for convenience, because we like
> the idea of a self-contained package. But obviously this only makes
> sense if this debian directory is maintained.
>
>>
>> I unfortunately don't have the ressources to regularly sync/update
>> debian/* in the xenomai.org dev repository.

Do you have the resources to update debian/* on xenomai.org just before 
each release is made?  I don't think it's necessary to update it any 
more often than that.  I'm assuming that you eventually package each 
release anyway, so it would be nice to do it before a release is made 
official.  Of course, if you don't have time for that or your 
availability doesn't line up with the timeframe for a release, that is 
understandable.  I am just asking if the problem is trying to keep the 
git repository up to date all the time, or if you don't even have time 
to do it for each release.

> I understand that. You already maintain a debian directory on your side,
> you have absolutely no reason to maintain the debian directory of the
> xenomai project.
>
> Anyway, what I would like to know if people find useful the "feature" of
> shipping with a debian directory.

I find it useful, and have not had any trouble with it not working 
before.  That being said, I wouldn't object to getting the debian 
directory from another location, as long as the information at:

  http://www.xenomai.org/index.php/Building_Debian_packages

is updated with detailed instructions on exactly how to download, 
extract, and graft the appropriate debian directory into a xenomai 
source tree that was created from a release tarball or git repository.

Thank you for providing a mechanism to easily build debian packages.  I 
find it very valuable for many reasons.

