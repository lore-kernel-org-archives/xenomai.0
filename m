Message-ID: <4587A7F5.4030602@domain.hid>
Date: Tue, 19 Dec 2006 09:51:01 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: AW: [Xenomai-help] prepare kernel fails
References: <5D63919D95F87E4D9D34FF7748CE2C2A6F92C7@domain.hid>	
	<4586A0E6.6060608@domain.hid> <4586A820.3040509@domain.hid>
	<1166473522.17298.13.camel@domain.hid>
In-Reply-To: <1166473522.17298.13.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: Roderik_Wildenburg@domain.hid, xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Philippe Gerum wrote:
> On Mon, 2006-12-18 at 15:39 +0100, Gilles Chanteperdrix wrote:
> 
>>Jan Kiszka wrote:
>>
>>>@all: please give the -rc3 tar.bz2 hell! New files can easily slip
>>>through the developer fingers when it comes to distribution (I know this
>>>very well /wrt RTnet...).
>>
>>The way around this is to run automated scripts using the result of a
>>make distcheck instead of using an svn checkout. Niklaus, how hard would
>>it be to change the buildbot to do this ?
>>
> 
> 
> Make distcheck did not choke on the issue, that's precisely the problem.
> It does not try to prepare a kernel for patching.
> 

Make distcheck would not choke, but the error would be caught if the
buildbot script used the contents of the generated tarball instead of
using an svn checkout.

-- 
                                                 Gilles Chanteperdrix

