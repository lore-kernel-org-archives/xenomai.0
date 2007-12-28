Message-ID: <8b3b30860712271747q32660c8fvede9b0f637575259@domain.hid>
Date: Fri, 28 Dec 2007 02:47:19 +0100
From: "Racconico Lambrati" <racconico.lambrati@domain.hid>
In-Reply-To: <8b3b30860712271741q46bd1d7bx9c8548013affd024@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_13204_11847156.1198806439343"
References: <8b3b30860712270704o1a7d0cbahe97a4e90e9455cbc@domain.hid>
	<2ff1a98a0712270815r30b5e19eycf6fb44224d2ea83@domain.hid>
	<8b3b30860712271005i3e4f9eb6t4ad35205c0117b9a@domain.hid>
	<18291.60209.715762.159719@domain.hid>
	<8b3b30860712271028p12db5801mb156e6d58a01008f@domain.hid>
	<8b3b30860712271035s24933c63wf981b32dcf5b4a7b@domain.hid>
	<47740B5A.7070601@domain.hid>
	<8b3b30860712271741q46bd1d7bx9c8548013affd024@domain.hid>
Subject: Re: [Xenomai-help] update from fusion 0.9.1 to xenomai 2.4.0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_13204_11847156.1198806439343
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2007/12/27, Philippe Gerum <rpm@xenomai.org>:
>
> Racconico Lambrati wrote:
> >
> > How can I run it in kernel space?
> > The application is designed to be little and stable, and with fusion
> > 0.9.1 run without problem
> >
>
> If your application based on 0.9.1 used to run in user-space, then it
> must have been based on the UVM support. This support has been dismissed
> since Xenomai v2.3-rc1, because it was a temporary hack allowing
> user-space development until all skins have a real user-space interface,
> which is now the case.


murphy's law  could be applied here! I use uvm

The services you mention are now only available from the kernel-based
> interface, provided by the xeno_vxworks.ko module, because they do not
> make sense from a userland perspective.


then is it possible to create a kernel-based application with vxworks skins?
How can i do it?
I use "$(xeno-config --uvm-ldflags) -lvxworks -lrtai -lm" as LDFLAGS option.

Userland applications based on the VxWorks API
> (/usr/xenomai/lib/libvxworks.so) should not need them at all. If for
> some reason they do, then you should consider splitting the application
> in two parts, one kernel-based, the other one running in userland. The
> point is that dealing with interrupts should most often remain a kernel
> business, and this obviously also applies to interposing on the tick
> timer.


I've alredy done, using rt_pipe to make a communication line to a non-RT
application and my RT application.

If your application was not based on the UVM, then it must have been
> running embodied into a kernel module, in which case the issue is
> already solved.


This is not my case

Rehashing what Gilles already told you: until you actually explain _why_
> you need such services, nobody will be able to suggest any solution to
> your problem, I'm afraid.
>
> --
> Philippe.
>

The application use intLock and intUnlock first of all to handle a CAN
device.
I use it also to handle a timers array. when I delete a timers from an array
I disable the interrupt to avoid some race condition's problem (maybe a
timer that is going to be delete wake up during it's deleting routine).

I use SysClkConnect to hang the clock to a function that send the Give
signal to a semaphore every 'n' cycle.

the semaphore is used to give the start to a function that handle the most
important duty of the system, then when it term it cycle, it send the Give
signal to a second semaphore that will launch a second task that manage the
lesser important things.

This is an overview of my software. there aren't many other thing, only the
processing of the data received from CAN device, that is a lot of code but
it don't need the realtime services. this code is executed in the first task


I hope you understand my needs (my English is not so good).


Now I want understand the possible solution to my problem.

------=_Part_13204_11847156.1198806439343
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<span class="gmail_quote"></span><br><div><span class="gmail_quote">2007/12/27, Philippe Gerum &lt;<a href="mailto:rpm@xenomai.org" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">rpm@xenomai.org</a>
&gt;:</span><span class="q"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Racconico Lambrati wrote:<br>&gt;<br>&gt; How can I run it in kernel space?<br>&gt; The application is designed to be little and stable, and with fusion<br>&gt; 0.9.1 run without problem<br>&gt;<br><br>If your application based on 
0.9.1 used to run in user-space, then it<br>must have been based on the UVM support. This support has been dismissed<br>since Xenomai v2.3-rc1, because it was a temporary hack allowing<br>user-space development until all skins have a real user-space interface,
<br>which is now the case.</blockquote></span><div><br>murphy&#39;s law&nbsp; could be applied here! I use uvm<br></div><span class="q"><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

The services you mention are now only available from the kernel-based<br>interface, provided by the xeno_vxworks.ko module, because they do not<br>make sense from a userland perspective.</blockquote></span><div><br>then is it possible to create a kernel-based application with vxworks skins? How can i do it?
<br>I use &quot;$(xeno-config --uvm-ldflags) -lvxworks -lrtai -lm&quot; as LDFLAGS option.<br></div><span class="q"><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

Userland applications based on the VxWorks API<br>(/usr/xenomai/lib/libvxworks.so) should not need them at all. If for<br>some reason they do, then you should consider splitting the application<br>in two parts, one kernel-based, the other one running in userland. The
<br>point is that dealing with interrupts should most often remain a kernel<br>business, and this obviously also applies to interposing on the tick timer.</blockquote></span><div><br>I&#39;ve alredy done, using rt_pipe to make a communication line to a non-RT application and my RT application.
<br></div><span class="q"><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">If your application was not based on the UVM, then it must have been
<br>running embodied into a kernel module, in which case the issue is
<br>already solved.</blockquote></span><div><br>This is not my case<br></div><span class="q"><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Rehashing what Gilles already told you: until you actually explain _why_
<br>you need such services, nobody will be able to suggest any solution to<br>your problem, I&#39;m afraid.<br><br>--<br>Philippe.<br></blockquote></span></div><br>The application use intLock and intUnlock first of all to handle a CAN device.
<br>I use it also to handle a timers array. when I delete a timers from an array I disable the interrupt to avoid some race condition&#39;s problem (maybe a timer that is going to be delete wake up during it&#39;s deleting routine).
<br><br>I use SysClkConnect to hang the clock to a function that send the Give signal to a semaphore every &#39;n&#39; cycle.<br><br>the semaphore is used to give the start to a function that handle the most important duty of the system, then when it term it cycle, it send the Give signal to a second semaphore that will launch a second task that manage the lesser important things.
<br><br>This is an overview of my software. there aren&#39;t many other thing, only the processing of the data received from CAN device, that is a lot of code but it don&#39;t need the realtime services. this code is executed in the first task
<br><br>I hope you understand my needs (my English is not so good).<br><br><br>Now I want understand the possible solution to my problem.<br>

------=_Part_13204_11847156.1198806439343--

