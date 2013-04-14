Message-ID: <516AC595.5060103@xenomai.org>
Date: Sun, 14 Apr 2013 17:04:53 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <oqr4jdyggv.fsf@merlin.sez.to> <51646CBA.40407@xenomai.org>
	<51653957.2070405@grandegger.com>
In-Reply-To: <51653957.2070405@grandegger.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 1/2] rtcan_module: Fix tx_timeout buffer size
 inconsistency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: xenomai@xenomai.org, Wolfgang Grandegger <wg@denx.de>

On 04/10/2013 12:05 PM, Wolfgang Grandegger wrote:

> On 04/09/2013 09:32 PM, Gilles Chanteperdrix wrote:
>> On 03/17/2013 07:56 PM, Paul Janzen wrote:
>>
>>> When formatting /proc/rtcan/sockets, tx_timeout is defined as
>>> char[16], but a length of 20 is passed to rtcan_get_timeout_name. If
>>> tx_timeout for any socket is infinite, this causes snprintf to zero
>>> outside the buffer, leading to stack overflow and a kernel panic.
>>> Make the tx_timeout buffer 20 bytes long instead.
>>>
>>> Signed-off-by: Paul Janzen <pcj@xenomai.sez.to>
> 
> It's a bug, therefore:
> 
> Acked-by: Wolfgang Grandegger <wg@grandegger.com>
> 
>> Wolfgang, ping?
> 
> Pong, sorry for delay.


Hi,

No problem for the delay, merged, thanks.

We have two other unconfirmed CAN patches:
http://www.xenomai.org/pipermail/xenomai/2013-March/028111.html

And not really a patch, but modifying the code is trivial if you confirm
that we can do it:
http://www.xenomai.org/pipermail/xenomai/2013-February/027824.html

Regards.

-- 
                                                                Gilles.

