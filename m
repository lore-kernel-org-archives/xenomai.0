Message-ID: <4CACA464.5040804@domain.hid>
Date: Wed, 06 Oct 2010 18:31:32 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4CAC65FA.70506@domain.hid> <4CAC84CB.7020701@domain.hid>
	<4CAC869E.1010503@domain.hid> <4CAC9E63.7090407@domain.hid>
In-Reply-To: <4CAC9E63.7090407@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [announce] Xenomai v2.5.5
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai@xenomai.org

Stefan Kisdaroczi wrote:
> On 06.10.2010 16:24, Gilles Chanteperdrix wrote:
>> Stefan Kisdaroczi wrote:
>>   
>>> Hi Gilles,
>>>
>>> On 06.10.2010 14:05, Gilles Chanteperdrix wrote:
>>>     
>>>> [...]
>>>> - the debian patch generation script, which caused invalid patches to be
>>>> generated for recent kernel releases
>>>>   
>>>>       
>>> The file scripts/prepare-patch.sh is missing in the
>>> xenomai-2.5.5.tar.bz2 archive.
>>>     
>> I do not see it in scripts/Makefile.am EXTRA_DIST. Did I miss some part
>> of your patch?
>>   
> 
> No. I missed that in the patch, I just moved the file from debian/ to
> scripts/.
> 
> Sorry, but a stupid guy like me simply does not understand why a script
> in a git tree needs to be put in a Makefile.am so that it gets put in a
> archive from that tree.
> 
> If I do "git archive v2.5.5 | bzip2 > ..." it works. The only difference
> between the archives is the inclusion of the 3 pdf's in the doc/nodist
> dir and the 3 small scripts in scripts/maint directory (and
> prepare-patch.sh). The pdf's could be put out of the tree, but simple
> solutions and workflows are probably just for stupid people like me.

We use "make distcheck" which is the standard way of making a package
based on the autotools, and has been the way we have made Xenomai
package since day 1.

"make distcheck" checks that the package compilation works.

It ensures that users of the Xenomai package can regenerate a new
package from the sources we provide.

And it does not look that much more complicated than the pipeline using
git archive.

Anyway, I will add it, but I will wait a bit to re-generate a 2.5.5.1 in
order to see if we have no other issue.

-- 
					    Gilles.

