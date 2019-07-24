Subject: Re: prepare-kernel.sh
References: <0817b60a-3a5c-3cae-475d-ce78dd89ef10@iit.it>
 <37669207-8db8-9ec0-6f84-52e15a4cab3e@siemens.com>
From: hauptmech <hauptmech@gmail.com>
Message-ID: <2862bfb5-21c3-c51e-fc82-760bc8137352@gmail.com>
Date: Wed, 24 Jul 2019 14:38:57 +1200
MIME-Version: 1.0
In-Reply-To: <37669207-8db8-9ec0-6f84-52e15a4cab3e@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I just ran into this problem as well. It wasn't until a kernel build 
failed part way through and I did a bit of googling that I figured out 
to guess which kernel version would work with which branch by reading 
the git comments.

It would be useful to add a known good ipipe/kernel version combo for 
the stable branch to 
https://gitlab.denx.de/Xenomai/xenomai/wikis/Start_Here#user-content-gathering-the-linux-kernel-bits

Or if this is considered too much of a moving target, a note in the same 
place to read the git commit comments and what to look for to identify 
which kernel is likely good.

-Hauptmech

On 24/07/2019 1:44 AM, Jan Kiszka via Xenomai wrote:
> On 23.07.19 14:37, alessio margan via Xenomai wrote:
>> Hi all,
>>
>> I got this error when trying to configure the kernel 4.19.57 with the procedure
>> that I used so far.
>>
>> Is there something new that I miss
>>
>> (base) embedded@com-exp:/usr/local/src/xenomai.git(stable/v3.0.x)$
> 4.19 requires Xenomai master.
>
> Jan
>


