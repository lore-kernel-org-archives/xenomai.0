Message-ID: <148f7f7281a9350172cbd5895a223c500582f36d.camel@sprinte.eu>
Subject: Re: rt_task_inquire() equivalent for POSIX ?
From: Julien Blanc <julien.blanc@sprinte.eu>
Date: Thu, 07 Nov 2019 08:56:24 +0100
In-Reply-To: <CAFc1U0voys1h1Rn09Dn57qXqyfYNiUhAOmmEqCZKNHeELdfHww@mail.gmail.com>
References: <CAFc1U0spXP+BXnLFspsBmOo9opGcFRUwDVoivLMvxJiBMwY_mA@mail.gmail.com>
 <44a798wn8y.fsf@be-well.ilk.org>
 <CAFc1U0voys1h1Rn09Dn57qXqyfYNiUhAOmmEqCZKNHeELdfHww@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pierre FICHEUX <pierre.ficheux@smile.fr>
Cc: Pierre FICHEUX via Xenomai <xenomai@xenomai.org>

Le jeudi 07 novembre 2019 à 06:47 +0100, Pierre FICHEUX via Xenomai a
écrit :
> I've tried it but got the pid of the "main" thread not the RT one
> (that's
> normal...).
> 

extern "C"
{
        int cobalt_thread_pid(pthread_t);
}

int tid = cobalt_thread_pid(pthread_self())

but i’m not sure what you mean by the cobalt thread id vs posix thread
id. IIRC they have the same value (ie, syscal(__NR_gettid) would give
the same value (for rt threads), maybe at the expense of a mode
switch).

Regards,

Julien Blanc


