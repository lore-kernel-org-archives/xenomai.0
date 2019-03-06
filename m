Subject: Re: Mixing cobalt and alchemy?
References: <CAFLxGvxXBx+7UWD0aySskKxbrZHjvTBmJNvCEdfoBgLQOACHcw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <bd50d09d-fe52-a7c5-c733-4d8ad50030bf@siemens.com>
Date: Wed, 6 Mar 2019 18:25:56 +0100
MIME-Version: 1.0
In-Reply-To: <CAFLxGvxXBx+7UWD0aySskKxbrZHjvTBmJNvCEdfoBgLQOACHcw@mail.gmail.com>
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
To: Richard Weinberger <richard.weinberger@gmail.com>, xenomai@xenomai.org

On 06.03.19 10:59, Richard Weinberger via Xenomai wrote:
> Hi!
> 
> I have a Xenomai 2.6 application which makes heavy usage of
> rt_dev_ioctl() and shadow threads
> with rt_task_shadow().
> 
> If I understand the new Xenomai 3 API correctly, rt_dev_ioctl() for
> userspace is gone and the cobalt wrappers should be used such that
> plain ioctl() calls will be routed through libcobalt.
> What I don't fully understand is how to mix these with the alchemy
> skin such that the application can use rt_task_shadow() and friends
> because the cobalt wrapper also wraps pthread_create().
> The application simply does not fully fit in either cobalt nor alchemy skins.
> 
> Is it legal to modify lib/cobalt/cobalt.wrappers to wrap only read/close/ioctl?
> Or can I directly issue cobalt syscalls from the application?
> 

You can do __RT(ioctl(...)), that's also what the transition kit (trank) does to 
provide rt_dev_ioctl.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

