Message-ID: <44DB778A.5050004@domain.hid>
Date: Thu, 10 Aug 2006 14:14:34 -0400
From: Vincent Levesque <vleves@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [Xenomai-help] -110 error on rt_task_send...
	bug?
References: <44D7EDCF.9010409@domain.hid>	
	<b647ffbd0608090235o2868571ajbe74c0b09dd27282@domain.hid>	
	<b647ffbd0608090442q638115acw788da87969792cfb@domain.hid>	
	<200608091709.57319.schwab@domain.hid>
	<b647ffbd0608090842w6293eb37o94f4deaeb8a7310b@domain.hid>
In-Reply-To: <b647ffbd0608090842w6293eb37o94f4deaeb8a7310b@domain.hid>
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
To: xenomai@xenomai.org
Cc: andrewg@domain.hid

The patch works here too. Thanks for looking into this so quickly. I'll 
switch back to 2.1 until this is resolved.

Vincent Levesque
vleves@domain.hid

Dmitry Adamushko wrote:
>
>     > So could anyone test this patch and let me know if it works?
>     >
>     > Note : I haven't compiled it even as I don't have a proper
>     environment. But
>     > the changes are pretty simple so it should be ok.
>     I just did run the test program supplied by Vincent after applying
>     Your patch
>     (against 2.2.0)
>     It did work !
>
>
>
> That's good. Thanks for your assistance.
>
> So synch. message passing interface (IOW, rt_task_send/receive/reply) 
> is mgmglmgmm... slightly broken at the moment for all versions.
>
> The ones who need it may use this patch so far. I'll think a bit more 
> on it in the mean time but I tend to think that "Fixed Ownership" 
> (expressed by XNSYNCH_FOWNER) should really be a property of the 
> synch. object indeed (as in the current patch).
>
>
>
> > Only one small typo was in the patch, it is fixed in the attached patch
> > version.
>
> Ok, now I need to run diff -u old-patch new-patch to find out this typo :)
>
>  
> -- 
> Best regards,
> Dmitry Adamushko
>



