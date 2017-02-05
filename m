References: <CAJ2oMhL5ZTgJQj60Evu6qsEE3GueDf_eKfVpHrZB7fhGaJkLQw@mail.gmail.com>
 <d61c1b61-6b81-4111-b88b-bf336ea676ed@xenomai.org>
 <CAJ2oMhJgh2hbMNi6r=dFc=zQQVAUEk9MP5rbXLunSTaghg75vg@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <04462182-2e2f-ef26-cc18-0d40254b9307@xenomai.org>
Date: Sun, 5 Feb 2017 11:58:55 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ2oMhJgh2hbMNi6r=dFc=zQQVAUEk9MP5rbXLunSTaghg75vg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] cpu with one core only
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ran Shalit <ranshalit@gmail.com>
Cc: xenomai@xenomai.org

On 02/05/2017 11:55 AM, Ran Shalit wrote:
> On Sat, Feb 4, 2017 at 12:10 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>> On 02/04/2017 09:19 AM, Ran Shalit wrote:
>>> Hello,
>>>
>>> It is said in documentation:
>>>
>>> "The key issue is with the number of CPU cores actually running
>>> real-time threads and receiving interrupts from real-time sources, not
>>> with the overall number of cores on line on the target hardware.
>>> Because the Cobalt co-kernel does not share any lock with the regular
>>> Linux kernel when dealing with real-time activities, a 16-way server
>>> pinning such activities on not more than four of the available cores
>>> would still deliver good performances in a Cobalt-based dual kernel
>>> configuration."
>>>
>>> We plan to use xenomai,
>>> but the cpu (Atom) is only a single core.
>>>
>>> Can a single core still gives good results with xenomai ?
>>>
>>
>> Yes. There is nothing in the excerpt above which might suggest the
>> opposite btw.
>>
> 
> Hi,
> 
> Do you think it is correct to assume that adding cores will result in
> a (probably) smaller latency ?

No, it is actually the exact opposite. Adding cores will involve more
cache-related latencies, and also require additional serialization for
accessing some critical resources.

-- 
Philippe.

