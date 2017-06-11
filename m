References: <DB6PR0701MB24569CBFFA2BDB4E246360C8B5CF0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
 <0403698a-861b-8ca3-6e7a-3582b6a84a3b@xenomai.org>
 <DB6PR0701MB2456F0521C5DE7B8D4297F24B5CC0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
 <7d82cdc5-22a6-66ee-5c23-7a626b5b5ef6@xenomai.org>
 <DB6PR0701MB24568E5EFFE03412FE5AC35AB5CC0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <dd9d7fdb-78ce-2c86-f74d-6f8311a9830e@xenomai.org>
Date: Sun, 11 Jun 2017 19:06:17 +0200
MIME-Version: 1.0
In-Reply-To: <DB6PR0701MB24568E5EFFE03412FE5AC35AB5CC0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt_taks_bind() returns -EAGAIN for existing task
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <g.moro@qmul.ac.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/11/2017 05:58 PM, Giulio Moro wrote:
>> Time which could be devoted to this subject
>> is too short, when other duties have to be carried out as well. Usual
>> dilemma, usual outcome so far.
> 
> Anything I and the community (us) can do to help with this?
> Pull requests with documentation amendments?

Fixing the existing service-oriented documentation would certainly be nice.

Also, my understanding is that people direly need in-depth articles that
guide them for implementing typical Xenomai use cases and patterns,
explaining basic concepts in the same move; not necessarily a long and
boring general prose, but rather to-the-point material illustrated with
simple figures.

e.g.

- Closed-loop systems with Cobalt anyone?
- Driving devices in real-time, an RTDM tale
- Can a dual kernel system do audio?
- Could Xenomai speak arinc653, how?
- Did Xenomai and Android meet?
- etc [1]

Diving into details, some articles could cover specific technical issues:

- IPC between Cobalt and the regular world
- Sessions: sharing objects between processes within a UN*X group
- Driving a DMA with Cobalt
- Practical example of using slackspot (fixing it if necessary).
- How to create a user-space driver with UDD
- Survival kit when debugging a boot hang with Cobalt
- Who lives in /proc/xenomai after all?
- SCHED_WEAK, SCHED_QUOTA, SCHED_TP, SCHED_SPORADIC... What do all those
Cobalt schedulers do?
- Sharing IRQs between Linux and Cobalt considered funky.
- Why and how calling Linux services within a real-time loop may kill
the latencies?
- Solving the C++ constructor madness when that code requires Xenomai
core services, a 10 years long psychotherapy
- etc

A reference for me would be LWN (https://lwn.net). The way the editors
there manage to explain technical issues makes me feel like I was a
smart reader - which is in itself a sufficient proof that they are doing
a hell of a good job.

[1]
http://www.denx.de/en/view/News/Xum2009AbstractsAndPresentations?rev=r1.8

-- 
Philippe.

