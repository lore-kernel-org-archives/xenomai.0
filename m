Message-ID: <0C53F2DBA565D411885300508B553B5204CCEAE8@domain.hid>
From: aaron durbin <aarondurbin@domain.hid>
Subject: RE: [Adeos-main] adeos porting
Date: Wed, 4 Aug 2004 11:03:58 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: "'rpm@xenomai.org'" <rpm@xenomai.org>
Cc: "'adeos-main@gna.org'" <adeos-main@gna.org>

>Do you target the 3.0, 3.1 or fusion (poised to become 4.0) branch?

Actually I am not totally sure at this point. It was my (mis?)understanding
that newer development on RTAI was using the ADEOS as its base interrupt
dispatcher. Fusion, I believe, is the new-new stuff (experimental), but I
thought the 3.x branches were the newer stable stuff.  Could you give me a
brief description on what they are and what direction they are going? I read
a little up on fusion and xenomai stuff on www.fdn.fr/~brouchou/rtai.   

Thanks again,
Aaron


-----Original Message-----
From: Philippe Gerum [mailto:rpm@xenomai.org]
Sent: Wednesday, August 04, 2004 9:36 AM
To: aaron durbin
Cc: 'adeos-main@gna.org'
Subject: Re: [Adeos-main] adeos porting


On Wed, 2004-08-04 at 15:35, aaron durbin wrote:
> Hi,
> 
> I am planning on porting ADEOS over to m68knommu (ColdFire based)
> architecture.  I have read the porting guidelines, however they are a
little
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
> The issue I am running into is that the version 2 core of ColdFire does
not
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

