Message-ID: <500FC093.4070905@xenomai.org>
Date: Wed, 25 Jul 2012 11:46:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F534D1A615F544D95E57BFD8460658301CBE3E3@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
In-Reply-To: <4F534D1A615F544D95E57BFD8460658301CBE3E3@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] accessing process' virtual memory areas from driver
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

On 07/24/2012 09:48 PM, Jorge Ramirez Ortiz, HCL Europe wrote:

> On a Xenomai multi-threaded application,  I need to access the
> process list of virtual memory areas in an rtdm driver. Since this
> region is protected by mmap_sem, I am unsure how to perform the
> access. Any guidance will be appreciated. thanks Jorge


>From real-time domain, you can not do it: the mmap_sem data may not be
in a coherent state, so do the vma list.

>From Linux domain, no problem, just take the mmap_sem.

-- 
                                                                Gilles.

