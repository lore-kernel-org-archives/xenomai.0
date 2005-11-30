Message-ID: <438E1DCA.7070607@domain.hid>
Date: Wed, 30 Nov 2005 22:46:50 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [bug?] calling xnpod_delete_thread
	after	self-termination
References: <438E0807.6090000@domain.hid>
In-Reply-To: <438E0807.6090000@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi all,
> 
> as the subject already says: I face some warning of the nucleus (with
> XENO_OPT_DEBUG on - useful switch) when I call xnpod_delete_thread for a
> thread which has already terminated itself by leaving the thread
> function. Is this double-deletion illegal? Or is it a cleanup-bug of the
> nucleus?

We could test the XNZOMBIE bit in xnpod_delete_thread() to prevent this, 
I guess.

> 
> To reproduce: this happens with RTnet over all Xenomai versions (i.e.
> through the RTDM layer). I insert and remove the rtcfg module, and this
> one cleans up some kernel tasks - and the nucleus complains.
> 
> Jan
> 
> 
> PS: One open crash remaining on my list - likely RTnet-internal and
> uncritical. ;)
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

