Message-ID: <4FFB2320.2050506@xenomai.org>
Date: Mon, 09 Jul 2012 20:29:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F534D1A615F544D95E57BFD8460658302ED62BD@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>,
	<4FFB18F7.4070002@xenomai.org>
	<4F534D1A615F544D95E57BFD8460658301CBE39A@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>,
	<4FFB1CB7.7020209@xenomai.org>
	<4F534D1A615F544D95E57BFD8460658301CBE39C@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
In-Reply-To: <4F534D1A615F544D95E57BFD8460658301CBE39C@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
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

On 07/09/2012 08:19 PM, Jorge Ramirez Ortiz, HCL Europe wrote:
> I can create an extra shared region in the library of sizeof(int)
> opened with exclusive access to behave as a lock to the mutex
> initialization I suppose. ah another question, will I have to
> mlock_all the library?

You have to mlockall the process memory before calling xenomai services,
yes.

-- 
                                                                Gilles.

