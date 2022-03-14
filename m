Date: Mon, 14 Mar 2022 22:10:53 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
Message-ID: <1292922167.145768.1647292253417.JavaMail.zimbra@nod.at>
In-Reply-To: <421920084991b71be00040eb54d09518a9fc21a9.camel@siemens.com>
References: <20220314203841.28925-1-richard@nod.at>
 <421920084991b71be00040eb54d09518a9fc21a9.camel@siemens.com>
Subject: Re: [PATCH] cobalt/sched: Use nr_cpumask_bits instead of BITS_PER_LONG
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai <xenomai@xenomai.org>

----- Urspr=C3=BCngliche Mail -----
> Von: "Florian Bezdeka" <florian.bezdeka@siemens.com>
> I agree, BITS_PER_LONG seems wrong. But couldn't it be too small as
> well? It depends on NR_CPUS which might be > BITS_PER_LONG.

Hmm, nr_cpumask_bits is defined as:

#ifdef CONFIG_CPUMASK_OFFSTACK
/* Assuming NR_CPUS is huge, a runtime limit is more efficient.  Also,
 * not all bits may be allocated. */
#define nr_cpumask_bits nr_cpu_ids
#else
#define nr_cpumask_bits ((unsigned int)NR_CPUS)
#endif

Where do you see a problem?

Thanks,
//richard

