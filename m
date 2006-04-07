Message-ID: <443683A3.4000300@domain.hid>
Date: Fri, 07 Apr 2006 17:22:11 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [draft PATCH] nested enable/disable irq calls
References: <b647ffbd0604070805k32dc185fu4d3705906ffcbc2f@domain.hid>
In-Reply-To: <b647ffbd0604070805k32dc185fu4d3705906ffcbc2f@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

Dmitry Adamushko wrote:
> Hi,
> 
> yep, this is yet another draft patch which aims at supporting the
> nested irq disable/enable calls for the primary domain.
> 
> o  no changes on the adeos-ipipe layer, hence it's much cleaner and
> smaller that the one I have posted last time;
> 
> o  eliminates the need for XN_ISR_NOENABLE flag;
> 
> o  but is based on the presupposition (otherwise it's wrong) that for
> all acrhitectures that support Xenomai the following is true :
> 
> 	pic_handler->ack :
> 	    * mask
> 	    * eoi
> 	
> 	pic_handler->end :
> 	    * unmask
> 	
> Philippe told me some time ago that this is a _must_ now for any arch
> to be compatible with adeos-ipipe.
> 

Ack, but with the special exception of the timer IRQ on x86 which is not 
masked but only acked, since we can skip this while keeping the PIT 
happy, and acknowledging the PIC through the ISA bus is so sloooow...

> If so, with some minor cleanups (XN_ISR_NOENABLE should be removed all
> over the map,
> docs fixes, ...) and testing the patch may hopefully find its way into
> the codebase.
> 
> Any feedback? 	
> 
> TIA,
> 
> --
> Best regards,
> Dmitry Adamushko
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.

