Subject: Re: rt_task_inquire() equivalent for POSIX ?
References: <CAFc1U0spXP+BXnLFspsBmOo9opGcFRUwDVoivLMvxJiBMwY_mA@mail.gmail.com>
From: Steve Freyder <steve@freyder.net>
Message-ID: <5DC3CFFC.4060701@freyder.net>
Date: Thu, 7 Nov 2019 02:04:12 -0600
MIME-Version: 1.0
In-Reply-To: <CAFc1U0spXP+BXnLFspsBmOo9opGcFRUwDVoivLMvxJiBMwY_mA@mail.gmail.com>
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
To: Pierre FICHEUX <pierre.ficheux@smile.fr>
Cc: xenomai <xenomai@xenomai.org>

On 11/6/2019 3:04 PM, Pierre FICHEUX via Xenomai wrote:
> Hi,
>
> Is there a way to get the Xenomai thread "pid" with POSIX API ? I didn't
> see anything in the "thread management" section.
>
> thx
>
Hi,

This file:

https://xenomai.org/documentation/xenomai-3/pdf/xeno3prm.pdf

makes several references to pthread_self() which implies that's the way 
to do what you are looking for here.

However (to your point), it doesn't explicitly document (in section 6.60 
Thread management) pthread_self() itself, whereas this file:

https://xenomai.org/documentation/xenomai-2.6/pdf/posix-api.pdf

in section 3.12.3 documents pthread_self() along with pthread_create() 
and the other "POSIX thread management" functions.

Perhaps when the 3.0 documentation was written, there was a decision 
made to not document any of the "standard POSIX thread management" 
functions unless there was also an RT variant of the function (sitting 
behind a wrapper) which had behaviour beyond what one could expect to 
find in the standard (non RT) POSIX documentation.  Perhaps there's a 
statement to that effect somewhere in the Xenomai-3 documentation, and 
if not, maybe there should be.

Regards,
Steve


