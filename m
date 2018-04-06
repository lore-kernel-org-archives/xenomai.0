From: Jan Kiszka <jan.kiszka@siemens.com>
References: <6aedc4bc-74b5-4a9f-5c38-036a3d7850b9@siemens.com>
 <ee7647d4-0bfd-0933-2f10-e9fdc5da2880@web.de>
 <54cd6098-3828-b028-3328-daf91b46d9da@xenomai.org>
 <1edf5dcb-bc63-2f53-f91b-f821b244563c@web.de>
 <fd85297e-17eb-add4-619e-234f7602dc44@xenomai.org>
 <0fb957ac-ae49-2d57-9f83-8a61201b1fb1@siemens.com>
 <57044fd9-5e29-5d04-958d-e2195536298b@xenomai.org>
 <0356efbe-6dd5-ff57-219e-122e38b52662@siemens.com>
Message-ID: <74fad713-d94a-f0b2-8bb2-60e9b7bc5d7f@siemens.com>
Date: Fri, 6 Apr 2018 17:52:37 +0200
MIME-Version: 1.0
In-Reply-To: <0356efbe-6dd5-ff57-219e-122e38b52662@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] 4.9 for x86 issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2018-04-06 17:11, Jan Kiszka wrote:
>> This is not about testing for Cobalt idleness, but for its core timer
>> idleness, given that the core timer is shared between both kernels. We
>> want to know whether we may allow the regular kernel to shutdown the
>> clock event hardware for entering a sleep state. XNIDLE -> XNTIMERIDLE
>> if you will. I covered this stuff in Documentation/ipipe.rst lately.
>>
> 
> I still don't see the problem. We own the timer, Linux does not program
> it. And letting Linux call hlt does not disturb the timer programming,
> in most cases at least (there might be some weird old broken hardware).

Looking at ipipe_enter_idle_hook more closely: What might make sense as
logic here is a test for a close-to-expire timer on the CPU. Then we
would do polling until the expiry which may reduce wakeup latencies. But
the question would be what the thresholds should be on the different
targets.

Did you see any concrete issues without that hook? On which architecture?

Jan

