Message-ID: <4857BBCD.6020902@domain.hid>
Date: Tue, 17 Jun 2008 09:27:41 -0400
From: "Steven A. Falco" <sfalco@domain.hid>
MIME-Version: 1.0
References: <4856B7AE.9030805@domain.hid> <4857682B.8060900@domain.hid>
In-Reply-To: <4857682B.8060900@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------020706050806020504040708"
Subject: Re: [Xenomai-core] Compile-time bug,
	and problem with PPC440 ethernet
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
--------------020706050806020504040708
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> Steven A. Falco wrote:
>   
>> I am building kernel 2.6.25.4 from DENX with Xenomai 2.4.4 for PPC440EPx
>> (sequoia development board).
>>
>> The kernel tries to use DHCP to obtain network settings.  With IPIPE
>> disabled, this works perfectly.  However, when I enable IPIPE, the board
>> sends packets ok, but does not receive packets - I can see the DHCP with
>> a sniffer, but the development board does not receive them.
>
>   
> External interrupts are probably locked out by the pipeline engine;
> I've fixed a
> similar issue in recent patches for other PICs. Which I-pipe patch
> release are
> you using?


I am using the patch that came with Xenomai 2.4.4, namely:
adeos-ipipe-2.6.25-powerpc-DENX-2.2-02.patch

>> Also, in order to disable IPIPE, I had to patch
>> kernel/time/tick-common.c around line 168. It is missing an ifdef:
>>
>> diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
>> index 58bfacf..3a735b8 100644
>> --- a/kernel/time/tick-common.c
>> +++ b/kernel/time/tick-common.c
>> @@ -163,9 +163,11 @@ static void tick_setup_device(struct tick_device
>> *td,
>>
>> td->evtdev = newdev;
>>
>> +#ifdef CONFIG_IPIPE
>> /* I-pipe: derive global tick IRQ from CPU 0 */
>> if (cpu == 0)
>> ipipe_update_tick_evtdev(newdev);
>> +#endif
>>
>> /*
>> * When the device is not per cpu, pin the interrupt to the
>>
>> Signed-off-by: Steve Falco <sfalco@domain.hid>
>>
>> If anyone has suggestions as to why IPIPE is blocking received ethernet
>> packets, I'd appreciate it.
>>
>> Steve



--------------020706050806020504040708
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Philippe Gerum wrote:
<blockquote cite="mid:4857682B.8060900@domain.hid" type="cite">
  <pre wrap="">Steven A. Falco wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I am building kernel 2.6.25.4 from DENX with Xenomai 2.4.4 for PPC440EPx
(sequoia development board).

The kernel tries to use DHCP to obtain network settings.  With IPIPE
disabled, this works perfectly.  However, when I enable IPIPE, the board
sends packets ok, but does not receive packets - I can see the DHCP with
a sniffer, but the development board does not receive them.</pre>
  </blockquote>
  <pre wrap=""><!---->
  </pre>
  <tt>External interrupts are probably locked out by the pipeline
engine; I've fixed a<br>
similar issue in recent patches for other PICs. Which I-pipe patch
release are<br>
you using?<br>
  </tt></blockquote>
<tt><br>
<br>
</tt><tt>I am using the patch that came with Xenomai 2.4.4, namely:</tt><tt>
adeos-ipipe-2.6.25-powerpc-DENX-2.2-02.patch<br>
<br>
</tt>
<blockquote cite="mid:4857682B.8060900@domain.hid" type="cite">
  <blockquote type="cite"><tt>Also, in order to disable IPIPE, I had to
patch<br>
kernel/time/tick-common.c around line 168. It is missing an ifdef:<br>
    <br>
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c<br>
index 58bfacf..3a735b8 100644<br>
--- a/kernel/time/tick-common.c<br>
+++ b/kernel/time/tick-common.c<br>
@@ -163,9 +163,11 @@ static void tick_setup_device(struct tick_device
*td,<br>
    <br>
td-&gt;evtdev = newdev;<br>
    <br>
+#ifdef CONFIG_IPIPE<br>
/* I-pipe: derive global tick IRQ from CPU 0 */<br>
if (cpu == 0)<br>
ipipe_update_tick_evtdev(newdev);<br>
+#endif<br>
    <br>
/*<br>
* When the device is not per cpu, pin the interrupt to the<br>
    <br>
Signed-off-by: Steve Falco <a class="moz-txt-link-rfc2396E" href="mailto:sfalco@domain.hid">&lt;sfalco@domain.hid&gt;</a><br>
    <br>
If anyone has suggestions as to why IPIPE is blocking received ethernet<br>
packets, I'd appreciate it.<br>
    <br>
Steve<br>
    </tt></blockquote>
</blockquote>
<br>
<br>
</body>
</html>

--------------020706050806020504040708--

