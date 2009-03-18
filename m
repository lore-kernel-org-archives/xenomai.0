Message-ID: <49C13179.5060108@domain.hid>
Date: Wed, 18 Mar 2009 18:38:01 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1237393895.5495.7.camel@domain.hid>
	<1237395895.3441.6.camel@domain.hid>
In-Reply-To: <1237395895.3441.6.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Kernel crash
	in	xnheap_test_and_free	(native/heap.c)
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
To: Andreas Glatz <andreasglatz@domain.hid>
Cc: xenomai@xenomai.org

Andreas Glatz wrote:
> The last source code I sent is outdated.
> 
> The newest version with a sighandler for SIGINT is attached here.
>

Confirmed, it's perfectly reproducible here as well. Will dig this. Thanks for 
reporting.

> Sorry for that,
> 
> Andreas
> 
> 
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

