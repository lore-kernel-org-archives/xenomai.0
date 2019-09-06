Subject: Re: [PATCH v4 2/2] cobalt/rtdm: allow for device teardown
References: <65ac2255-6651-1ef0-49aa-b40092b7512e@siemens.com>
 <fe4daa26-0818-d866-a707-d5e04a36fb0c@siemens.com>
 <67380ec5-cdf4-659e-6a7f-989f1e1f5c2a@xenomai.org>
 <c33eb899-357a-8b2e-25f5-c10551d79613@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <d83cbb21-5866-2675-bbbe-ba5bca43e857@xenomai.org>
Date: Fri, 6 Sep 2019 17:51:25 +0200
MIME-Version: 1.0
In-Reply-To: <c33eb899-357a-8b2e-25f5-c10551d79613@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, Quirin Gylstorff <quirin.gylstorff@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 9/6/19 5:43 PM, Jan Kiszka wrote:
> On 06.09.19 16:52, Philippe Gerum via Xenomai wrote:
>> On 9/4/19 4:44 PM, Quirin Gylstorff via Xenomai wrote:
>>>
>>> I tested xenomai-next with xeno-test on 4.19.66+ amd64.
>>> This patch triggers a general protection fault during the execution of
>>> xeno-test. The log is attached.
>>>
>> Ok, I'll have a look. Thanks.
>>
> 
> I've started to dig into this a bit already but got distracted multiple
> times. One thing I already found out: It's not a good idea to close the
> fd on unregister without also ensuring that it's no longer pending in
> rtdm_fd_cleanup_queue. But fixing that does not resolve the issue we see
> with the test case.
> 

The issue is that a wrong pointer is passed to the driver close call.

-- 
Philippe.

