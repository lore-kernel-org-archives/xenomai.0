References: <6aedc4bc-74b5-4a9f-5c38-036a3d7850b9@siemens.com>
 <ee7647d4-0bfd-0933-2f10-e9fdc5da2880@web.de>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <e6331b58-4dec-171b-47eb-cd3e35a855a7@xenomai.org>
Date: Mon, 19 Mar 2018 17:54:30 +0100
MIME-Version: 1.0
In-Reply-To: <ee7647d4-0bfd-0933-2f10-e9fdc5da2880@web.de>
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
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Xenomai <xenomai@xenomai.org>

On 03/10/2018 11:06 PM, Jan Kiszka wrote:
> On 2018-03-09 08:51, Jan Kiszka wrote:
>> 4.9 requires more work, I've pushed the beginning to wip/4.9 in the same
>> repo.
> 
> I started to patch further on this during my flight (wip/4.9 updated),
> noticed that the 4.14-wip queue will need a little bit sysentry tweaking
> as well (missing 64-bit syscall dispatching), and then had to find 4.9
> in a rather unfortunate state /wrt x86-64: CPUs are no longer idling
> properly.

Meaning they do not enter any high CSTATE although they should with
CPU_IDLE* properly set, or something breaks when doing so?

Please share your CONFIG_CPU_IDLE* settings. I'll try to reproduce here.

Thanks,

-- 
Philippe.

