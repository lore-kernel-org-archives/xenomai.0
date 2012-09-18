Message-ID: <5058C79A.5020400@xenomai.org>
Date: Tue, 18 Sep 2012 21:12:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <504F5F1B.4020806@siemens.com> <50550091.50002@xenomai.org>
	<505592B8.9000109@xenomai.org> <5056DBAD.1000903@xenomai.org>
	<5058AE95.2020103@siemens.com> <5058AF21.5000600@xenomai.org>
	<5058BC96.8090601@siemens.com> <5058BE17.5070304@xenomai.org>
	<5058C39C.8000407@siemens.com> <5058C5F6.3040406@xenomai.org>
	<5058C73B.8040006@siemens.com>
In-Reply-To: <5058C73B.8040006@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ipipe/x86: kernel BUG due to missing
 IRQ_MOVE_CLEANUP_VECTOR entry in ipipe-core3.2
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 09/18/2012 09:10 PM, Jan Kiszka wrote:

> On 2012-09-18 21:05, Gilles Chanteperdrix wrote:
>> rah, vectors_limit is not needed at all. I do not see which look you are
>> talking about.
> 
> 		cfg = irq_cfg(irq);
> 		if (!cpumask_test_cpu(cpu, cfg->domain))
> 			per_cpu(vector_irq, cpu)[vector] = -1;


Yes, but :

>>>> -	for (vector = 0; vector < NR_VECTORS; ++vector) {
>>>> +	for (vector = 0; vector < first_system_vector; ++vector) {


-- 
                                                                Gilles.

