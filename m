Subject: Re: [Adeos-main] what should __adeos_set_timer(hz) do?
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200406291242.32834.maillist@domain.hid>
References: <200406291242.32834.maillist@domain.hid>
Content-Type: text/plain
Message-Id: <1088507709.636.14.camel@domain.hid>
Mime-Version: 1.0
Date: Tue, 29 Jun 2004 13:15:09 +0200
Content-Transfer-Encoding: 7bit
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: Thomas Kuhlmann <maillist@domain.hid>
Cc: adeos-main@gna.org

On Tue, 2004-06-29 at 12:42, Thomas Kuhlmann wrote:
> Hello,
> 
> based on the adeos-linux-2.4.22-armnommu-r12.patch for uClinux 2.4.22-uc0 from 
> http://download.gna.org/adeos/patches/v2.4/armnommu/ I'm trying to extend 
> (port) this patch for armnommu/arch-netarm/ (NetSilicon NS7520 processor).
> 
> Has anybody tried a patch for armnommu/arch-netarm (just to prevent me doing 
> it again)?
> 
> The function __adeos_set_time(unsigned long hz) has to be ported to netarm. 
> However what should it do?
> In the given patch for the armnommu/arch-atmel/ it looks like the kernel timer 
> is disabled, the frequency is changed, and the timer is enabled again (not 
> one shot, but periodic mode). Is this the correct semantics of 
> __adeos_set_timer(hz)?
> 

Strictly speaking, setting the hw timer in periodic mode is not required
by Adeos. __adeos_set_timer() is a helper for the adeos_tune_timer()
service that is expected to set the Linux timer hw to a given frequency.
This helper is totally ARM-dependent and does not even exist for other
archs.

> Sorry if my question is misplaced here and I'd better contact the ARM 
> responsible persons (let me know of this).
> 

Your question indeed belongs to this list. Maybe the ARM guru (who I'm
not) is listening?

> Thanks, Thomas.
-- 

Philippe.


