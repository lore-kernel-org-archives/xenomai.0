Subject: Re: [Adeos-main] adeos porting
From: Philippe Gerum <rpm@xenomai.org>
Reply-To: rpm@xenomai.org
In-Reply-To: <0C53F2DBA565D411885300508B553B5204CCEAE7@domain.hid>
References: 
	 <0C53F2DBA565D411885300508B553B5204CCEAE7@domain.hid>
Content-Type: text/plain
Message-Id: <1091630137.618.42.camel@domain.hid>
Mime-Version: 1.0
Date: Wed, 04 Aug 2004 16:35:37 +0200
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
To: aaron durbin <aarondurbin@domain.hid>
Cc: "'adeos-main@gna.org'" <adeos-main@gna.org>

On Wed, 2004-08-04 at 15:35, aaron durbin wrote:
> Hi,
> 
> I am planning on porting ADEOS over to m68knommu (ColdFire based)
> architecture.  I have read the porting guidelines, however they are a little
> outdated. Currently I am using the recently released
> adeos-linux-2.6.7-i386-r6c6.patch patch for a basis. I was wondering if
> there was any more recent documentation on the API so I know exactly what
> calls should be performed in entry.S.

This one is pretty much in sync with the latest developments:
http://home.gna.org/adeos/doc/api/globals.html

This said, you cannot infer from that what's needed in entry.S. What you
need to do there is basically intercepting the hw IRQ masking/unmasking
and call the corresponding Adeos routines instead
(__adeos_stall/unstall_root), so that interrupts can go through the
pipeline when caught there too, even if the kernel won't receive them.

> 
> The issue I am running into is that the version 2 core of ColdFire does not
> have user/kernel stack support in hardware.  Therefore in entry.S needs to
> disable interrupts to make the stack switch atomic.  I was wondering if it
> would be sufficient to just stall the pipeline for linux at this point and
> make sure to unstall as apposed to disabling interrupts.
> 

Yes. Be careful with the register trashing though; calling the Adeos
pipeline controls might require a bit of tweaking in entry.S so that you
don't end up with a register mess upon return.

> My plans are to first port over ADEOS then go for RTAI.  The two coupled
> together look very promising, and I am hoping they will work as well for
> ColdFire as it does for x86.  
> 

Do you target the 3.0, 3.1 or fusion (poised to become 4.0) branch?

> Thanks for the help,
> Aaron Durbin 
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
-- 

Philippe.


