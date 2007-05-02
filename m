From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4630F1EA.8020206@domain.hid>
References: <4630F1EA.8020206@domain.hid>
Content-Type: text/plain
Date: Wed, 02 May 2007 11:15:53 +0200
Message-Id: <1178097353.5111.80.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH 0/7] I-pipe fixes, cleanups,
	and enhancements
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>, xenomai-core <xenomai@xenomai.org>

On Thu, 2007-04-26 at 20:39 +0200, Jan Kiszka wrote:

>  5. Extract minimal, dependency-free linux/ipipe_base.h from main
>     ipipe.h
> 
>  6. Optimise __ipipe_stall_root, __ipipe_test_root, and
>     __ipipe_test_and_stall_root for execution on UP (only i386 and
>     x86_64 so far). This should improve Linux performance over I-pipe,
>     at least it did with the original version I posted last year.
> 
>  7. Detect illicit cross-domain calls down the pipeline. Together with
>     the included Linux instrumentation, this can help to diagnose broken
>     RT code in the kernel, namely in drivers and skins. Might be of some
>     interest for RTDM hackers as recent user postings demonstrated...

Merged, thanks.

-- 
Philippe.



