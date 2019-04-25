Subject: Re: [PATCH] cobalt/intr: fix interrupt stat iterator
From: Jan Kiszka <jan.kiszka@siemens.com>
References: <20190424102940.12754-1-rpm@xenomai.org>
 <e2d59fb7-93fd-579e-44a9-410c03562f5f@siemens.com>
Message-ID: <a0589ad5-6ea6-c81a-c47c-09f1eaa3b22b@siemens.com>
Date: Thu, 25 Apr 2019 17:10:33 +0200
MIME-Version: 1.0
In-Reply-To: <e2d59fb7-93fd-579e-44a9-410c03562f5f@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 25.04.19 16:53, Jan Kiszka wrote:
> On 24.04.19 12:29, Philippe Gerum via Xenomai wrote:
>> The implementation does not iterate fully over all CPU slots for every
>> handler, leaving some of them uncollected. In addition, if maxcpus= is
>> used to restrict the number of available CPUs to a subset of the
>> present ones, with the highest numbered CPU marked offline, the
>> iterator rescans the first valid IRQ slot indefinitely, eventually
>> leading to memory corruption due to out-of-bound writes.
> 
> The patch looks good and works fine for the common case, so I've applied it to 
> next.
> 
> But I cannot reproduce your maxcpus setup as - for to-be-debugged reasons - we 
> are already crashing on 4.14 and 4.4 on x86 during boot. Did you test on ARM?

OK, understood the trigger: systemd-udevd decides to boot the remaining CPUs 
later on, and that will crash us on the first timer tick. Maybe x86-only issue, 
maybe you tested without CPU hotplug support.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

