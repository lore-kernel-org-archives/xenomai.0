Subject: Re: [xenomai-images][PATCH 3/4] ci: Split build and add 5.4 builds
References: <20201104161154.32366-1-Quirin.Gylstorff@siemens.com>
 <20201104161154.32366-4-Quirin.Gylstorff@siemens.com>
 <26554d28-7219-f8d9-8739-e474d30a3f5a@siemens.com>
 <15c9438c-2488-efa7-4f17-e1f006c8b01e@siemens.com>
 <fa36f3e1-b454-edaf-f843-6b7efc40eb13@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Message-ID: <9c705457-2198-5af7-ecdb-27a39a8bdb15@siemens.com>
Date: Fri, 6 Nov 2020 14:39:42 +0100
MIME-Version: 1.0
In-Reply-To: <fa36f3e1-b454-edaf-f843-6b7efc40eb13@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org



On 11/5/20 10:39 AM, Jan Kiszka wrote:
> On 05.11.20 10:30, Gylstorff Quirin wrote:
>>
>>
>> On 11/4/20 7:28 PM, Jan Kiszka wrote:
>>> Would be good the express that correlation between kernel version and 
>>> Xenomai version somehow as well. Longer job names? Or is there some 
>>> better way?
>>
>> We can use longer names or add tags.
>>
> 
> If tags a well visible in the UI, I'm fine. Key point for me is that is 
> clear by looking at the CI overviews what has been tested, conceptually 
> (actual git IDs require a look into the log, I know).
> 
> Jan
> 

I tested tags and they are visible in the ui[1].
But you need to add the tags to the runner as their purpose is to select 
an specific runner.

I would go with longer names.

[1]: 
https://gitlab.com/Quirin.Gy/xenomai-images-test/-/pipelines/212770080/builds

Quirin

