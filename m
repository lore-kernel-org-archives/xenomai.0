Message-ID: <4586A820.3040509@domain.hid>
Date: Mon, 18 Dec 2006 15:39:28 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: AW: [Xenomai-help] prepare kernel fails
References: <5D63919D95F87E4D9D34FF7748CE2C2A6F92C7@domain.hid>
	<4586A0E6.6060608@domain.hid>
In-Reply-To: <4586A0E6.6060608@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Roderik_Wildenburg@domain.hid, xenomai@xenomai.org

Jan Kiszka wrote:
> @all: please give the -rc3 tar.bz2 hell! New files can easily slip
> through the developer fingers when it comes to distribution (I know this
> very well /wrt RTnet...).

The way around this is to run automated scripts using the result of a
make distcheck instead of using an svn checkout. Niklaus, how hard would
it be to change the buildbot to do this ?

-- 
                                                 Gilles Chanteperdrix

