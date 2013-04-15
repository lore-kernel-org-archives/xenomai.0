Message-ID: <516B9C3F.2080107@grandegger.com>
Date: Mon, 15 Apr 2013 08:20:47 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
References: <oqr4jdyggv.fsf@merlin.sez.to> <51646CBA.40407@xenomai.org>
	<51653957.2070405@grandegger.com> <516AC595.5060103@xenomai.org>
In-Reply-To: <516AC595.5060103@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, Wolfgang Grandegger <wg@denx.de>

On 04/14/2013 05:04 PM, Gilles Chanteperdrix wrote:
> On 04/10/2013 12:05 PM, Wolfgang Grandegger wrote:
> 
>> On 04/09/2013 09:32 PM, Gilles Chanteperdrix wrote:
>>> On 03/17/2013 07:56 PM, Paul Janzen wrote:
>>>
>>>> When formatting /proc/rtcan/sockets, tx_timeout is defined as
>>>> char[16], but a length of 20 is passed to rtcan_get_timeout_name. If
>>>> tx_timeout for any socket is infinite, this causes snprintf to zero
>>>> outside the buffer, leading to stack overflow and a kernel panic.
>>>> Make the tx_timeout buffer 20 bytes long instead.
>>>>
>>>> Signed-off-by: Paul Janzen <pcj@xenomai.sez.to>
>>
>> It's a bug, therefore:
>>
>> Acked-by: Wolfgang Grandegger <wg@grandegger.com>
>>
>>> Wolfgang, ping?
>>
>> Pong, sorry for delay.
> 
> 
> Hi,
> 
> No problem for the delay, merged, thanks.
> 
> We have two other unconfirmed CAN patches:
> http://www.xenomai.org/pipermail/xenomai/2013-March/028111.html

We can add even more PCI IDs here. I'm going to prepare a patch. Just
support for 4 channel cards needs more effort.

> And not really a patch, but modifying the code is trivial if you confirm
> that we can do it:

> http://www.xenomai.org/pipermail/xenomai/2013-February/027824.html

Well, I'm not happy with that extension to rtcansend. I will answer to
the original thread.

Wolfgang.


