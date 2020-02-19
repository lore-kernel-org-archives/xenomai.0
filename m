Subject: Re: Towards Xenomai on Dovetail
References: <97687b86-9c39-e808-d49c-04b0178d8c31@siemens.com>
 <3a0bab49-a40f-75d3-9abb-26a7a2e2341c@gmail.com>
 <2657497.jFxQff4vTC@omoikane>
From: Philippe Gerum <philippe.gerum@gmail.com>
Message-ID: <f06e1bcc-21d9-e46c-103b-5bfd745ab599@gmail.com>
Date: Wed, 19 Feb 2020 17:09:22 +0100
MIME-Version: 1.0
In-Reply-To: <2657497.jFxQff4vTC@omoikane>
Content-Type: text/plain; charset=utf-8
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
To: "steven.seeger flightsystems.net" <steven.seeger@flightsystems.net>, Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: Philippe Gerum <philippe.gerum@gmail.com>

On 2/19/20 4:33 PM, steven.seeger flightsystems.net via Xenomai wrote:
> On Tuesday, February 18, 2020 12:36:45 PM EST Philippe Gerum wrote:
>> - kernel/cobalt/arch/*/ and related can go, almost entirely. There is
>> direct support for context switching including fpu management for
>> threads controlled by the companion (e.g. real-time) core. This means
>> that Xenomai's scheduler core should be adapted to use the available
>> dovetail interface for this. The workings are explained in the
>> description of the so-called "alternate scheduling" Dovetail implements [3].
> 
> Sorry for joining this discussion late.
> 
> Is there still a syscall interface (and fast ipipe syscall path) for dovetail? 
> Or is this done away with?
> 

Yes, there is, no difference compared to the I-pipe in this respect.

-- 
Philippe.

