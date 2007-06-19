Message-ID: <b647ffbd0706190628u2661e54o8be4f6af2610b75@domain.hid>
Date: Tue, 19 Jun 2007 15:28:59 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <4677D352.9010205@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <OF815057E3.6D5C9810-ONC12572FF.00287AFE-C12572FF.0028A289@domain.hid>
	<46778964.3070608@domain.hid>
	<b647ffbd0706190452g16e98684p13873b09f48eb185@domain.hid>
	<4677C8A9.2010004@domain.hid>
	<b647ffbd0706190541m297ddb05kcc3028a6459dce90@domain.hid>
	<4677D352.9010205@domain.hid>
Subject: Re: [Xenomai-help] xeno-2.3.1 shared interrups BUG?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>, apittaluga@domain.hid

On 19/06/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> > [ ... ]
> >
> > --- ksrc/nucleus/intr.c-orig    2007-06-19 13:44:55.090623404 +0200
> > +++ ksrc/nucleus/intr.c 2007-06-19 14:38:36.073535255 +0200
> > @@ -259,7 +259,7 @@ static void xnintr_edge_shirq_handler(un
> >        xnstat_runtime_t *prev;
> >        xnticks_t start;
> >        xnintr_shirq_t *shirq = &xnshirqs[irq];
> > -       xnintr_t *intr, *end = NULL;
> > +       xnintr_t *intr, *end = NULL, *old_end = NULL;
> >        int s = 0, counter = 0;
> >
> >        xnarch_memory_barrier();
> > @@ -273,7 +273,7 @@ static void xnintr_edge_shirq_handler(un
> >        xnintr_shirq_lock(shirq);
> >        intr = shirq->handlers;
> >
> > -       while (intr != end) {
> > +       while (intr && intr != end) {
> >                int ret, code;
> >
> >                xnstat_runtime_switch(sched,
> > @@ -297,8 +297,14 @@ static void xnintr_edge_shirq_handler(un
> >                if (counter++ > MAX_EDGEIRQ_COUNTER)
> >                        break;
> >
> > -               if (!(intr = intr->next))
> > +               if (!(intr = intr->next)) {
> >                        intr = shirq->handlers;
> > +
> > +                       /* 'end' has been removed in the mean time. */
> > +                       if (end && old_end == end)
> > +                               intr = NULL;
> > +                       old_end = end;
> > +               }
>
> "end" may still remain stuck on an xnintr object that was removed.
> Unless some other element becomes "end" while continuing with the chain,
> I don't see a way out of this loop.

But that's why 'old_end == end'.. i.e. if we finished iteration over
all the handlers and on the current iteration N 'end' is the same as
it was on iteration N-1 .. --- 'end' has been (probably) removed..
although, 'old_end' should be cleared when 'end' changes.. hum?

IOW, it catches a moment when the full iteration took place and 'end'
is the same as it was on iteration N-1.. moreover, 'end' has _not_
changed during iteration N.

at the same time,

...
while (intr && intr != end) {
...

did't took place so 'end' is invalid.. we set 'intr = NULL' and the loop ends.

I'll take a closer look later but I think it should work. Although,
maybe I just can't sanely estimate whole ugliness of this fix at the
moment :-)



-


--- ksrc/nucleus/intr.c-orig    2007-06-19 13:44:55.090623404 +0200
+++ ksrc/nucleus/intr.c 2007-06-19 15:17:55.787849783 +0200
@@ -259,7 +259,7 @@ static void xnintr_edge_shirq_handler(un
        xnstat_runtime_t *prev;
        xnticks_t start;
        xnintr_shirq_t *shirq = &xnshirqs[irq];
-       xnintr_t *intr, *end = NULL;
+       xnintr_t *intr, *end = NULL, *old_end = NULL;
        int s = 0, counter = 0;

        xnarch_memory_barrier();
@@ -273,7 +273,7 @@ static void xnintr_edge_shirq_handler(un
        xnintr_shirq_lock(shirq);
        intr = shirq->handlers;

-       while (intr != end) {
+       while (intr && intr != end) {
                int ret, code;

                xnstat_runtime_switch(sched,
@@ -291,14 +291,22 @@ static void xnintr_edge_shirq_handler(un
                                &intr->stat[xnsched_cpu(sched)].account,
                                start);
                        start = xnstat_runtime_now();
-               } else if (code == XN_ISR_NONE && end == NULL)
+               } else if (code == XN_ISR_NONE && end == NULL) {
                        end = intr;
+                       old_end = NULL;
+               }

                if (counter++ > MAX_EDGEIRQ_COUNTER)
                        break;

-               if (!(intr = intr->next))
+               if (!(intr = intr->next)) {
                        intr = shirq->handlers;
+
+                       /* 'end' has been removed in the mean time. */
+                       if (end && old_end == end)
+                               intr = NULL;
+                       old_end = end;
+               }
        }

        xnintr_shirq_unlock(shirq);



-- 
Best regards,
Dmitry Adamushko

