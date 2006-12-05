Message-ID: <45758482.4070103@domain.hid>
Date: Tue, 05 Dec 2006 15:38:58 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] [PATCH] I-pipe tracer for ARM
References: <E1GrHXk-00023w-Oq@domain.hid>	<E1GrWZ5-000089-Ou@domain.hid>
	<45753DAB.20207@domain.hid>	<E1Graz2-0003MR-Gl@domain.hid>
	<457582DA.2070700@domain.hid>
In-Reply-To: <457582DA.2070700@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main@gna.org

Jan Kiszka wrote:
> Sebastian Smolorz wrote:
> 
>>Jan Kiszka wrote:
>>>Are you tracing into vmalloc'ed memory?
>>
>>Yes, without CONFIG_IPIPE_TRACE_VMALLOC the system does not boot.
> 
> 
> Hmm, makes me wonder of some laziness of the page mapping or a missing
> lock-against-swapping causes this. Could you have a closer look at the
> tracer code if we are lacking some magic for the vmalloc trace buffer
> (compare to the xnheap code, e.g.)?

This is a known issue, the ARM architecture lacks the set_pgdir
function, needed in mm/vmalloc.c to workaround the lazy page mapping of
vmalloced areas.

-- 
                                                 Gilles Chanteperdrix

