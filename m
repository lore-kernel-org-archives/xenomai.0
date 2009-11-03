From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20091103133407.GA9836@domain.hid>
References: <20091103133407.GA9836@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 03 Nov 2009 15:44:24 +0100
Message-ID: <1257259464.2210.32.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai core] Freeze on MPC8572 and P2020 with
 SMP
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Richard Cochran <richardcochran@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2009-11-03 at 14:34 +0100, Richard Cochran wrote:
> I have compiled and run ipipe-2.6.30.3-powerpc-2.7-02 and Xenomai
> v2.4.9.1 (well, actually c4c3c82791951df998ac4dc463f79a76884577b6), on
> two similar Freescale boards, the MPC8572DS and the P2020DS. Both are
> dual core, and both run fine using vanilla Linux 2.6.30 with SMP.
> 
> If I enable ipipe only, I can still boot SMP. If Xenomai is enabled,
> then the machine freezes as soon as Xenomai is started. (As a module,
> Xenomai locks the machine when loading).

Did you try enabling the pipeline debug options, like
CONFIG_IPIPE_DEBUG_CONTEXT and CONFIG_IPIPE_DEBUG_INTERNAL?

> 
> Without SMP, it seems to run fine (and latency numbers are excellent!)
> 
> I seem to recall having seen that Xenomai SMP was working on some
> other Freescale powerpc chips. Looking for any advice...

Xenomai runs on Emerson's mvme7100 powered by a 8641D, but FSL eval
boards which are known to work with Xenomai are uniprocessor only so
far. SMP-wise, PA-Semi's PA6T (ppc64) and Emerson's mvme7100 (ppc32) are
known to work, but I can't tell for any other hw.

> 
> Thanks,
> 
> Richard
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 
Philippe.



