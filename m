Subject: Re: Question about rt_task_sleep and rt_alarm_start.
References: <CAAvDm6ajDfWc9ymVfdNAidyyPuStkRwD8FXXAz3NZwdoeG6gjA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <22bc5f17-7f81-4f00-e662-cb2e871e70cd@siemens.com>
Date: Mon, 18 May 2020 11:01:36 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6ajDfWc9ymVfdNAidyyPuStkRwD8FXXAz3NZwdoeG6gjA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>, xenomai <xenomai@xenomai.org>

On 14.05.20 08:22, 孙世龙 via Xenomai wrote:
> Hi，
>         Assuming that, there is a real time process which has only
> a single thread.It creates an object triggering an alarm routine
> at a specified time in the future.Then it triggers the alarm and
> has been put to sleep for *a long long duration* through calling
> to the *rt_task_sleep*.
> 
>       Will the routine be called when the alarm expires *again and again*?
>       Will the routine runs in the same thread with the main function?
> 
>       Thank you for your attention to this matter.
>       Look forward to hearing from you.
> 

Please ask your question referring to concrete code and services used. 
There are many APIs in Xenomai, and the pattern you want to build here 
is not yet clear to me.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

