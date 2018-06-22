References: <20180622071440.2of2edqeswqbomqa@fsr-ub1664-175>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <fa6473c8-5762-ecf7-2f4a-9443694cd1d5@xenomai.org>
Date: Fri, 22 Jun 2018 09:16:15 +0200
MIME-Version: 1.0
In-Reply-To: <20180622071440.2of2edqeswqbomqa@fsr-ub1664-175>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] LOCKDEP warning due to ipipe generic implementation
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Abel Vesa <abel.vesa@nxp.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>

On 06/22/2018 09:14 AM, Abel Vesa wrote:
> I'm just curious if anyone has seen this LOCKDEP warning before.
> 
>>From a quick look it seems to be something that has to do with the generic ipipe.
> More exactly the fact that handle_IRQ gets called outside the hardirq context and
> LOCKDEP doens't understand the fact that this is how ipipe works. I would guess either
> the LOCKDEP config should depend on !IPIPE or the ipipe should have a specific case
> the in LOCKDEP implementation so that this warning doesn't shown since it will never
> happen when IPIPE is enabled.
> 
> I haven't looked too far into this and I might be missing stuff.

LOCKDEP is not support on I-pipe/arm.

-- 
Philippe.

