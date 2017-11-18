References: <CAKJ14NeB_NUbYh4Q2c1EFRCSLSNGrkwQtqt7ja71AFvXxER9RQ@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <08af1015-ee86-b5b2-86a6-d996bb508de3@xenomai.org>
Date: Sat, 18 Nov 2017 12:37:30 +0100
MIME-Version: 1.0
In-Reply-To: <CAKJ14NeB_NUbYh4Q2c1EFRCSLSNGrkwQtqt7ja71AFvXxER9RQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai and libunwind on ARM Cortex A9
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andreas Glatz <andi.glatz@gmail.com>, xenomai@xenomai.org, jean-baptiste.tredez@basystemes.fr

On 11/02/2017 05:03 PM, Andreas Glatz wrote:
>> Le 04/10/2017 ? 10:54, Philippe Gerum a ?crit?:
>>> On 10/03/2017 01:49 PM, Andreas Glatz wrote:
>>>> Hi
>>>>
>>>> I implemented the debug signal handle SIGXCPU as described in the
>>>> Xenomai documentation. The glibc function backtrace() returns
>>>> backtraces, but they often are very short (they typically end at the
>>>> signal (restore) handler, and don't show the function which caused the
>>>> SIGXCPU in the first place).
>>> Mm, ok. I did not observe this issue so far. This said, I'm not
>>> routinely using the feature.
>> We have the same issue on ARM Cortex A9. Backtraces are complete when
>> the signal does not come from xenomai. They end at the signal handler
>> (__default_rt_sa_restorer) for xenomai SIGXCPU signal.
>> Maybe it has something to do with unwind-tables on ARM.
>>
>>
> 
> I finally got to this issue again. I discovered that even without
> libunwind I can get decent traces from backtrace() on an i.MX6: I only
> have to compile our application with the -fasynchronous-unwind-tables
> option (as proposed by libunwind). As I'm not using libunwind, I also
> don't get segfaults anymore - yay. Fyi, we use the
> OSELAS.Toolchain-2011.11.3 toolchain.
> 

I picked your suggestion, turning on -fasynchronous-unwind-tables when 
building Xenomai, and including this flag in the compilation base flags 
emitted by xeno-config. Thanks.

-- 
Philippe.

