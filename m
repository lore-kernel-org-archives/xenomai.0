Message-ID: <4D270DF8.4020802@domain.hid>
Date: Fri, 07 Jan 2011 13:58:32 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <515034A5-8E42-4ACC-B08E-FC8A05DEB293@domain.hid>	<1287218938.1854.11.camel@domain.hid>	<A059C858-912A-4207-A834-411C50184622@domain.hid>	<1294236456.1828.3.camel@domain.hid>	<B531163E-B46F-465A-8970-13BC59A61496@domain.hid>	<1294242791.1828.6.camel@domain.hid>
	<B177BAEC-ED02-40F8-9057-AF7445A6F321@domain.hid>
In-Reply-To: <B177BAEC-ED02-40F8-9057-AF7445A6F321@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] hanging in Xenomai 2.5.5
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stefan Schaal <sschaal@domain.hid>
Cc: xenomai@xenomai.org

Stefan Schaal wrote:
> Hi Philippe,
> 
> thanks a lot for the hint. I configured my kernel from scratch, and
> got rid of the linux compile problems. I could thus verify that the
> commit you mentioned below DOES NOT have the problem I described,
> i.e., semaphores used by multiple processes which are running on
> different cores DID NOT hang anymore.
> 
> Then, I thought I try to bisect the problem with git, and I pulled
> the latest version of the 2.5 repository. Interestingly, with the
> very latest commits, my problem has gone away. I confirmed this by
> switching back to Alexis' analogy branch, which I need for my
> development. This branch is not quite as up-to-date as the 2.5
> branch, and the hanging problem still exists. I merged the analogy
> branch with the latest 2.5 branch, and now nothing hangs anymore.
> 
> I guess, I stop investigating at this point, unless the problem
> re-apprears.

2.5.6 should be out soon, which should allow you to avoid doing this.

But in the mean-time, you can probably merge the two branches, they
should be fairly orthogonal.

-- 
					    Gilles.

