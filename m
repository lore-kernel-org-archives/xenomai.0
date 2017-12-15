References: <954f3936-9906-a33e-4d6a-fa5e640430e4@xenomai.org>
 <bb013c41-9b90-4bc1-a84a-6e5137061ceb@alaxarxa.net>
 <20f31474-8d30-fad7-c79d-bd4cf03295ae@xenomai.org>
 <56e8674c-9744-3bf4-ba7a-b3df1fd113fa@alaxarxa.net>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <657c0db4-6cb8-5876-3349-cd784ba69077@siemens.com>
Date: Fri, 15 Dec 2017 14:20:29 +0100
MIME-Version: 1.0
In-Reply-To: <56e8674c-9744-3bf4-ba7a-b3df1fd113fa@alaxarxa.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTnet fixes - testers needed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>, Philippe Gerum <rpm@xenomai.org>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 2017-12-15 13:25, Leopold Palomo-Avellaneda wrote:
> Hi,
> 
> I forgot something more:
> 
> On 15/12/17 12:04, Philippe Gerum wrote:
> 
> [...]
>>>
>>> I guess that there's something in the kernel config or somewhere in 3.x that
>>> affects the PCI cards. In 2.6.x worked.
>>
>> On x86, I'd dare to say that it worked mostly by accident, as revealed
>> by SMAP later on. RTnet was out of the Xenomai tree in 2.6.x, some
>> changes introduced during the merge into 3.x might have caused
>> regressions, or maybe some latent issues started to bite when transposed
>> in a different environment, just like the SMAP problem on x86, revealing
>> an ancient Rnet bug. I genuinely don't know when things started to hit
>> the fan.
> 
> I don't know if it's relevant or not, or I didn't understand it, but I think
> that I still have problems with SMAP. If I activate it, I got:

You must leave SMAP off until someone develops patches to convert the
complete RTnet userspace API over to rtdm_copy_to/from_user.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

