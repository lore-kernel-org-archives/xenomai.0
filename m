Message-ID: <4C3AE4BE.4090406@domain.hid>
Date: Mon, 12 Jul 2010 11:47:42 +0200
From: Oliver Clugnet <oliver.clugnet@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="------------010400000401050004050009"
Subject: [Xenomai-help] Fwd: Re:  Segmentation fault
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
--------------010400000401050004050009
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



-------- Original Message --------
Subject: 	Re: [Xenomai-help] Segmentation fault
Date: 	Mon, 12 Jul 2010 11:46:01 +0200
From: 	Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Organization: 	Xenomai
To: 	Oliver Clugnet <oliver.clugnet@domain.hid>
CC: 	Xenomai help <xenomai@xenomai.org>



Oliver Clugnet wrote:
>  On 07/12/2010 11:31 AM, Gilles Chanteperdrix wrote:
>>  Oliver Clugnet wrote:
>>
>>>  Hello,
>>>
>>>  I am trying to get the xenomai user-space programs to work on an x86
>>>  embedded system with a uClibc Buildroot root filesystem.
>>>  I have patched a kernel, activated the Xenomai sub-system, and
>>>  cross-compiled it with the Buildroot uClibc toolchain as well as the
>>>  userspace programs. The system boots alright with the Xenomai nucleus
>>>  and everything ("dmesg | grep Xenomai" shows that Xenomai is initialised).
>>>  But everytime I try to launch a program (cyclictest, clocktest, ...), I
>>>  get a segmentation fault with a kernel error message such as:
>>>  "clocktest[149] general protection ip:804cc22 sp:bfa29594 error:0 in
>>>  clocktest[8048000+7000]".
>>>  A possibility I've been looking at is that maybe the programs try to
>>>  access the High Memory, even though /proc/meminfo shows that there is
>>>  none on this system ("HighTotal 0k"), thus the segmentation fault. I
>>>  might add that the system has a 500Mb memory.
>>>  Could the High Memory be the problem? Is there a way of getting around it?
>>>  Or could the problem be elsewhere?
>>>
>>  No. There is little chance. Chances are higher that the problem comes in
>>  fact from uclibc (on x86, few people use uclibc). Could you try a glibc
>>  rootfs to confirm this hypothesis?
>>
>>
>  Hello,
>
>  Thank you for answering so quickly. I am actually in the process of
>  building a glibc root filesystem with Buildroot and a glibc toolchain
>  generated with crosstool-ng, so I will see soon enough if the problem
>  comes form the lib version.
>  What I don't understand though, is why the uclibc-x86 combination solely
>  would induce such an error as this one. Does it have something to do
>  with the xenomai compatibility in such a case?

x86 usually have lots of RAM and storage, so people probably never used
uclibc on x86 before you. So, my guess is that it was never tested, and
as such it does not work. By experience, we know that compatibility with
uclibc does not come automatically.

Please do not forget to CC the mailing list.

-- 
					    Gilles.


--------------010400000401050004050009
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<meta http-equiv="content-type" content="text/html; charset=UTF-8">
</head>
<body text="#000000" bgcolor="#ffffff">
<br>
<br>
-------- Original Message --------
<table class="moz-email-headers-table" cellpadding="0" cellspacing="0"
 border="0">
  <tbody>
    <tr>
      <th valign="BASELINE" nowrap="nowrap" align="RIGHT">Subject: </th>
      <td>Re: [Xenomai-help] Segmentation fault</td>
    </tr>
    <tr>
      <th valign="BASELINE" nowrap="nowrap" align="RIGHT">Date: </th>
      <td>Mon, 12 Jul 2010 11:46:01 +0200</td>
    </tr>
    <tr>
      <th valign="BASELINE" nowrap="nowrap" align="RIGHT">From: </th>
      <td>Gilles Chanteperdrix <a class="moz-txt-link-rfc2396E" href="mailto:gilles.chanteperdrix@xenomai.org">&lt;gilles.chanteperdrix@xenomai.org&gt;</a></td>
    </tr>
    <tr>
      <th valign="BASELINE" nowrap="nowrap" align="RIGHT">Organization:
      </th>
      <td>Xenomai</td>
    </tr>
    <tr>
      <th valign="BASELINE" nowrap="nowrap" align="RIGHT">To: </th>
      <td>Oliver Clugnet <a class="moz-txt-link-rfc2396E" href="mailto:oliver.clugnet@domain.hid">&lt;oliver.clugnet@domain.hid&gt;</a></td>
    </tr>
    <tr>
      <th valign="BASELINE" nowrap="nowrap" align="RIGHT">CC: </th>
      <td>Xenomai help <a class="moz-txt-link-rfc2396E" href="mailto:xenomai@xenomai.org">&lt;xenomai@xenomai.org&gt;</a></td>
    </tr>
  </tbody>
</table>
<br>
<br>
<pre>Oliver Clugnet wrote:
&gt; On 07/12/2010 11:31 AM, Gilles Chanteperdrix wrote:
&gt;&gt; Oliver Clugnet wrote:
&gt;&gt;    
&gt;&gt;&gt; Hello,
&gt;&gt;&gt;
&gt;&gt;&gt; I am trying to get the xenomai user-space programs to work on an x86
&gt;&gt;&gt; embedded system with a uClibc Buildroot root filesystem.
&gt;&gt;&gt; I have patched a kernel, activated the Xenomai sub-system, and
&gt;&gt;&gt; cross-compiled it with the Buildroot uClibc toolchain as well as the
&gt;&gt;&gt; userspace programs. The system boots alright with the Xenomai nucleus
&gt;&gt;&gt; and everything ("dmesg | grep Xenomai" shows that Xenomai is initialised).
&gt;&gt;&gt; But everytime I try to launch a program (cyclictest, clocktest, ...), I
&gt;&gt;&gt; get a segmentation fault with a kernel error message such as:
&gt;&gt;&gt; "clocktest[149] general protection ip:804cc22 sp:bfa29594 error:0 in
&gt;&gt;&gt; clocktest[8048000+7000]".
&gt;&gt;&gt; A possibility I've been looking at is that maybe the programs try to
&gt;&gt;&gt; access the High Memory, even though /proc/meminfo shows that there is
&gt;&gt;&gt; none on this system ("HighTotal 0k"), thus the segmentation fault. I
&gt;&gt;&gt; might add that the system has a 500Mb memory.
&gt;&gt;&gt; Could the High Memory be the problem? Is there a way of getting around it?
&gt;&gt;&gt; Or could the problem be elsewhere?
&gt;&gt;&gt;      
&gt;&gt; No. There is little chance. Chances are higher that the problem comes in
&gt;&gt; fact from uclibc (on x86, few people use uclibc). Could you try a glibc
&gt;&gt; rootfs to confirm this hypothesis?
&gt;&gt;
&gt;&gt;    
&gt; Hello,
&gt; 
&gt; Thank you for answering so quickly. I am actually in the process of 
&gt; building a glibc root filesystem with Buildroot and a glibc toolchain 
&gt; generated with crosstool-ng, so I will see soon enough if the problem 
&gt; comes form the lib version.
&gt; What I don't understand though, is why the uclibc-x86 combination solely 
&gt; would induce such an error as this one. Does it have something to do 
&gt; with the xenomai compatibility in such a case?

x86 usually have lots of RAM and storage, so people probably never used
uclibc on x86 before you. So, my guess is that it was never tested, and
as such it does not work. By experience, we know that compatibility with
uclibc does not come automatically.

Please do not forget to CC the mailing list.

-- 
					    Gilles.
</pre>
</body>
</html>

--------------010400000401050004050009--

