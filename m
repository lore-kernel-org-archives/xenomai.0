Message-ID: <48CE7E8D.6000301@domain.hid>
Date: Mon, 15 Sep 2008 17:26:05 +0200
From: Harco Kuppens <h.kuppens@domain.hid>
MIME-Version: 1.0
References: <48CE3096.7040502@domain.hid> <48CE6E48.6030808@domain.hid>
In-Reply-To: <48CE6E48.6030808@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------010506020201080508090701"
Subject: Re: [Xenomai-help] probably error in api document
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

This is a multi-part message in MIME format.
--------------010506020201080508090701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

yeah, that is what I read but the documenation for the kernel space 
version of rt_int_create also says that it can be called from a user 
space task. I think that is a mistake in the documentation.

best regards
Harco Kuppens

Gilles Chanteperdrix wrote:
> Harco Kuppens wrote:
>   
>> Hi,
>>
>> I noticed in the Xenomai native API that  the longer rt_create_intr :
>>
>>     int rt_intr_create 
>> <http://www.xenomai.org/documentation/trunk/html/api/group__interrupt.html#ga0a9d98556ec838008f408a56e79d304> 
>> (RT_INTR *intr, const char *name, unsigned irq, rt_isr_t isr, rt_iack_t 
>> iack, int mode)
>>
>> says in its documentation :
>>
>>     This service can be called from:
>>
>>         * Kernel module initialization/cleanup code
>>         * Kernel-based task
>>         * *User-space task*
>>
>> I find it strange that it could be called from a user-space task.
>> I looked in /usr/xenomai/include/native/intr.h but there it really is 
>> defined when __KERNEL__ is defined.
>>
>> So I guess this is an error in the  API documention?
>>     
>
> No, there is no error: the service is implemented both in user-space and
>  kernel-space, and if you look at native/intr.h, you will see two
> definitions of rt_intr_create: one for kernel-space and one for user-space.
>
> Note however that the interface in user-space is not the same as in
> kernel-space, that is because in user-space, you are supposed to call
> rt_intr_wait to wait for the next interrupt.
>   



--------------010506020201080508090701
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
yeah, that is what I read but the documenation for the kernel space
version of rt_int_create also says that it can be called from a user
space task. I think that is a mistake in the documentation.<br>
<br>
best regards<br>
Harco Kuppens<br>
<br>
Gilles Chanteperdrix wrote:
<blockquote cite="mid:48CE6E48.6030808@domain.hid" type="cite">
  <pre wrap="">Harco Kuppens wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hi,

I noticed in the Xenomai native API that  the longer rt_create_intr :

    int rt_intr_create 
<a class="moz-txt-link-rfc2396E"
 href="http://www.xenomai.org/documentation/trunk/html/api/group__interrupt.html#ga0a9d98556ec838008f408a56e79d304">&lt;http://www.xenomai.org/documentation/trunk/html/api/group__interrupt.html#ga0a9d98556ec838008f408a56e79d304&gt;</a> 
(RT_INTR *intr, const char *name, unsigned irq, rt_isr_t isr, rt_iack_t 
iack, int mode)

says in its documentation :

    This service can be called from:

        * Kernel module initialization/cleanup code
        * Kernel-based task
        * *User-space task*

I find it strange that it could be called from a user-space task.
I looked in /usr/xenomai/include/native/intr.h but there it really is 
defined when __KERNEL__ is defined.

So I guess this is an error in the  API documention?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
No, there is no error: the service is implemented both in user-space and
 kernel-space, and if you look at native/intr.h, you will see two
definitions of rt_intr_create: one for kernel-space and one for user-space.

Note however that the interface in user-space is not the same as in
kernel-space, that is because in user-space, you are supposed to call
rt_intr_wait to wait for the next interrupt.
  </pre>
</blockquote>
<br>
<br>
</body>
</html>

--------------010506020201080508090701--

