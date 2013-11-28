Message-ID: <5297A7E0.9030207@xenomai.org>
Date: Thu, 28 Nov 2013 21:30:24 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20131128143152.04ac3eab.norbert.bukuli@mediso.hu>
 <5297A4E3.50807@xenomai.org>
In-Reply-To: <5297A4E3.50807@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] test suite programs crash with Illegal instruction on
 MPC5200
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Bukuli Norbert <norbert.bukuli@mediso.hu>
Cc: Xenomai <xenomai@xenomai.org>

On 11/28/2013 09:17 PM, Gilles Chanteperdrix wrote:
> On 11/28/2013 02:31 PM, Bukuli Norbert wrote:
>> Hello!
>>
>> I am having a little problem with some programs from the Xenomai test
>> suite. The clocktest, cyclictest and switchtest crashes with "Illegal
>> instruction":
> 
> What about the latency test? If it fails with the same error, you could 
> try the following patch for powerpc SPE:
> 
> https://git.xenomai.org/xenomai-2.6.git/commit/?id=d09932cfd0ca422989b3c3a9d736236d74590ade
> 

The patch is needed to get switchtest working, but otherwise, you simply
need to disable CONFIG_XENO_HW_FPU and the other tests should work
without the patch.

-- 
                                                                Gilles.

