Message-ID: <50C758F0.4060805@wanadoo.fr>
Date: Tue, 11 Dec 2012 17:01:52 +0100
From: Thierry Bultel <thierry.bultel@wanadoo.fr>
MIME-Version: 1.0
References: <50C1EF04.1090506@wanadoo.fr> <50C236B9.3030507@xenomai.org>
	<50C4EF5A.3030502@wanadoo.fr> <50C524A6.6020006@xenomai.org>
	<50C5F784.6040801@wanadoo.fr> <50C6076F.7050505@xenomai.org>
	<50C60E6A.1080307@wanadoo.fr> <50C61DF3.8030703@xenomai.org>
	<50C62B41.1060308@wanadoo.fr> <50C63069.1010607@xenomai.org>
	<50C63FF3.6040409@wanadoo.fr> <50C643DC.1080901@xenomai.org>
	<50C64F79.8070101@wanadoo.fr> <50C65296.9070508@xenomai.org>
	<50C75094.3070906@wanadoo.fr> <50C75307.8020400@xenomai.org>
In-Reply-To: <50C75307.8020400@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] iMX6q 1Hz tick
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Le 11/12/2012 16:36, Gilles Chanteperdrix a écrit :
> On 12/11/2012 04:26 PM, Thierry Bultel wrote:
>> Gilles,
>>
>> another issue (likely related, and that may help to diagnose) that I can
>> see is that time is completely wrong;
>>
>> For instance:
>>
>>
>> [root@buildroot ~]# time sleep 10
>>
>> real	0m10.009s
>> user	0m0.002s
>> sys	0m0.013s
>>
>> The system says that it spent 10 secs but I actually measured 25 secs.
>
> No, that is likely because you have CONFIG_CPU_FREQ or CONFIG_CPU_IDLE
> enabled.
>

Thanks, yes this was CONFIG_CPU_FREQ
Sorry

Thierry

