Subject: Re: Possible Cobalt mqueue issue
References: <5C741D7B.5080108@freyder.net>
 <1a1a8dfe-e56c-5d1f-5880-7d4100cf4a23@siemens.com>
From: Steve Freyder <steve@freyder.net>
Message-ID: <5C74362A.6090505@freyder.net>
Date: Mon, 25 Feb 2019 12:38:34 -0600
MIME-Version: 1.0
In-Reply-To: <1a1a8dfe-e56c-5d1f-5880-7d4100cf4a23@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>



On 2/25/2019 11:15 AM, Jan Kiszka wrote:
> On 25.02.19 17:53, Steve Freyder via Xenomai wrote:
>> Greetings again,
>>
>> Recently I have converted my codebase from using Alchemy-based queues 
>> (rt_queue_xx) to Cobalt (Posix) mqueues for all inter-process 
>> communication, and using rt_queue queues only for communication 
>> between threads in the same process.
>>
>> This is running on Xenomai 3.0.7 built from -next (our vendor does 
>> the Xenomai/kernel builds):
>
> Was that really 3.0.7, not 3.0.8 or latest stable-3.0.x? There e.g. 
> https://gitlab.denx.de/Xenomai/xenomai/commit/4924717ec5cbc694afc1b91ba7d525b80901d44d 
> since 3.0.7, and you backtrace kind of looks familiar /wrt that.
>
> Jan
>
>>
>> Linux g3l-36 4.1.18_C01571-15S01-00.002.zimg+83fdace666 #4 SMP Tue 
>> Aug 21 11:22:31 CDT 2018 armv7l GNU/Linux
Now that I see that, you're absolutely right and I do apologize for 
bothering you with this.  After looking at that patch (from October 
2018) I do remember when you originally posted it and thinking at the 
time that I needed to pick it up in a future build.  The build from Aug 
21 2018 was 3.0.7 and didn't include your 4924717e fix.  I guess it is 
time for me to move to a stable-3.0.9 build!

Thanks,
Steve



