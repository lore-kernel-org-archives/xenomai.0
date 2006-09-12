Message-ID: <b647ffbd0609121358v5b5bff80o6e4e08c859eb110a@domain.hid>
Date: Tue, 12 Sep 2006 22:58:26 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <1158091876.5020.8.camel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_207287_31632978.1158094706148"
References: <58168.129.217.4.64.1158067468.squirrel@domain.hid>
	<1158091876.5020.8.camel@domain.hid>
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

------=_Part_207287_31632978.1158094706148
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 12/09/06, Philippe Gerum <rpm@xenomai.org> wrote:
>
> On Tue, 2006-09-12 at 15:24 +0200, Nils Kemper wrote:
> > Hi,
> > I want to use Xenomai, but I get (sometimes, but everytime the same)
> > kernel-Oops just by running xeno-test:
> >
> > [..]
> > Xenomai: stopping native API services.
> > I-pipe: Domain Xenomai unregistered.
> > Xenomai: hal/x86 stopped.
> > Xenomai: real-time nucleus unloaded.
>
> Does the issue still pop up if you set the Xenomai nucleus as static
> (i.e. not as a module) in the kernel configuration?



Just a weird presupposition.

In __ipipe_dispatch_event()

  ipipe_lock_cpu(flags);

  start_domain = this_domain = ipipe_percpu_domain[cpuid];

  list_for_each_safe(pos,npos,&__ipipe_pipeline) {

                next_domain = list_entry(pos,struct ipipe_domain,p_link);

//...
                if (next_domain->evhand[event] != NULL) {
                        ipipe_percpu_domain[cpuid] = next_domain;
                        ipipe_unlock_cpu(flags);
(1)
                        propagate =
!next_domain->evhand[event](event,start_domain,data);

Does anything prevent another thread from preempting the current one at (1)
and making "next_domain" invalid?

then :

if next_domain == "rthal_domain" (aka Xenomai)  -  e.g. someone unloaded all
the modules.

then if it's static :

rthal_domain is still kind of a valid object - it's at least in a valid
memory region + evhand points to a valid function. It's even possible to
jump to the next element if the rthal_domain::fields were not cleared...

non-static :

the module image was unloaded, next_domain doesn't point to anything
reasonable.

Jan or Nils, what instructions does "objdump -d kernel/ipipe/core.o" show
for a given offset in the __ipipe_dispatch_event().

0xcd in case of Nils.

[<c013f158>] __ipipe_dispatch_event+0xcd/0xeb

?


-- 
Best regards,
Dmitry Adamushko

------=_Part_207287_31632978.1158094706148
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 12/09/06, <b class="gmail_sendername">Philippe Gerum</b> &lt;<a href="mailto:rpm@xenomai.org">rpm@xenomai.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Tue, 2006-09-12 at 15:24 +0200, Nils Kemper wrote:<br>&gt; Hi,<br>&gt; I want to use Xenomai, but I get (sometimes, but everytime the same)<br>&gt; kernel-Oops just by running xeno-test:<br>&gt;<br>&gt; [..]<br>&gt; Xenomai: stopping native API services.
<br>&gt; I-pipe: Domain Xenomai unregistered.<br>&gt; Xenomai: hal/x86 stopped.<br>&gt; Xenomai: real-time nucleus unloaded.<br><br>Does the issue still pop up if you set the Xenomai nucleus as static<br>(i.e. not as a module) in the kernel configuration?
</blockquote><div><br>
<br>
Just a weird presupposition.<br>
<br>
In __ipipe_dispatch_event() <br>
<br>
&nbsp; ipipe_lock_cpu(flags);<br>
<br>
&nbsp; start_domain = this_domain = ipipe_percpu_domain[cpuid];<br>
<br>
&nbsp; list_for_each_safe(pos,npos,&amp;__ipipe_pipeline) {<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
next_domain = list_entry(pos,struct ipipe_domain,p_link);<br>
<br>
//...<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
if (next_domain-&gt;evhand[event] != NULL) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
ipipe_percpu_domain[cpuid] = next_domain;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
ipipe_unlock_cpu(flags);<br>
(1)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
propagate = !next_domain-&gt;evhand[event](event,start_domain,data);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
Does anything prevent another thread from preempting the current one at (1) and making &quot;next_domain&quot; invalid?<br>
<br>
then :<br>
<br>
if next_domain == &quot;rthal_domain&quot; (aka Xenomai)&nbsp; -&nbsp; e.g. someone unloaded all the modules.<br>
<br>
then if it's static :<br>
<br>
rthal_domain is still kind of a valid object - it's at least in a valid
memory region + evhand points to a valid function. It's even possible
to jump to the next element if the rthal_domain::fields were not
cleared...<br>
<br>
non-static :<br>
<br>
the module image was unloaded, next_domain doesn't point to anything reasonable.<br>
<br>
Jan or Nils, what instructions does &quot;objdump -d kernel/ipipe/core.o&quot;
show for a given offset in the __ipipe_dispatch_event().&nbsp; <br>
<br>
0xcd in case of Nils.<br>
<br>
[&lt;c013f158&gt;] __ipipe_dispatch_event+0xcd/0xeb<br>
<br>
?<br>
</div></div><br>
<br>-- <br>Best regards,<br>Dmitry Adamushko<br>
<br>


------=_Part_207287_31632978.1158094706148--

