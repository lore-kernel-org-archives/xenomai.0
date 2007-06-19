Message-ID: <b647ffbd0706190541m297ddb05kcc3028a6459dce90@domain.hid>
Date: Tue, 19 Jun 2007 14:41:27 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <4677C8A9.2010004@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <OF815057E3.6D5C9810-ONC12572FF.00287AFE-C12572FF.0028A289@domain.hid>
	<46778964.3070608@domain.hid>
	<b647ffbd0706190452g16e98684p13873b09f48eb185@domain.hid>
	<4677C8A9.2010004@domain.hid>
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
> Dmitry Adamushko wrote:
> > On 19/06/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> >> apittaluga@domain.hid wrote:
> >> > Hi,
> >> > running a simple test application which spawns a periodic task
> >> writing on a
> >> > serial interface
> >> > the system hangs performing the rt_dev_close.
> >> > The test program ran fine with xeno 2.2.6 with "Shared Interrupts"
> >> enabled,
> >> > so as with
> >> > xeno 2.3.1 with "Shared Interrupts" disabled. It fails with xeno
> >> 2.3.1 with
> >> > "Shared Interrupts" enabled, so the problem seems to be in the shared
> >> > interrupts handling area.
> >> > kernel is 2.6.20 adeos patched
> >> >
> >> > Any suggestion?
> >
> > Does the fix below eliminate the problem?
> >
> > The problem (allegedly) is cause by the following reinitialization at
> > the end of the loop:
> >
> > ...
> >                if (!(intr = intr->next))
> >                        intr = shirq->handlers;
> > ...
> >
> > 'end' may point to some of the elements ... and shirq->handlers may
> > become NULL (all elements have been deleted)..
>
> Good catch.
>
> >
> > (white-space damaged version.. enclosed a normal one)
> >
> > --- ksrc/nucleus/intr.c-orig    2007-06-19 13:44:55.090623404 +0200
> > +++ ksrc/nucleus/intr.c 2007-06-19 13:45:53.867440067 +0200
> > @@ -273,7 +273,7 @@ static void xnintr_edge_shirq_handler(un
> >        xnintr_shirq_lock(shirq);
> >        intr = shirq->handlers;
> >
> > -       while (intr != end) {
> > +       while (intr && intr != end) {
> >                int ret, code;
> >
> >                xnstat_runtime_switch(sched,
> >
> >
>
> But your patch looks incomplete: What if someone removes "end" but
> leaves other handlers behind while we are looping? Neither intr would
> then become NULL nor would we hit the end again. This seems to be more
> tricky...

Yeah.. what's about smth like this? (quick approach: if not ok, will
have to elaborate it thoroughly :-)


--- ksrc/nucleus/intr.c-orig    2007-06-19 13:44:55.090623404 +0200
+++ ksrc/nucleus/intr.c 2007-06-19 14:38:36.073535255 +0200
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
@@ -297,8 +297,14 @@ static void xnintr_edge_shirq_handler(un
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


>
> Jan
>

-- 
Best regards,
Dmitry Adamushko

