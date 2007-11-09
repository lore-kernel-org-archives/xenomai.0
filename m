Message-ID: <47348E85.5000406@domain.hid>
Date: Fri, 09 Nov 2007 11:44:53 -0500
From: "Steven A. Falco" <sfalco@domain.hid>
MIME-Version: 1.0
References: <473391B0.5040809@domain.hid> <4733A2B8.8070100@domain.hid>
	<47344759.4020505@domain.hid> <473484C6.6050101@domain.hid>
In-Reply-To: <473484C6.6050101@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------050209080503010207090502"
Subject: Re: [Xenomai-core] User space drivers on PPC440
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
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------050209080503010207090502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Many apologies.  I forgot to build the user library.  Now the addresses 
look better:

bash-3.00# ./o2
req: start = 00000001c0000002   len = 0000000d
rel: start = 00000001c0000002   len = 0000000d
Trying to free nonexistent resource <00000001c0000002-00000001c000000e>
get leds: -16 Device or resource busy
put leds: 0 Success

However, I still get the printk that I've tried to free a non-existent 
resource.  Next, I'll try page aligning the addresses to see if that helps.

    Steve


Steven A. Falco wrote:
> Your patch makes sense.
>
> I have some results, but I'm not sure I understand what they mean.  
> I've attached the test program that I am using.  Here is what it outputs:
>
> bash-3.00# ./o2
> Trying to free nonexistent resource <0000000000000000-00000000c0000001>
> get leds: -16 Device or resource busy
> put leds: 0 Success
>
> Trying to free nonexistent resource <0000000000000000-ffffffffffffffff>
> get low_mem: -16 Device or resource busy
> put low_mem: 0 Success
>
> I am a little unclear on request_resource() - the return code is 
> backwards of what I would have expected.  Looking at examples in the 
> kernel, it appears that request_resource() returns EBUSY when things 
> go well, and it returns 0 when things go badly.  Like I said, that 
> seems backwards, but I guess it makes sense - EBUSY apparently means 
> that the resource is _now_ busy?
>
> Anyway, following the kernel examples, my program considers a non-zero 
> return as success.  At that point I release the region.  If instead, I 
> get a zero return, then I treat that as a failure, and don't release 
> the region.
>
> The part I don't understand is why I get the "Trying to free 
> nonexistent resource" messages.  Since I am getting an EBUSY, I 
> thought that meant I owned the resource, and that I should release it...
>
> Also, the addresses printed above are a bit strange.  For example, I 
> would have thought that instead of 
> "<0000000000000000-00000000c0000001>", it would print 
> "<00000001c0000000-00000001c0000013>".  Perhaps that is a clue - maybe 
> the start and length are not being passed correctly.
>
> One more question.  It appears that if my program crashes, that the 
> region will never be released.  So, the normal behavior of an exiting 
> process freeing all its resources doesn't seem to be guaranteed.
>
>     Steve
>
>
> Philippe Gerum wrote:
>> Philippe Gerum wrote:
>>   
>>> Steven A. Falco wrote:
>>>     
>>>> The rt_misc_get_io_region() has the "start" argument as an unsigned 
>>>> long.  On the PPC440, we have a 36-bit address space, where the I/O 
>>>> registers are generally above the 4GB area.  For example, the UART is at 
>>>> address 0x1ef600300.
>>>>
>>>> The Linux request_region call has "start" typed as a resource_size_t, 
>>>> which is a u64 on the PPC440 (i.e. CONFIG_RESOURCES_64BIT is set even 
>>>> though this is a 23-bit processor).
>>>>
>>>> Is this something that should be handled by xeno-config?  It could 
>>>> append a CFLAG indicating the size of a resource.
>>>>       
>>> Or use a 64bit long unconditionally, to keep the same kernel-based
>>> implementation, since there is no performance issue for this call. In
>>> any case, we need to fix the API before 2.4 final is out -- which will
>>> also affect the ABI, but it already changed during the 2.4 development
>>> phase anyway.
>>>
>>>     
>>
>> Does this patch work for you?
>>
>>   

--------------050209080503010207090502
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<tt>Many apologies.&nbsp; I forgot to build the user library.&nbsp; Now the
addresses look better:<br>
<br>
bash-3.00# ./o2<br>
req: start = 00000001c0000002&nbsp;&nbsp; len = 0000000d<br>
rel: start = 00000001c0000002&nbsp;&nbsp; len = 0000000d<br>
Trying to free nonexistent resource
&lt;00000001c0000002-00000001c000000e&gt;<br>
get leds: -16 Device or resource busy<br>
put leds: 0 Success<br>
<br>
However, I still get the printk that I've tried to free a non-existent
resource.&nbsp; Next, I'll try page aligning the addresses to see if that
helps.<br>
<br>
&nbsp;&nbsp;&nbsp; Steve<br>
<br>
</tt><br>
Steven A. Falco wrote:
<blockquote cite="mid:473484C6.6050101@domain.hid" type="cite">
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <tt>Your patch makes sense.<br>
  <br>
I have some results, but I'm not sure I understand what they mean.&nbsp;
I've attached the test program that I am using.&nbsp; Here is what it
outputs:<br>
  <br>
bash-3.00# ./o2<br>
Trying to free nonexistent resource
&lt;0000000000000000-00000000c0000001&gt;<br>
get leds: -16 De</tt><tt>vice or resource busy<br>
  </tt><tt>put leds: 0 Success<br>
  <br>
  </tt><tt>Trying to free nonexistent resource
&lt;0000000000000000-ffffffffffffffff&gt;<br>
get low_mem: -16 Device or resource busy<br>
put low_mem: 0 Success<br>
  <br>
I am a little unclear on request_resource() - the return code is
backwards of what I would have expected.&nbsp; Looking at examples in the
kernel, it appears that </tt><tt>request_resource() returns EBUSY when
things go well, and it returns 0 when things go badly.&nbsp; Like I said,
that seems backwards, but I guess it makes sense - EBUSY apparently
means that the resource is _now_ busy?<br>
  <br>
Anyway, following the kernel examples, my program considers a non-zero
return as success.&nbsp; At that point I release the region.&nbsp; If instead, I
get a zero return, then I treat that as a failure, and don't release
the region.<br>
  <br>
The part I don't understand is why I get the "</tt><tt>Trying to free
nonexistent resource" messages.&nbsp; Since I am getting an EBUSY, I thought
that meant I owned the resource, and that I should release it...<br>
  <br>
Also, the addresses printed above are a bit strange.&nbsp; For example, I
would have thought that instead of "</tt><tt>&lt;0000000000000000-00000000c0000001&gt;",
it would print "</tt><tt>&lt;00000001c0000000-00000001c0000013&gt;".&nbsp;
Perhaps that is a clue - maybe the start and length are not being
passed correctly.<br>
  <br>
One more question.&nbsp; It appears that if my program crashes, that the
region will never be released.&nbsp; So, the normal behavior of an exiting
process freeing all its resources doesn't seem to be guaranteed.<br>
  </tt><tt><br>
&nbsp;&nbsp;&nbsp; Steve<br>
  <br>
  </tt><br>
Philippe Gerum wrote:
  <blockquote cite="mid:47344759.4020505@domain.hid" type="cite">
    <pre wrap="">Philippe Gerum wrote:
  </pre>
    <blockquote type="cite">
      <pre wrap="">Steven A. Falco wrote:
    </pre>
      <blockquote type="cite">
        <pre wrap="">The rt_misc_get_io_region() has the "start" argument as an unsigned 
long.  On the PPC440, we have a 36-bit address space, where the I/O 
registers are generally above the 4GB area.  For example, the UART is at 
address 0x1ef600300.

The Linux request_region call has "start" typed as a resource_size_t, 
which is a u64 on the PPC440 (i.e. CONFIG_RESOURCES_64BIT is set even 
though this is a 23-bit processor).

Is this something that should be handled by xeno-config?  It could 
append a CFLAG indicating the size of a resource.
      </pre>
      </blockquote>
      <pre wrap="">Or use a 64bit long unconditionally, to keep the same kernel-based
implementation, since there is no performance issue for this call. In
any case, we need to fix the API before 2.4 final is out -- which will
also affect the ABI, but it already changed during the 2.4 development
phase anyway.

    </pre>
    </blockquote>
    <pre wrap=""><!---->
Does this patch work for you?

  </pre>
  </blockquote>
</blockquote>
</body>
</html>

--------------050209080503010207090502--

