From: Giulio Moro <g.moro@qmul.ac.uk>
Date: Wed, 4 Apr 2018 19:45:52 +0000
Message-ID: <DB6PR0701MB24563E2E1A942ABBBBF69E65B5A40@DB6PR0701MB2456.eurprd07.prod.outlook.com>
References: <DB6PR0701MB2456B23A97C5A7498981FC29B5A40@DB6PR0701MB2456.eurprd07.prod.outlook.com>,
 <CALLqZ8Rv9PQLey6Z3eK5N7aJPBOv=ANym7uAkaeSwwRgmYCjLQ@mail.gmail.com>
In-Reply-To: <CALLqZ8Rv9PQLey6Z3eK5N7aJPBOv=ANym7uAkaeSwwRgmYCjLQ@mail.gmail.com>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] cobalt equivalent of rt_task_shadow()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

No, I have ported all the rest of the application to Cobalt (because of the=
 faster thread wakeup time), this is the last bit that is missing.
Thanks,
Giulio
________________________________________
From: Greg Gallagher <greg@embeddedgreg.com>
Sent: 04 April 2018 20:44
To: Giulio Moro
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai] cobalt equivalent of rt_task_shadow()

Do you still want to use the alchemy API?  rt_task_shadow is still
available in Xenomai 3

-Greg

On Wed, Apr 4, 2018 at 3:37 PM, Giulio Moro <g.moro@qmul.ac.uk> wrote:
> On Xenomai 2.6, native API, I used to run
>
>   rt_task_shadow(&thisTask, threadName, threadPriority, T_JOINABLE | T_FP=
U);
>
> Now I am using Cobalt on Xenomai 3 and I am looking for a drop-in replace=
ment.
>
> Going through the source of alchemy.c, copperplate/internal.c and cobalt/=
thread.c, it seems that rt_task_shadow() now is implemented by calling
>
>   pthread_setschedparam_ex(pthread_self(), SCHED_FIFO, &param_ex)
>
> where sched_param_ex param_ex.sched_priorirty =3D threadPriority
>
> Is that all that is needed to turn the current thread into a Xenomai thre=
ad of priority threadPriority?
> Perhaps followed by
>   __wrap_pthread_setname_np(pthread_self(), taskName);
> ?
>
> Thanks,
> Giulio
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

