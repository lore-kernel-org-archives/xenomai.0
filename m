References: <09EA8A4C-D8EB-4470-A339-C2019D1B662B@gmail.com>
 <55BA500F.8010504@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55BA6FEC.3070109@xenomai.org>
Date: Thu, 30 Jul 2015 20:41:48 +0200
MIME-Version: 1.0
In-Reply-To: <55BA500F.8010504@xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] mutate/start RT_TASK a posix thread?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <haberlerm@gmail.com>, xenomai <xenomai@xenomai.org>

On 07/30/2015 06:25 PM, Philippe Gerum wrote:
> On 07/30/2015 07:26 AM, Michael Haberler wrote:
>> we're happily using RT threads using the Xenomai 2 thread API
>>
>> is it possible _using this API_ to create/mutate/relax such a thread intentionally into a Posix thread but retaining the API usage?
> 
> It is possible to run them as low priority Xenomai threads, assigning
> them to the SCHED_OTHER class. The native API is retained for those

... which is obtained by passing prio=0 to rt_task_create() or
rt_task_shadow().

-- 
Philippe.

