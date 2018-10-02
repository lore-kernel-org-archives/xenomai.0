References: <20181001135619.24883-1-rpm@xenomai.org>
 <20181001135619.24883-6-rpm@xenomai.org>
 <9cd23077-9f88-e06f-dbb5-6c1a39b7f578@siemens.com>
 <13a48d82-7db5-b116-a701-08ec4a5b002d@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <eccccc6e-c075-8274-5b36-e3b02dee586b@siemens.com>
Date: Tue, 2 Oct 2018 17:53:53 +0200
MIME-Version: 1.0
In-Reply-To: <13a48d82-7db5-b116-a701-08ec4a5b002d@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 5/6] boilerplate/setup: cobalt: retrieve the
 default CPU affinity
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 02.10.18 17:43, Philippe Gerum wrote:
> On 10/02/2018 05:26 PM, Jan Kiszka wrote:
>> On 01.10.18 15:56, Philippe Gerum wrote:
>>> Over Cobalt, make sure the default CPU affinity mask reflects the set
>>> of CPUs available for running real-time threads
>>> (i.e. /proc/xenomai/affinity).
>>
>> "This avoids that thread will be created on CPU that is not support by
>> Xenomai and first needs to be migrated when it is hardened."
>>
>> Correct? I'm a fan of rather describing the "why" than the "what" in
>> commit log. The latter is often already in the code.
>>
> 
> You are describing a side-effect of not having the default CPU affinity
> right, which people who are not familiar with the code are unlikely to
> get easily. On the other hand, saying that we want applications to use
> the underlying kernel's CPU set as their default CPU affinity setting
> can be understood by anyone who understands the basics of SMP.
> 
> So I believe the original log is correct.

The original log is not explain why it changes things, it's only explaining what 
it does.

Just describe what was the effect of not having the mask set, and I will 
complete this commit.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

