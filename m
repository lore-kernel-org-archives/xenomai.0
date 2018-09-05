References: <E1fxEE3-0004CF-DU@xenomai.org>
 <5ab80ae3-d6f2-1b06-17ac-401dd564df99@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <bb93daea-b9b2-b841-2b2f-a12924482598@xenomai.org>
Date: Wed, 5 Sep 2018 09:41:07 +0200
MIME-Version: 1.0
In-Reply-To: <5ab80ae3-d6f2-1b06-17ac-401dd564df99@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] cobalt/sched: group high-level init/cleanup
 code
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 09/04/2018 07:30 PM, Jan Kiszka wrote:
> On 2018-09-04 12:54, Philippe Gerum wrote:
>> Move scheduler init/cleanup bits to dedicated routines.
>>
> 
> Looks good. I assume the underlying motivation is something like this:
> "This concentrates scheduler related code in the sched module."
> (I will insist on such reasoning for more complex code ;) ).
> 

Yes, we may also need global sched-specific inits in the future which
might not be per-cpu related.

-- 
Philippe.

