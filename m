Subject: Re: RTnet sendmmsg and ENOBUFS
References: <DB8PR05MB591594C16F703FD12F088928F6760@DB8PR05MB5915.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <1510f7f0-e130-0e22-b946-d1f6d84f3608@siemens.com>
Date: Wed, 13 Nov 2019 18:39:02 +0100
MIME-Version: 1.0
In-Reply-To: <DB8PR05MB591594C16F703FD12F088928F6760@DB8PR05MB5915.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 13.11.19 16:10, Lange Norbert via Xenomai wrote:
> Hello,
> 
> for one of our applications, we have (unfortunatly) a single ethernet connection for Realtime and Nonrealtime.
> 
> We solve this by sending timeslices with RT first, then filling up the remaining space. When stressing the limits (quite possibly beyond if accounting for bugs),
> the sendmmsg call over a raw socket returns ENOBUFS (even with a single small packet).
> I was expecting this call to just block until the resouces are available.

Blocking would mean that the sites which make buffers available again 
had to signal this. The original design idea was to avoid such overhead 
and rather rely on the applications to schedule their submissions 
properly and preallocate resources accordingly.

> 
> Timeslices are 1 ms, so that could be around 12Kbyte total or ~190 60Byte packets (theoretical max).
> 
> What variables are involved (whats the xenomai buffer limits, are they shared or per interface) and choices do I have?
> 
> - I could send the packages nonblocking and wait or drop the remaining myself
> - I could deal with ENOBUFS the same way as EAGAIN (is there any difference actually)
> - I could raise the amount of internal buffer somehow

Check kernel/drivers/net/doc/README.pools

> 
> Also while stresstesting I get these messages:
> 
> [ 5572.044934] hard_start_xmit returned 16
> [ 5572.054989] hard_start_xmit returned 16
> [ 5572.064007] hard_start_xmit returned 16
> [ 5572.067893] hard_start_xmit returned 16
> [ 5572.071739] hard_start_xmit returned 16
> [ 5572.075586] hard_start_xmit returned 16
> [ 5575.096116] hard_start_xmit returned 16
> [ 5579.377038] hard_start_xmit returned 16

This likely comes from NETDEV_TX_BUSY signaled by the driver. Check the 
one you use for reasons. May include "I don't have buffers left".

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

