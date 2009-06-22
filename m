Message-ID: <4A3FEDA6.5040307@domain.hid>
Date: Mon, 22 Jun 2009 22:46:30 +0200
From: Johan Visser <johan.visser@domain.hid>
MIME-Version: 1.0
References: <634c78ce0906120240t694ded8cpfa7fcd9dfb2c3b8@domain.hid>	<200906121148.37732.smolorz@domain.hid>	<4A3235BF.5090201@domain.hid>
	<4A324D3D.9060505@domain.hid> <4A325189.5060905@domain.hid>
	<4A325520.5000809@domain.hid> <4A325746.3060601@domain.hid>
In-Reply-To: <4A325746.3060601@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------090101010209000202040101"
Subject: Re: [Xenomai-help] Running Xenomai in a virtual machine
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------090101010209000202040101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jan Kiszka schreef:
> Gilles Chanteperdrix wrote:
>   
>> Jan Kiszka wrote:
>>     
>>> Johan Visser wrote:
>>>       
>>>> VMware runs, but gives heavy CPU load ( about 38 % ) instead of 6-8 % on
>>>> a real system.
>>>>         
>>> That's expected if your CPU actually lacks hardware virtualization.
>>>       
>> An idle guest used to consume almost nothing on a vmware host. Only
>> MS-DOS needed a special TSR to have its idle mode not consume 100%. On
>> the other hand, the last time I used vmware was 5 years ago...
>>     
>
> I meant the scale is expected: If basically the same system runs with
> some non-zero load on real hw, the load that this machine inside a
> code-translating hypervisor like vmware causes to its host will be
> noticeably larger. But even the idle load can be noteworthy if I/O
> emulation causes a lot of host activities, even with HVM.
>
> Jan
>
>   
Tested QEMU as well, boots and runs completely.
it seems to be more jumpy in CPU load and has about 10% more load then 
VMware , after a short time ( minutes ) our application crashes because 
of a userspace watchdog we have implemented. this detects a lack of 
taskswitches in userspace.
( i use a dualcore 2x2.0Ghz centrino CPU. A real celeron @ 400MHz gives 
me12% CPU load in real-time :)
Also the idle task gives max CPU load at first. but after some 
user-interface actions (mouse clicks ) this reduces to 0%.
I will have to investigate more, but have a lack of time now.
cheers




----------------------------------------------------
Stork Plastics Machinery B.V. Alfred Marshallstraat 2, 7559 SE Hengelo, the Netherlands.
Supplies and executions to the conditions and stipulations filed with the Chamber of Commerce (Trade register Enschede nr. 06041991) except as otherwise provided in writing.
DISCLAIMER:
The information contained in this communication is confidential and may be legally privileged. It is intended solely for the use of the individual or entity to whom it is addressed and others authorized to receive it. If you are not the intended recipient, you are hereby notified that any disclosure, copying, distribution, or taking any action in reliance of the contents of this information is strictly prohibited and may be unlawful. Stork Plastics Machinery is neither liable for the proper and complete transmission of the information contained in this communication nor for any delay in its receipt. 

--------------090101010209000202040101
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Jan Kiszka schreef:
<blockquote cite="mid:4A325746.3060601@domain.hid" type="cite">
  <pre wrap="">Gilles Chanteperdrix wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Jan Kiszka wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">Johan Visser wrote:
      </pre>
      <blockquote type="cite">
        <pre wrap="">VMware runs, but gives heavy CPU load ( about 38 % ) instead of 6-8 % on
a real system.
        </pre>
      </blockquote>
      <pre wrap="">That's expected if your CPU actually lacks hardware virtualization.
      </pre>
    </blockquote>
    <pre wrap="">An idle guest used to consume almost nothing on a vmware host. Only
MS-DOS needed a special TSR to have its idle mode not consume 100%. On
the other hand, the last time I used vmware was 5 years ago...
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I meant the scale is expected: If basically the same system runs with
some non-zero load on real hw, the load that this machine inside a
code-translating hypervisor like vmware causes to its host will be
noticeably larger. But even the idle load can be noteworthy if I/O
emulation causes a lot of host activities, even with HVM.

Jan

  </pre>
</blockquote>
Tested QEMU as well, boots and runs completely. <br>
it seems to be more jumpy in CPU load and has about 10% more load then
VMware , after a short time ( minutes ) our application crashes because
of a userspace watchdog we have implemented. this detects a lack of
taskswitches in userspace.<br>
( i use a dualcore 2x2.0Ghz centrino CPU. A real celeron @ 400MHz gives
me12% CPU load in real-time :)<br>
Also the idle task gives max CPU load at first. but after some
user-interface actions (mouse clicks ) this reduces to 0%.<br>
I will have to investigate more, but have a lack of time now. <br>
cheers<br>
<br>
<br>
<br>

<br>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body>
<hr>
<small><b>Stork Plastics Machinery B.V. Alfred Marshallstraat 2, 7559 SE Hengelo, the Netherlands.</b><br>
Supplies and executions to the conditions and stipulations filed with the Chamber of Commerce (Trade register Enschede nr. 06041991) except as otherwise provided in writing.<br>
<b>DISCLAIMER:</b><br>
The information contained in this communication is confidential and may be legally privileged.  It is intended solely for the use of the individual or entity to whom it is addressed and others authorized to receive it. If you are not the intended recipient, you are hereby notified that any disclosure, copying, distribution, or taking any action in reliance of the contents of this information is strictly prohibited and may be unlawful. Stork Plastics Machinery is neither liable for the proper and complete transmission of the information contained in this communication nor for any delay in its receipt.</small>
</body>
</html>
<br>
</body>
</html>

--------------090101010209000202040101--

