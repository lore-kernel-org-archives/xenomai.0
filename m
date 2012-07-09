Message-ID: <4FFB1CB7.7020209@xenomai.org>
Date: Mon, 09 Jul 2012 20:02:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F534D1A615F544D95E57BFD8460658302ED62BD@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>,
	<4FFB18F7.4070002@xenomai.org>
	<4F534D1A615F544D95E57BFD8460658301CBE39A@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
In-Reply-To: <4F534D1A615F544D95E57BFD8460658301CBE39A@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] shared memory segments
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Jorge Ramirez Ortiz, HCL Europe" <Jorge.Ramirez-Ortiz@hcl.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/09/2012 07:55 PM, Jorge Ramirez Ortiz, HCL Europe wrote:
> hi Gilles Not sure I understand now. Let's say that I also need to
> place a mutex on that shared region to be shared between other
> Xenomai applications. The mutex would obviusly be wrapped by the
> posix skin but not the system5 shared request. Would that work?? 
> thanks for all the help

Yes, it should work. What is hard to get right however is synchronizing
the various processes accessing the shared region so that
pthread_mutex_init is called once and only once.

-- 
                                                                Gilles.

