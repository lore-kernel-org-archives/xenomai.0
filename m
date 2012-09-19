Message-ID: <5059D7BD.7040103@siemens.com>
Date: Wed, 19 Sep 2012 16:33:33 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <504F5F1B.4020806@siemens.com> <50550091.50002@xenomai.org>
	<505592B8.9000109@xenomai.org> <5056DBAD.1000903@xenomai.org>
	<5058AE95.2020103@siemens.com> <5058AF21.5000600@xenomai.org>
	<5058BC96.8090601@siemens.com> <5058BE17.5070304@xenomai.org>
	<5058C39C.8000407@siemens.com> <5058C5F6.3040406@xenomai.org>
	<5058C73B.8040006@siemens.com> <5058C79A.5020400@xenomai.org>
	<5058C8EE.1050803@siemens.com> <5058C9FE.5030505@xenomai.org>
	<5059D412.7020202@siemens.com>
	<ce86871e85b087a85fbdd8317716a9fd.squirrel@www.xenomai.org>
In-Reply-To: <ce86871e85b087a85fbdd8317716a9fd.squirrel@www.xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] ipipe: x86: Populate vector_irq for all
	dispatched vectors
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2012-09-19 16:28, Gilles Chanteperdrix wrote:
> 
> Jan Kiszka wrote:
>>  	for (vector = 0; vector < NR_VECTORS; ++vector) {
>> +		/* I-pipe requires initialized vector_irq for system vectors */
>> +		if (test_bit(vector, used_vectors))
>> +			continue;
>>  		irq = per_cpu(vector_irq, cpu)[vector];
>>  		if (irq < 0)
>>  			continue;
> 
> This looks wrong to me: you are skipping a part a code that was setting to
> -1 vectors that were allocated but not used on this cpu.

I'm skipping only used_vectors, i.e system vectors. They will be set up
for I-pipe for that well-known reason. I'm no longer skipping to clear
IRQ vectors that are not used on the current CPU (!cpumask_test_cpu(cpu,
cfg->domain)). That is what was missing in both approaches so far.

Note: vector_free = (vector_irq == -1) && !used_vector

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

