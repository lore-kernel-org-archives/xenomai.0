Subject: Re: rt_task_unblock() POSIX alternative
References: <20200407154117.5D7D71C2@centrum.cz>
 <20200408114406.6119E0D9@centrum.cz>
 <CAFLxGvx9-awne2He+ULqOzwf0cGae1s_k+-b8tdiM+uT67+cYg@mail.gmail.com>
 <20200409170009.5B0DAA77@centrum.cz>
 <CAFLxGvy8SP+4mr3PYYRHuxww=22w28RjaDPUgDSVFVHx-_cQ_g@mail.gmail.com>
 <20200409201057.74CB5ED0@centrum.cz>
 <CAFLxGvxuZw57FvaAQEAxseamoPhHdKX7wfZoaZxKskgeXa4V9g@mail.gmail.com>
 <20200414101600.F9AA555D@centrum.cz>
 <CAFLxGvz7ewnVv57QiEfCG76tjGcJ5v9KSg0QNHwtMa0Hihp_dQ@mail.gmail.com>
 <20200414111059.39716137@centrum.cz>
 <CAFLxGvx4qs8ONbaiU37rFNqXy=n8Hat_p-V7fLAAxgskbuU_GA@mail.gmail.com>
 <6b8c89d1-bae0-90f5-4935-925fb0af2137@siemens.com>
 <CAFLxGvzkubcKhrzWvHQqQ6Stv4xD=LU2k6Uvhymk=YKHpKt91w@mail.gmail.com>
 <da711d20-6897-3a80-d327-2f054c8bdd88@siemens.com>
 <CAFLxGvyoGbnQULdswrikMg-tBetnq-UA5fn_0jqQd1BLgH2U6A@mail.gmail.com>
 <50cc036c-3afd-5afd-8c94-3bdfa9d7aa6c@siemens.com>
 <CAFLxGvyhPEskS+QfD4QUQXYLRDvYN2QZXma73AMrwF3+0-roqQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <6a6aed9a-c2af-f498-4e27-bde61646a395@siemens.com>
Date: Tue, 14 Apr 2020 13:01:58 +0200
MIME-Version: 1.0
In-Reply-To: <CAFLxGvyhPEskS+QfD4QUQXYLRDvYN2QZXma73AMrwF3+0-roqQ@mail.gmail.com>
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
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: =?UTF-8?Q?Petr_=c4=8cervenka?= <grugh@centrum.cz>, Xenomai <xenomai@xenomai.org>

On 14.04.20 12:56, Richard Weinberger wrote:
> On Tue, Apr 14, 2020 at 12:44 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> 
>>> While we are here, is there a guarantee that rt_task_unblock() can unblock
>>> a thread in every situation?
>>> I have a large Xenomai 2 application on my desk which seems to assumes that.
>>
>> IIRC, it does so for the native/alchemy API.
>>
>>>
>>> As far as I understand it, unblocking tasks is best effort.
>>> /me has pthread_mutex_lock() in mind which must not return -EINTR as
>>> required by POSIX.
>>>
>>
>> Well, when mixing APIs, you can end up in such conflicting goals, indeed.
> 
> I fear more about Xenomai internals which are now based on POSIX APIs.
> IIRC we talked regarding this issue some time ago.
> 
> Found the mail:
> https://www.xenomai.org/pipermail/xenomai/2019-July/041221.html

Indeed, there is a todo...

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

