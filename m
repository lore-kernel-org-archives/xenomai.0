Message-ID: <7289437c0804030552q79d1bb84jf5f40d1a57a443b5@domain.hid>
Date: Thu, 3 Apr 2008 14:52:33 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <d6c8ef150804030300p3a4c719tca9903aa7663a5d9@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_1399_6029476.1207227153158"
References: <7289437c0804030246v7992ec23kedcc2c8b71dc14f8@domain.hid>
	<d6c8ef150804030300p3a4c719tca9903aa7663a5d9@domain.hid>
Subject: Re: [Xenomai-help] Question about rtdm_mmap_to_user()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

------=_Part_1399_6029476.1207227153158
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>Why don't you try rt_heap_* functions? Quick example:
>
>Kernel space:
>
>RT_HEAP heap_desc;
>void *shared;
>
>rt_heap_create (&heap_desc, "MySHM", 2048, H_SHARED);
>rt_heap_alloc (&heap_desc, 0, TM_NONBLOCK, &shared);
>[.. cleanup ..]
>rt_heap_delete (&heap_desc);
>User space:
>
>RT_HEAP heap_desc;
>void *shared;
>
>rt_heap_bind (&heap_desc, "MySHM", TM_NONBLOCK);
>rt_heap_alloc (&heap_desc, 0, TM_NONBLOCK, &shared);
>[..cleanup..]
>rt_heap_unbind (&heap_desc);

I tried exactly what you wrote. And it doesn't work. I have error -11. It
doesn't find the Heap I created in kernel space.
I don't understand why. I put exactly the same name.


On Thu, Apr 3, 2008 at 12:00 PM, Bosko Radivojevic <
bosko.radivojevic@domain.hid> wrote:

> Why don't you try rt_heap_* functions? Quick example:
>
> Kernel space:
>
> RT_HEAP heap_desc;
> void *shared;
>
> rt_heap_create (&heap_desc, "MySHM", 2048, H_SHARED);
> rt_heap_alloc (&heap_desc, 0, TM_NONBLOCK, &shared);
> [.. cleanup ..]
> rt_heap_delete (&heap_desc);
> User space:
>
> RT_HEAP heap_desc;
> void *shared;
>
> rt_heap_bind (&heap_desc, "MySHM", TM_NONBLOCK);
> rt_heap_alloc (&heap_desc, 0, TM_NONBLOCK, &shared);
> [..cleanup..]
> rt_heap_unbind (&heap_desc);
>
> ============================================
>
> Hope this helps :)
>

------=_Part_1399_6029476.1207227153158
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

&gt;Why don&#39;t you try rt_heap_* functions? Quick example:<br>
&gt;<br>&gt;Kernel space:<br>
&gt;<br>
&gt;RT_HEAP heap_desc;<br>
&gt;void *shared;<br>
&gt;<br>&gt;rt_heap_create (&amp;heap_desc, &quot;MySHM&quot;, 2048, H_SHARED);<br>
&gt;rt_heap_alloc (&amp;heap_desc, 0, TM_NONBLOCK, &amp;shared);<br>
&gt;[.. cleanup ..]<br>
&gt;rt_heap_delete (&amp;heap_desc);<br>&gt;User space:<br>
&gt;<br>
&gt;RT_HEAP heap_desc;<br>
&gt;void *shared;<br>
&gt;<br>
&gt;rt_heap_bind (&amp;heap_desc, &quot;MySHM&quot;, TM_NONBLOCK);<br>
&gt;rt_heap_alloc (&amp;heap_desc, 0, TM_NONBLOCK, &amp;shared);<br>
&gt;[..cleanup..]<br>
&gt;rt_heap_unbind (&amp;heap_desc);<br><br>I tried exactly what you wrote. And it doesn&#39;t work. I have error -11. It doesn&#39;t find the Heap I created in kernel space.<br>I don&#39;t understand why. I put exactly the same name.<br>
<br><br><div class="gmail_quote">On Thu, Apr 3, 2008 at 12:00 PM, Bosko Radivojevic &lt;<a href="mailto:bosko.radivojevic@domain.hid">bosko.radivojevic@domain.hid</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Why don&#39;t you try rt_heap_* functions? Quick example:<br>
<br>
Kernel space:<br>
<br>
RT_HEAP heap_desc;<br>
void *shared;<br>
<br>
rt_heap_create (&amp;heap_desc, &quot;MySHM&quot;, 2048, H_SHARED);<br>
rt_heap_alloc (&amp;heap_desc, 0, TM_NONBLOCK, &amp;shared);<br>
[.. cleanup ..]<br>
rt_heap_delete (&amp;heap_desc);<br>
User space:<br>
<br>
RT_HEAP heap_desc;<br>
void *shared;<br>
<br>
rt_heap_bind (&amp;heap_desc, &quot;MySHM&quot;, TM_NONBLOCK);<br>
rt_heap_alloc (&amp;heap_desc, 0, TM_NONBLOCK, &amp;shared);<br>
[..cleanup..]<br>
rt_heap_unbind (&amp;heap_desc);<br>
<br>
============================================<br>
<br>
Hope this helps :)<br>
</blockquote></div><br>

------=_Part_1399_6029476.1207227153158--

