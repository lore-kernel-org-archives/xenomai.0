References: <abf31608-ffa8-17e0-e3eb-4d62f067e365@xenomai.org>
 <1b035acc-5784-f0b0-f16f-09279d5a8845@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <07716080-d5cd-2508-20cc-b679a72f6f68@xenomai.org>
Date: Thu, 23 Nov 2017 21:45:45 +0100
MIME-Version: 1.0
In-Reply-To: <1b035acc-5784-f0b0-f16f-09279d5a8845@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [RFC] RTnet, Analogy and the elephant in the room
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>
Cc: Daniel Wagner <daniel.wagner@siemens.com>

On 11/22/2017 09:26 PM, Jan Kiszka wrote:
> On 2017-11-21 18:11, Philippe Gerum wrote:
>> So, let's talk about the elephant in the room: the current situation of
>> the Xenomai project is not viable in the long run. I can only encourage
>> people who feel concerned about it to discuss openly the practical steps
>> to best address this challenge.
> 
> Thanks for bringing this frankly on the table! For those who follow the
> project, it's likely no news. So we were working on this issue also
> internally, with users of Xenomai inside Siemens. And we have the
> backing to enhance our involvement in upstream work. Right now we are
> working on making this concrete.
> 
> There are many areas where contributions can be beneficial for the
> project and its community, and many do not require deepest understanding
> of the core, like around CI, test automation, distro packaging,
> documentation, or user support. But some essential elements in my eyes are
> 
>  - building up a core team of kernel maintainers for Cobalt
> 
>  - offloading work from the shoulders of our extremely valuable
>    maintainer
> 
> The second part will be achieved to a certain degree by the first one as
> Philippe can probably confirm.

Yes, extending "Cobalt" to the pipeline. A significant portion of the
overall maintenance involves the I-pipe. Hence the work on rethinking
how the interrupt pipeline is integrated into the Linux kernel, how we
can make the former a regular feature of the latter instead of an
add-on, with the goal of simplifying the maintenance, but also making
the whole thing way more natural, easier to grasp.

-- 
Philippe.

