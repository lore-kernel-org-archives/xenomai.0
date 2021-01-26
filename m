Subject: Re: Look up all IDDP/XDDP labels in the registry from userspace
References: <CAPMj8MtS-vAssX+P8rywMUoFfs-DeCh_2f4sZts5Jk2Dk_rOEw@mail.gmail.com>
 <CAPMj8Mv8194p8qCPRgke=w+A14d9f9mf0P6OhR2k67Tqr=JUJw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8ebae193-88ec-e4b1-d86b-642a594ac7da@siemens.com>
Date: Tue, 26 Jan 2021 19:07:42 +0100
MIME-Version: 1.0
In-Reply-To: <CAPMj8Mv8194p8qCPRgke=w+A14d9f9mf0P6OhR2k67Tqr=JUJw@mail.gmail.com>
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
To: Sam Daniel <daniel.jacob.samuel@gmail.com>, xenomai@xenomai.org

On 25.01.21 22:07, Sam Daniel via Xenomai wrote:
> On Mon, Jan 25, 2021 at 12:20 PM Sam Daniel <daniel.jacob.samuel@gmail.com>
> wrote:
> 
>> Is it possible to look up from userspace code all of the IDDP/XDDP labels
>> that exist in the registry without leaving the primary domain?
>>
>> I have tried a few different ways of reading the contents of
>> /proc/xenomai/registry/rtipc/iddp. The inotify API causes mode switches (it
>> relies on select or poll), not to mention that inotify does not work well
>> with virtual filesystems. And using the C++ filesystem library to read the
>> contents of the directory also causes mode switches (filesystem
>> interactions).
>>
>> Is there a real-time API function that I can use to query these labels?
>>
> 
> C++ filesystem library is causing mode switches because of an mmap deep in
> its call stack, not because of "filesystem interactions" like I initially
> thought.
> 

What is the use case you need label listing from RT context for?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

