Subject: Re: rt_task_inquire() equivalent for POSIX ?
References: <CAFc1U0spXP+BXnLFspsBmOo9opGcFRUwDVoivLMvxJiBMwY_mA@mail.gmail.com>
 <44a798wn8y.fsf@be-well.ilk.org>
 <CAFc1U0voys1h1Rn09Dn57qXqyfYNiUhAOmmEqCZKNHeELdfHww@mail.gmail.com>
 <148f7f7281a9350172cbd5895a223c500582f36d.camel@sprinte.eu>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <956fff32-9301-4b91-14b7-b2583f12508c@xenomai.org>
Date: Thu, 7 Nov 2019 09:44:51 +0100
MIME-Version: 1.0
In-Reply-To: <148f7f7281a9350172cbd5895a223c500582f36d.camel@sprinte.eu>
Content-Type: text/plain; charset="utf-8"
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
To: Julien Blanc <julien.blanc@sprinte.eu>, Pierre FICHEUX <pierre.ficheux@smile.fr>
Cc: Pierre FICHEUX via Xenomai <xenomai@xenomai.org>

On 2019-11-07 08:56, Julien Blanc via Xenomai wrote:
> Le jeudi 07 novembre 2019 à 06:47 +0100, Pierre FICHEUX via Xenomai a
> écrit :
>> I've tried it but got the pid of the "main" thread not the RT one
>> (that's
>> normal...).
>>
> 
> extern "C"
> {
>         int cobalt_thread_pid(pthread_t);
> }
> 
> int tid = cobalt_thread_pid(pthread_self())
> 
> but i’m not sure what you mean by the cobalt thread id vs posix thread
> id. IIRC they have the same value (ie, syscal(__NR_gettid) would give
> the same value (for rt threads), maybe at the expense of a mode
> switch).

This may be worth a read for context:
http://man7.org/linux/man-pages/man2/gettid.2.html

cobalt_thread_pid() translates POSIX thread identifiers to kernel thread identifiers some Linux-specific calls need (e.g. thread-directed signals).

-- 
Philippe.

