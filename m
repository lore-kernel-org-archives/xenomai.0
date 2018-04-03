From: Steven Seeger <steven.seeger@nasa.gov>
Date: Tue, 3 Apr 2018 09:57:52 -0400
Message-ID: <8214382.neGrAg1Q7R@wirbelwind>
In-Reply-To: <mailman.27.1522680894.4366.xenomai@xenomai.org>
References: <mailman.27.1522680894.4366.xenomai@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"
Subject: Re: [Xenomai] Unrecoverable FP Unavailable Exception 801
Reply-To: steven.seeger@nasa.gov
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On Monday, April 2, 2018 10:54:54 AM EDT Sagi Maimon <SMaimon@advaoptical.com> 
wrote:

> Hi all,
> I am working with: Powerpc e300 SOC.
> I am using: xenomai-2.6.4 version
> 
> I am experiencing this exception on my Linux :
> Unrecoverable FP Unavailable Exception 801 at c0003858
> Oops: Unrecoverable FP Unavailable Exception, sig: 6 [#1]
> 
> This happens during "alignment exception" (600)

I'm a little curious about the fact that the address this occurred at is 
0xc0003858, which suggests it's kernel code. As Philippe asked, what version 
of the ipipe are you using? Also, what is your exact CPU? The e300c2 does not 
have an FPU, so this would be quite a configuration problem.

Are you using any kernel threads that use the FPU?

Steven




