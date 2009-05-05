Date: Tue, 05 May 2009 10:22:58 +0200
From: "Petr Cervenka" <grugh@domain.hid>
MIME-Version: 1.0
Message-ID: <200905051022.9846@domain.hid>
References: <200905041613.30996@domain.hid> <200905041614.26154@domain.hid>
	<200905041811.11867@domain.hid> <49FF15ED.1010008@domain.hid>
In-Reply-To: <49FF15ED.1010008@domain.hid>
Content-Type: multipart/mixed; boundary="-------=_785F1F04.755F13F6"
Subject: Re: [Xenomai-help] rtdm_event_timedwait returns -EINTR
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format

---------=_785F1F04.755F13F6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

From: gilles.chanteperdrix@xenomai.org
>Petr Cervenka wrote:

>> I have found following problems / errors: 
>> -------------------------------------------------------------- 1)
>> rtdm_event_timedwait() in ioctl handler is not automatically
>> internally restarted (driver: rtdm, app. tasks: native)
>
>That is because rtdm_event_timedwait is not a syscall. It is a
>kernel-space call. Your job is to get ioctl to return -EINTR when
>rtdm_event_timedwait returns -EINTR, so that ioctl will be restarted in
>user-space.
>
>This is undocumented, because you should already know about that if you
>have done a little driver work under linux.
>

Finally I start to understand it. Sorry, but I wrote only couple of drivers. With 
knowledge of hardware but not linux.

>> 
>> 2) computer hangs, when I call in ioctl handler something like: do { 
>> res = rtdm_event_timedwait(&event, timeout, NULL); } while (res ==
>> -EINTR); this could have perhaps some relevance:
>> https://mail.gna.org/public/xenomai-help/2008-11/msg00025.html
>
>That is because you should return to user-space to get the signal handled.
>

So it is better to divide longer operation with device (for example initialization) 
into two ioctls. First one for registry settings and second one for waiting for 
ready state. Or am I wrong?

>> 
>> 3) rt_event_wait() in application is restarted always with the same
>> relative timeout. it could run forever.
>
>Yes, we know that, and we know a fix. But another fix is to use the new
>*_until calls.
>
>> 
>> problems with version 2.5-rc1: 
>> ----------------------------------------------- 1) function
>> rt_task_shadow always returns -EFAULT
>
>Could you provide us with a small example which has this problem ?
>

Example is in the attachment.

>> 
>> 2) when resizing window with latency test running, it prints out "Not
>> SIGSHADOW !". But it should be SIGSHADOW (in my opinion).
>
>"Not SIGSHADOW!" is printed when the SIGWINCH signal handler identifies
>a SIGWINCH not originating from Xenomai. And when you resize the window,
>a SIGWINCH is sent to the application which originates from the Linux
>kernel, not from Xenomai. So, the "Not SIGSHADOW!" is correct. However,
>it is essentially a debug message
>

Oh, it my fault. When I identified these signals as SIGWINCH, I automatically 
assumed that it's SIGHARDEN. I completely forgot to look at the basic mean 
of SIGWINCH signal. I feel little ashamed.

Petr


---------=_785F1F04.755F13F6
Content-Type: text/x-c++src; name="main.cpp"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN5cy9tbWFuLmg+CiNpbmNsdWRlIDxuYXRpdmUvdGFzay5oPgojaW5jbHVk
ZSA8bmF0aXZlL2V2ZW50Lmg+CiNpbmNsdWRlIDxuYXRpdmUvdGltZXIuaD4KCiNkZWZpbmUg
TVlfRVZFTlQgICAgMHgwMDAwMDAwMWxsCiNkZWZpbmUgTVlfUFJJT1JJVFkgOTkKCnN0YXRp
YyBSVF9UQVNLIG1haW5UYXNrOwoKaW50IG1haW4oaW50IGFyZ2MsIGNoYXIqKiBhcmd2KSB7
CiAgICBjb25zdCBkb3VibGUgT05FX1NFQyA9IDFlOTsKICAgIGNvbnN0IFJUSU1FIHRpbWVv
dXQgPSAoUlRJTUUpKDUgKiBPTkVfU0VDKTsKICAgIFJUX0VWRU5UIGV2ZW50OwogICAgdW5z
aWduZWQgbG9uZyBtYXNrOwogICAgUlRJTUUgc3RhcnQsIGVuZDsKICAgIGludCByZXM7Cgog
ICAgbWxvY2thbGwoTUNMX0NVUlJFTlQgfCBNQ0xfRlVUVVJFKTsKCiAgICByZXMgPSBydF90
YXNrX3NoYWRvdygmbWFpblRhc2ssICJtYWluX3Rhc2siLCBNWV9QUklPUklUWSwgMCk7CiAg
ICBpZiAocmVzIDwgMCkgewogICAgICAgIHByaW50ZigicnRfdGFza19zaGFkb3coKTogJWQg
KCVzKVxuIiwgcmVzLCBzdHJlcnJvcigtcmVzKSk7CiAgICB9CgogICAgcmVzID0gcnRfdGFz
a19zZXRfbW9kZSgwLCBUX1BSSU1BUlksIE5VTEwpOwogICAgaWYgKHJlcyA8IDApIHsKICAg
ICAgICBwcmludGYoInJ0X3Rhc2tfc2V0X21vZGUoKTogJWQgKCVzKVxuIiwgcmVzLCBzdHJl
cnJvcigtcmVzKSk7CiAgICB9CgogICAgcmVzID0gcnRfZXZlbnRfY3JlYXRlKCZldmVudCwg
TlVMTCwgMCwgRVZfUFJJTyk7CiAgICBpZiAocmVzIDwgMCkgewogICAgICAgIHByaW50Zigi
cnRfZXZlbnRfY3JlYXRlKCk6ICVkICglcylcbiIsIHJlcywgc3RyZXJyb3IoLXJlcykpOwog
ICAgfQoKICAgIHN0YXJ0ID0gcnRfdGltZXJfcmVhZCgpOwogICAgcmVzID0gcnRfZXZlbnRf
d2FpdCgmZXZlbnQsIE1ZX0VWRU5ULCAmbWFzaywgRVZfQUxMLCBydF90aW1lcl9uczJ0aWNr
cyh0aW1lb3V0KSk7CiAgICBlbmQgPSBydF90aW1lcl9yZWFkKCk7CiAgICAKICAgIGlmIChy
ZXMgPCAwICYmIHJlcyAhPSAtRVRJTUVET1VUKSB7CiAgICAgICAgcHJpbnRmKCJydF9ldmVu
dF93YWl0KCk6ICVkICglcylcbiIsIHJlcywgc3RyZXJyb3IoLXJlcykpOwogICAgfQoKICAg
IHByaW50ZigidGltZSAtIG1lYXN1cmVkICVnIHMsIHdhbnRlZCAlZyBzXG4iLCBydF90aW1l
cl90aWNrczJucyhlbmQgLSBzdGFydCkvT05FX1NFQywgdGltZW91dC9PTkVfU0VDKTsKICAg
IAogICAgcmVzID0gcnRfZXZlbnRfZGVsZXRlKCZldmVudCk7CiAgICBpZiAocmVzIDwgMCkg
ewogICAgICAgIHByaW50ZigicnRfZXZlbnRfZGVsZXRlKCk6ICVkICglcylcbiIsIHJlcywg
c3RyZXJyb3IoLXJlcykpOwogICAgfQoKICAgIHJldHVybiAwOwp9Cg==

---------=_785F1F04.755F13F6--

