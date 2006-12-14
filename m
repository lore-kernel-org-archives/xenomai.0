Subject: Re: Antwort: [Xenomai-core] [PATCH] pSOS tm_-calls
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <OFB99D2CFA.75345C31-ONC1257244.005930E7@domain.hid>
References: <OFB99D2CFA.75345C31-ONC1257244.005930E7@domain.hid>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 18:20:37 +0100
Message-Id: <1166116837.23946.66.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Thomas Necker <Thomas.Necker@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Thu, 2006-12-14 at 18:13 +0100, Thomas Necker wrote:
> > Here come some patches that add the following functions to the pSOS 
> direct 
> > syscall interface:  tm_wkafter,  tm_cancel, tm_evafter, tm_get, tm_set
> 
> Yesterdays patches again in a different format that now (hopefully) can be 
> applied automatically.

That's fine now. Will review, thanks.

> 
> > - I'm still looking for a suitable place for k_fatal in user space. 
> > Instead of creating a new file I suggest to put it in init.c and 
> implement 
> > it as exit(1) for the moment until it's been decided about the mapping 
> to 
> > the kernel call.
> 
> I just did that now include in the patches: k_fatal (mapped to exit) is 
> contained in init.c .
> 
> Regards,
> Thomas
> 
> 
> 
> 
> 
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



