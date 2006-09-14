Message-ID: <b647ffbd0609141512t47b1835em49c9873985aa5fb3@domain.hid>
Date: Fri, 15 Sep 2006 00:12:43 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <1158223595.5040.16.camel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_243979_19577059.1158271963193"
References: <58168.129.217.4.64.1158067468.squirrel@domain.hid>
	<1158091876.5020.8.camel@domain.hid>
	<b647ffbd0609121358v5b5bff80o6e4e08c859eb110a@domain.hid>
	<450727D1.6060203@domain.hid> <4507C49A.5070909@domain.hid>
	<b647ffbd0609140055t328fec1fi3b5d86da178d790e@domain.hid>
	<1158223595.5040.16.camel@domain.hid>
Subject: [Xenomai-core] Re: [Xenomai-help] Bad EIP kernel-Oops
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

------=_Part_243979_19577059.1158271963193
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
> The proper fix is to synchronize ipipe_catch_event(..., NULL) with the
> event dispatcher, so that any caller could legitimately assume that no
> subsequent call to the former handler will happen on any CPU after this
> service has returned. Since ipipe_unregister_domain() may already
> legitimately assume that all event handlers have been cleared using
> ipipe_catch_event() by the caller before proceeding, the issue would be
> solved.


That's I understand. I just said "a cleanup caller" which amongst other
things does ipipe_unregister_domain. Although, yep. The latter one is not
necessarily involved.

The difficult part is to refrain from masking the hw interrupts when
> running the event handlers for the sake of keeping short latencies
> (nothing would prevent those handlers to re-enable interrupts anyway).
> IOW, using a big stick like the critical inter-CPU lock is not the
> preferred option.


And it's not a good idea to get ipipe_catch_event() buzy spinning as (as I
understand) ipipe_dispatch_event() may take, in general, an unbounded amount
of time.

Ok, some more weird thoughts on top of my mind. I hope the idea is clear,
notwithstanding my description that can be not that clear but hey... it's a
late hour :)

----

ipipe_dispatch_event()
{

...

   ipipe_lock_cpu(flags);

   start_domain = this_domain = ipipe_percpu_domain[cpuid];

   list_for_each_safe(pos,npos,&__ipipe_pipeline) {

        next_domain = list_entry(pos,struct ipipe_domain,p_link);

+       event_handler = next_domain->evhand[event];

        if (next_domain->evhand[event] != NULL) {
                ipipe_percpu_domain[cpuid] = next_domain;
+               atomic_inc(&somewhere_stored->counter);
                ipipe_unlock_cpu(flags);

-               propagate =
!next_domain->evhand[event](event,start_domain,data);
+               propagate = !event_handler(...);

              ipipe_lock_cpu(flags);
+               if (atomic_dec(&somewhere_stored->counter) == 0)
+                               send_virtual_irq(virt_irq, EVENT_TYPE, arg);
// do it per interested domain
...
}

then ipipe_catch_event(..., NULL); should do something along the following
lines :

ipipe_catch_event()
{
...

        lock() ; // not sure, it's even necessary

        set ipd->evhand[event] to NULL;

        unlock();


        // gets blocked
        ipipe_get_synched(EVENT_TYPE, arg);

...
}

ipipe_gets_synched()
-  lock
-  if somewhere_stored->counter != 0
- adds a caller to some wait queue (impl. depends on domain)
- unlock

- gets blocked.


virtual_irq_handler()

- lock
- wakeup_all_blocked for a given EVENT_TYPE and domain
- unlock


-- 
Best regards,
Dmitry Adamushko

------=_Part_243979_19577059.1158271963193
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>
<div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>The proper fix is to synchronize ipipe_catch_event(..., NULL) with the<br>event dispatcher, so that any caller could legitimately assume that no
<br>subsequent call to the former handler will happen on any CPU after this<br>service has returned. Since ipipe_unregister_domain() may already<br>legitimately assume that all event handlers have been cleared using<br>ipipe_catch_event() by the caller before proceeding, the issue would be
<br>solved.</blockquote><div><br>
That's I understand. I just said &quot;a cleanup caller&quot; which amongst other
things does ipipe_unregister_domain. Although, yep. The latter one is
not necessarily involved.<br>
</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">The difficult part is to refrain from masking the hw interrupts when<br>running the event handlers for the sake of keeping short latencies
<br>(nothing would prevent those handlers to re-enable interrupts anyway).<br>IOW, using a big stick like the critical inter-CPU lock is not the<br>preferred option.</blockquote><div><br>
And it's not a good idea to get ipipe_catch_event() buzy spinning as
(as I understand) ipipe_dispatch_event() may take, in general, an
unbounded amount of time.<br>
<br>
Ok, some more weird thoughts on top of my mind. I hope the idea is
clear, notwithstanding my description that can be not that clear but
hey... it's a late hour :)<br>
<br>
----<br>
<br>
ipipe_dispatch_event()<br>
{<br>
<br>
...<br>
<br>
&nbsp;&nbsp; ipipe_lock_cpu(flags);<br>
<br>
&nbsp;&nbsp; start_domain = this_domain = ipipe_percpu_domain[cpuid];<br>
<br>
&nbsp;&nbsp; list_for_each_safe(pos,npos,&amp;__ipipe_pipeline) {<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next_domain = list_entry(pos,struct ipipe_domain,p_link);<br>
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; event_handler = next_domain-&gt;evhand[event];<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (next_domain-&gt;evhand[event] != NULL) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
ipipe_percpu_domain[cpuid] = next_domain;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
atomic_inc(&amp;somewhere_stored-&gt;counter);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ipipe_unlock_cpu(flags);<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
propagate = !next_domain-&gt;evhand[event](event,start_domain,data);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; propagate = !event_handler(...);<br>
<br>
</div></div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ipipe_lock_cpu(flags);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
if (atomic_dec(&amp;somewhere_stored-&gt;counter) == 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
send_virtual_irq(virt_irq, EVENT_TYPE, arg); // do it per interested
domain<br>
...<br>
}<br>
<br>
then ipipe_catch_event(..., NULL); should do something along the following lines :<br>
<br>
ipipe_catch_event()<br>
{<br>
...<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lock() ; // not sure, it's even necessary<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set ipd-&gt;evhand[event] to NULL;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unlock();<br>
<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // gets blocked<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ipipe_get_synched(EVENT_TYPE, arg);<br>
<br>
...<br>
}<br>
<br>ipipe_gets_synched()<br>
-&nbsp; lock<br>
-&nbsp; if somewhere_stored-&gt;counter != 0<br>
- adds a caller to some wait queue (impl. depends on domain)<br>
- unlock<br>
<br>
- gets blocked.<br>
<br>
<br>
virtual_irq_handler()<br>
<br>
- lock<br>
- wakeup_all_blocked for a given EVENT_TYPE and domain<br>
- unlock<br>
<br clear="all"><br>-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_243979_19577059.1158271963193--

