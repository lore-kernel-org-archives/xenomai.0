Message-ID: <4EF4A3E2.9030709@domain.hid>
Date: Fri, 23 Dec 2011 16:53:06 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <56F449AE83D74177BAC5887692E0EF55@domain.hid>	<4EF44DB9.9000609@domain.hid>
	<4EF49DA3.8070904@domain.hid>
In-Reply-To: <4EF49DA3.8070904@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Interrupt numbers
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Makarand Pradhan <makarandpradhan@domain.hid>
Cc: xenomai@xenomai.org

On 12/23/2011 04:26 PM, Makarand Pradhan wrote:
> On 23/12/11 04:45 AM, Gilles Chanteperdrix wrote:
>>
>> Xenomai uses the same interrupt numbers as linux. But rt_intr_create is
>> deprecated in user-space, you should instead write a driver using the
>> rtdm skin. The enable bit is handled by xenomai when you request the irq
>> at xenomai level.
>>
> Hi Gilles,
> 
> We use rt_intr_create in our code. So I am trying to understand the 
> reasons for it being deprecated. So far, I have not been able to see any 
> comments in the code regarding the deprecation or anything in the git log.

Splitting your code between driver and application enforces a clean
separation between the two, which helps maintenance, so is good on the
long run.

> 
> Can you pl comment on the reasons for deprecating rt_intr_create? Will 
> it be removed in the next release?

We never change ABI in a branch, so, all releases in the 2.6 branch are
guaranteed to support the same services as xenomai 2.6.0.

But in xenomai 3.0, rt_intr_create will certainly no longer be available.
-- 
					    Gilles.

