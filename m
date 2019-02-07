Subject: Re: maximum number of xenomai processes allowed
References: <89c2b570-ba8b-59b7-49e4-b8913fa5552f@numalliance.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <e0a96d7b-cf93-6061-dee2-d8eae49edfe8@xenomai.org>
Date: Thu, 7 Feb 2019 12:24:39 +0100
MIME-Version: 1.0
In-Reply-To: <89c2b570-ba8b-59b7-49e4-b8913fa5552f@numalliance.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2/7/19 12:02 PM, Stéphane Ancelot via Xenomai wrote:
> Hi,
> 
> After running a given amount of xenomai processes, I can no more launch
> more processes.
> 
> They are failing with next message.
> 
>   0"000.000| WARNING: [main] pthread_setschedparam failed (prio=-1)
>    0"000.000| WARNING: [main] setup call cobalt failed
>    0"000.000| BUG in xenomai_init(): [main] initialization failed, ENOMEM
> 
> It looks like there is a limitation on the number of xenomai processes.

No, there is none. Receiving ENOMEM is a hint, more kernel resources
such as threads requested by applications translates into more memory
needed by the core.

> 
> Where can I hack it ?
> 

There is a configuration switch for this: see CONFIG_XENO_OPT_SYS_HEAPSZ.

-- 
Philippe.

