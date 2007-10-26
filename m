Message-ID: <472229DF.4060700@domain.hid>
Date: Fri, 26 Oct 2007 13:54:39 -0400
From: "Steven A. Falco" <sfalco@domain.hid>
MIME-Version: 1.0
References: <47220255.4040309@domain.hid> <472220AD.6080402@domain.hid>
In-Reply-To: <472220AD.6080402@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------010204030207050808090309"
Subject: Re: [Xenomai-core] clocktest and cyclictest work but irqloop crashes
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
--------------010204030207050808090309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hmmm.  IRQ4 is "PCI ExternalCommand Write"?  But I'm not using PCI.  
Here is the output:

# ./irqloop
NULL ->unmask handler, IRQ 4, chip <NULL>
Test mode:    user-space task
Port type:    serial
Port address: 0x3f8
Port IRQ:     4

Received IRQs:     0
Acknowledged IRQs: 0
Xenomai: POSIX: destroyed thread c0f80320


Philippe Gerum wrote:
> Steven A. Falco wrote:
>   
>> I am testing kernel 2.6.23 ARCH=powerpc with Xenomai 2.4-rc4.  The 
>> clocktest and cyclictest work perfectly with the uic/spinlock patches.  
>> However, the irqloop test fails with the Oops shown below.
>>
>>     
>
> Please try the patch below. It looks like the chip descriptor does not implement
> any unmask handler, which seems odd. This patch should tell us a bit more about
> this issue.
>
>   

--------------010204030207050808090309
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<tt>Hmmm.&nbsp; IRQ4 is "PCI ExternalCommand Write"?&nbsp; But I'm not using
PCI.&nbsp; Here is the output:<br>
<br>
# ./irqloop<br>
NULL -&gt;unmask handler, IRQ 4, chip &lt;NULL&gt;<br>
Test mode:&nbsp;&nbsp;&nbsp; user-space task<br>
Port type:&nbsp;&nbsp;&nbsp; serial<br>
Port address: 0x3f8<br>
Port IRQ:&nbsp;&nbsp;&nbsp;&nbsp; 4<br>
<br>
Received IRQs:&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
Acknowledged IRQs: 0<br>
Xenomai: POSIX: destroyed thread c0f80320<br>
</tt><br>
<br>
Philippe Gerum wrote:
<blockquote cite="mid:472220AD.6080402@domain.hid" type="cite">
  <pre wrap="">Steven A. Falco wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I am testing kernel 2.6.23 ARCH=powerpc with Xenomai 2.4-rc4.  The 
clocktest and cyclictest work perfectly with the uic/spinlock patches.  
However, the irqloop test fails with the Oops shown below.

    </pre>
  </blockquote>
  <pre wrap=""><!---->
Please try the patch below. It looks like the chip descriptor does not implement
any unmask handler, which seems odd. This patch should tell us a bit more about
this issue.

  </pre>
</blockquote>
</body>
</html>

--------------010204030207050808090309--

