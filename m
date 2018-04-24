From: Steven Seeger <steven.seeger@nasa.gov>
Date: Tue, 24 Apr 2018 14:54:39 -0400
Message-ID: <2756112.fl8kL14NfF@wirbelwind>
In-Reply-To: <4715a857-f535-fe49-2506-5abbb16553ed@xenomai.org>
References: <mailman.27.1522680894.4366.xenomai@xenomai.org>
 <b2cbe5362c38461d9a2eb817b78fb633@EDB3.wapice.localdomain>
 <4715a857-f535-fe49-2506-5abbb16553ed@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: Adnan Ali <adnan.ali@wapice.com>, Sakari Junnila <sakari.junnila@wapice.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wednesday, April 25, 2018 12:49:53 PM EDT Philippe Gerum wrote:
> The fix makes a lot of sense, thanks. This bug slipped under the radar
> for years likely because enabling the ppc fpu in kernel context mainly
> happens when fixing up alignment issues, which rt apps tend to avoid in
> the first place for performance reason by only using aligned memory
> accesses (synchronous exceptions are not that cheap latency-wise).
> 
> Regarding the ipipe-4.9.y series, there are several other spots touching
> the msr in this file which may be affected the same way (vsx, altivec,
> spe, anything that involves calling msr_check_and_set/clear_msr() under
> hard masking basically).
> 
> Adding a dedicated irq_restore helper which does not touch any other bit
> aside of MSR_EE would make sense there. The BOOK-E version of
> irq_save/restore specifically uses the wrtee* instructions not to touch
> those bits, so we may assume this would be semantically correct to do
> the same for BOOK3-S.
> 
> PS: CCing Steven who took over the maintenance of the ppc pipeline from
> kernel 4.14 and on.

Hi guys. Thanks for pointing this out, Jouko. I've looked over this briefly 
and agree this is a pretty wide-spread problem. I will take a stab at it 
tomorrow.

Regards,
Steven




