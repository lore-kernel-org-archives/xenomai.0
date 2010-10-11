Message-ID: <4CB3672B.3020806@domain.hid>
Date: Mon, 11 Oct 2010 15:36:11 -0400
From: Roger Carns <rpcarns@domain.hid>
MIME-Version: 1.0
References: <4CB35360.6080003@domain.hid>
	<4CB36314.6090109@domain.hid>
	<4CB36627.5040602@domain.hid>
	<4CB36658.5000200@domain.hid>
In-Reply-To: <4CB36658.5000200@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------070009060406040208030403"
Subject: Re: [Xenomai-help] rt_io_get_region
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------070009060406040208030403
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/11/2010 3:32 PM, Gilles Chanteperdrix wrote:
> Roger Carns wrote:
>> On 10/11/2010 3:18 PM, Gilles Chanteperdrix wrote:
>>> Roger Carns wrote:
>>>> Does rt_io_get_region function be called from user space and does
>>>> it return a user space address and if so how is it return? Also
>>>> is there doc out there someplace on usage of this function.
>>> rt_io_get_region is a user-space mapping of
>>> request_mem_regio/request_io_region. As such, yes, it may be called
>>> from user-space. And no, it does not return address. What it
>>> returns is a cookie that may be passed to rt_io_put_region to free
>>> the used memory.
>>>
>>> In order to map an MMIO region in user-space you should use
>>> /dev/mem or use ioperm and inl/outl directly if you want to access
>>> an I/O port. What rt_io_get_region does is to allow you to this
>>> cleanly with regard to the rest of the system.
>>>
>> So, I open the /dev/mem and use the fd returned on the mmap call. But
>> how do I associate the region defined in the rt_io_get_region with
>> that fd?
> The offset passed to mmap is the physical address which you want to map.
>
> Please do not forget to CC the maling list.
>
> great that was what I was going try first...thanks for your help

-- 

*Roger Carns*

TSS Engineering
321-722-0082 x222 (w)

rpcarns@domain.hid
_www.tssleft.com <http://www.tssleft.com/>_ _We Move Projects Left. You 
Feel Better.


--------------070009060406040208030403
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#ffffff" text="#000000">
    <br>
    <br>
    On 10/11/2010 3:32 PM, Gilles Chanteperdrix wrote:
    <blockquote cite="mid:4CB36658.5000200@domain.hid" type="cite">
      <pre wrap="">Roger Carns wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">
On 10/11/2010 3:18 PM, Gilles Chanteperdrix wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="">Roger Carns wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="">Does rt_io_get_region function be called from user space and does
it return a user space address and if so how is it return? Also
is there doc out there someplace on usage of this function.
</pre>
          </blockquote>
          <pre wrap="">rt_io_get_region is a user-space mapping of 
request_mem_regio/request_io_region. As such, yes, it may be called
from user-space. And no, it does not return address. What it
returns is a cookie that may be passed to rt_io_put_region to free
the used memory.

In order to map an MMIO region in user-space you should use
/dev/mem or use ioperm and inl/outl directly if you want to access
an I/O port. What rt_io_get_region does is to allow you to this
cleanly with regard to the rest of the system.

</pre>
        </blockquote>
        <pre wrap="">So, I open the /dev/mem and use the fd returned on the mmap call. But
how do I associate the region defined in the rt_io_get_region with
that fd?
</pre>
      </blockquote>
      <pre wrap="">
The offset passed to mmap is the physical address which you want to map.

Please do not forget to CC the maling list.

great that was what I was going try first...thanks for your help</pre>
    </blockquote>
    <br>
    <div class="moz-signature">-- <br>
      <style type="text/css">p { margin-bottom: 0.08in; direction: ltr; color: rgb(0, 0, 0); }p.western { font-family: "Times New Roman",serif; font-size: 12pt; }p.cjk { font-family: "Lucida Sans Unicode"; font-size: 12pt; }p.ctl { font-family: "Mangal"; font-size: 12pt; }a:link {  }</style>
      <p class="western" style="margin-bottom: 0in;"><font face="Arial,
          sans-serif"><b>Roger
            Carns</b></font></p>
      <p class="western" style="margin-bottom: 0in;"><font face="Arial,
          sans-serif"><span style="font-weight: normal;">TSS
            Engineering <br>
            321-722-0082 x222 (w) </span></font>
      </p>
      <p class="western" style="margin-bottom: 0in;"><font face="Arial,
          sans-serif"><span style="font-weight: normal;"><a class="moz-txt-link-abbreviated" href="mailto:rpcarns@domain.hid">rpcarns@domain.hid</a></span></font><br>
        <font color="#000080"><span lang="zxx"><u><a
                href="http://www.tssleft.com/">www.tssleft.com</a></u></span></font>
        <sub><font size="2">We Move Projects Left. You Feel Better.</font></sub>
      </p>
    </div>
  </body>
</html>

--------------070009060406040208030403--

