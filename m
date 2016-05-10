References: <E1azqoa-0005Bc-3q@sd-51317.xenomai.org>
 <5731E948.5050301@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5731FE39.3060101@siemens.com>
Date: Tue, 10 May 2016 17:28:57 +0200
MIME-Version: 1.0
In-Reply-To: <5731E948.5050301@xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : cobalt/kernel: Return
 need_resched flag from xnsynch_release
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 2016-05-10 15:59, Philippe Gerum wrote:
> On 05/09/2016 09:26 PM, git repository hosting wrote:
>> Module: xenomai-jki
>> Branch: for-forge
>> Commit: dd2df9a8bfbb7e45e1c262b52050cc1c3f75b3bd
>> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=dd2df9a8bfbb7e45e1c262b52050cc1c3f75b3bd
> 
>> @@ -926,7 +924,7 @@ struct xnthread *xnsynch_release(struct xnsynch *synch,
>>  	trace_cobalt_synch_release(synch);
>>  
>>  	if (xnthread_put_resource(curr))
>> -		return NULL;
>> +		return 0;
>>  
> 
> Nitpicking about the boolean return. Otherwise looks good.
> 

Yep, pushed a fixed version.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

