From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <3FF315C710820E47A04E55C6F7D9B0AD78FAF5@domain.hid>
References: <3FF315C710820E47A04E55C6F7D9B0AD78FAF5@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 01 Jun 2011 14:09:08 +0200
Message-ID: <1306930148.2118.45.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai latency measurements
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roderik.wildenburg@domain.hid
Cc: xenomai@xenomai.org

On Wed, 2011-06-01 at 13:14 +0200, roderik.wildenburg@domain.hid
wrote:
> I performed some measurements with the Xenomai latency test.
> In case somebody is interested I attached the results for our PPC-System
> (5200B 400MHZ).
> In this document I also compared latencies of kernel 2.4 with kernel
> 2.6.
> Any comments are welcome, especially whether the values I measured are
> reasonable for a 400MHZ PPC.
> 

Yes, they look like ok but the CPU frequency is not what makes the
difference, the performance of the memory subsystem does - particularly
since ppc MMU management is software-assisted.

We would have more significant information by comparing Xenomai 2.5.6
over Linux 2.4.25.

> Roderik
> 
> --------------------------------------------------------
> manroland AG
> Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
> Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus Rall, Paul Steidle   
> Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht Offenbach HRB-Nr. 42592
> USt-Ident-Nr. DE 250200933
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



