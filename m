Message-ID: <490869D4.8040506@domain.hid>
Date: Wed, 29 Oct 2008 14:49:08 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <49083C20.6060306@domain.hid>
In-Reply-To: <49083C20.6060306@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] rtdm_mmap_to_user() remapping problem on powerpc
 arch.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Matteo Facchinetti @ Sirius Electronic Systems S.R.L." <matteo.facchinetti@domain.hid>
Cc: xenomai@xenomai.org

Matteo Facchinetti @ Sirius Electronic Systems S.R.L. wrote:
> Hi all,
> 
> I'm using framework RTDM to develop my driver on embedded system mpc5200 
> based.
> (kernel 2.6.24.4 (powerpc arch) - xenomai 2.4.3).
> 
> I've need to use rtdm_mmap_to_user() to share a kmalloc() kernel memory 
> in userspace.
> For this, I'm using the example in  
> http://www.captain.at/xenomai-real-time-driver-example.php.
> 
> Running a similar example I've discovered a problem in kmalloc remapping.
> The only way that I've found, to make remapping correctly, is to 
> allocate an entire kernel mem page with __get_freepage() instead of 
> kmalloc().
> 
> I think that could be a bug in powerpc arch.
> what do you think about?

There are two known problems with memory mapping:
- one when using high memory (more than 1GB RAM), for which a proposed
fix is here:
https://mail.gna.org/public/xenomai-core/2008-09/msg00118.html
- one specifically on power pc, fixed here:
https://mail.gna.org/public/xenomai-help/2008-10/msg00096.html

-- 
                                                 Gilles.

