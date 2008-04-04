Message-ID: <7289437c0804040559u4deb2943m483ef6a6f78819a7@domain.hid>
Date: Fri, 4 Apr 2008 14:59:28 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <d6c8ef150804040018u1b4ed61eg6eccbf5257b88abf@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_5391_23725144.1207313969026"
References: <7289437c0804030246v7992ec23kedcc2c8b71dc14f8@domain.hid>
	<d6c8ef150804030300p3a4c719tca9903aa7663a5d9@domain.hid>
	<7289437c0804030552q79d1bb84jf5f40d1a57a443b5@domain.hid>
	<d6c8ef150804040018u1b4ed61eg6eccbf5257b88abf@domain.hid>
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
To: Bosko Radivojevic <bosko.radivojevic@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

------=_Part_5391_23725144.1207313969026
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>Except that the example listed in the document in question takes care of
>defining the heap descriptor in global memory, not in the init_module()
stack.


It effectively works better with the RT_HEAP variable in global scope.

I thought that the RT_HEAP variable was working like handles or descriptors
in some RTOS where the life cycle of the descriptor is not correlated to the
Os Object life cycle, that is to say:

  => enter local scope           {
                                 handle myHandle =
CreateOsObject(x,y,z,&err);  // or err =  CreateOsObject(&myHandle,x,y,z);
  => exit local scope             }

When you go out of the local scope, you can no more use the handle (and then
reference the created OS object ) because it was a local variable but the
object created is still alive and will not be modified because the handle
was declared on the stack. So I thought that the RT_HEAP variable was just a
descriptor of a Heap object managed by xenomai but not the heap object
itself.

Best Regards,
Perrine


On Fri, Apr 4, 2008 at 9:18 AM, Bosko Radivojevic <
bosko.radivojevic@domain.hid> wrote:

> On Thu, Apr 3, 2008 at 2:52 PM, Perrine Martignoni <perrmart@domain.hid>
> wrote:
>
> > >rt_heap_create (&heap_desc, "MySHM", 2048, H_SHARED);
> >  >rt_heap_alloc (&heap_desc, 0, TM_NONBLOCK, &shared);
> [..]
> > I tried exactly what you wrote. And it doesn't work. I have error -11.
> It
> > doesn't find the Heap I created in kernel space.
> > I don't understand why. I put exactly the same name.
>
> rt_heap_create() must be called from kernel module init function. Here
> is copy&paste from my code (with checking return values):
>
> kernel_module:
> ===========
>
> RT_HEAP heap_desc;
> void *shared_mem;
>
> int init_module (void)
> {
> int ret;
>
>  ret = rt_heap_create (&heap_desc, "MainSHM", 4*1024, H_SHARED);
>  if (ret) {
>    printk ("Error rt_heap_create: %d\n", ret);
>  }
>  ret = rt_heap_alloc (&heap_desc, 0, TM_NONBLOCK, &shared_mem);
>  if (ret) {
>    printk ("Error rt_heap_alloc: %d\n", ret);
>  }
>  printk ("4kB heap memory created, name: MainSHM\n");
>  return 1;
> }
>
> void cleanup_module(void)
> {
>  rt_heap_delete (&heap_desc);
> }
>

------=_Part_5391_23725144.1207313969026
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

&gt;Except that the example listed in the document in question takes care of<br>&gt;defining the heap descriptor in global memory, not in the init_module() stack.<br><br><br>It effectively works better with the RT_HEAP variable in global scope.<br>
<br>I thought that the RT_HEAP variable was working like handles or descriptors in some RTOS where the life cycle of the descriptor is not correlated to the Os Object life cycle, that is to say:<br>&nbsp;<br>&nbsp; =&gt; enter local scope&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handle myHandle = CreateOsObject(x,y,z,&amp;err);&nbsp; // or err =&nbsp; CreateOsObject(&amp;myHandle,x,y,z);<br>&nbsp; =&gt; exit local scope&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;<br>When you go out of the local scope, you can no more use the handle (and then reference the created OS object ) because it was a local variable but the object created is still alive and will not be modified because the handle was declared on the stack. So I thought that the RT_HEAP variable was just a descriptor of a Heap object managed by xenomai but not the heap object itself.<br>
<br>Best Regards, <br>Perrine<br><br><br><div class="gmail_quote">On Fri, Apr 4, 2008 at 9:18 AM, Bosko Radivojevic &lt;<a href="mailto:bosko.radivojevic@domain.hid">bosko.radivojevic@domain.hid</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">On Thu, Apr 3, 2008 at 2:52 PM, Perrine Martignoni &lt;<a href="mailto:perrmart@domain.hid">perrmart@domain.hid</a>&gt; wrote:<br>
<br>
&gt; &gt;rt_heap_create (&amp;heap_desc, &quot;MySHM&quot;, 2048, H_SHARED);<br>
&gt; &nbsp;&gt;rt_heap_alloc (&amp;heap_desc, 0, TM_NONBLOCK, &amp;shared);<br>
</div>[..]<br>
<div class="Ih2E3d">&gt; I tried exactly what you wrote. And it doesn&#39;t work. I have error -11. It<br>
&gt; doesn&#39;t find the Heap I created in kernel space.<br>
&gt; I don&#39;t understand why. I put exactly the same name.<br>
<br>
</div>rt_heap_create() must be called from kernel module init function. Here<br>
is copy&amp;paste from my code (with checking return values):<br>
<br>
kernel_module:<br>
===========<br>
<br>
RT_HEAP heap_desc;<br>
void *shared_mem;<br>
<br>
int init_module (void)<br>
{<br>
int ret;<br>
<br>
 &nbsp;ret = rt_heap_create (&amp;heap_desc, &quot;MainSHM&quot;, 4*1024, H_SHARED);<br>
 &nbsp;if (ret) {<br>
 &nbsp; &nbsp;printk (&quot;Error rt_heap_create: %d\n&quot;, ret);<br>
 &nbsp;}<br>
 &nbsp;ret = rt_heap_alloc (&amp;heap_desc, 0, TM_NONBLOCK, &amp;shared_mem);<br>
 &nbsp;if (ret) {<br>
 &nbsp; &nbsp;printk (&quot;Error rt_heap_alloc: %d\n&quot;, ret);<br>
 &nbsp;}<br>
 &nbsp;printk (&quot;4kB heap memory created, name: MainSHM\n&quot;);<br>
 &nbsp;return 1;<br>
}<br>
<br>
void cleanup_module(void)<br>
<div><div></div><div class="Wj3C7c">{<br>
 &nbsp;rt_heap_delete (&amp;heap_desc);<br>
}<br>
</div></div></blockquote></div><br>

------=_Part_5391_23725144.1207313969026--

