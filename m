Message-ID: <4C4B35F1.60103@domain.hid>
Date: Sat, 24 Jul 2010 11:50:25 -0700
From: Bob Feretich <bob.feretich@domain.hid>
MIME-Version: 1.0
References: <4C43C83F.5030401@domain.hid>
	<4C43D265.9080609@domain.hid>	<4C43FC4F.3010006@domain.hid>
	<4C440D6F.1060204@domain.hid>	<4C44E9C9.3020600@domain.hid>
	<4C454C0C.6000100@domain.hid>	<4C4550C8.3070504@domain.hid>
	<4C45541C.5090507@domain.hid> <4C45CEE6.5000903@domain.hid>
	<4C460506.3010103@domain.hid> <4C46141F.50103@domain.hid>
	<4C468040.3030509@domain.hid> <4C468485.5060408@domain.hid>
	<4C47597F.1010406@domain.hid>
	<4C478313.2030606@domain.hid>
	<4C48C1BB.8080606@domain.hid> <4C48C2CE.1030706@domain.hid>
	<4C4A292F.5040900@domain.hid> <4C4ADFC6.1010900@domain.hid>
In-Reply-To: <4C4ADFC6.1010900@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------020303030606000403090509"
Subject: Re: [Xenomai-help] Adeos patch prevents IRQ 384 (MMC Chip Detect)
 on omap-2.6.33
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
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------020303030606000403090509
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

  Let me make sure I understand.
The most recent report from me contained console logs of two boots.
The first was 2.6.33 with no Adeos patch applied.
The second was 2.6.33 with the Adeos patch and Xenomai enabled 
(CONFIG_IPIPE=y) and CONFIG_XENOMAI=y).

You want me to perform to tests:

   1. 2.6.33 with the Adeos patch applied, but .config edited to turn
      off CONFIG_IPIPE and CONFIG_XENOMAI.
   2. Assuming test #1 passes the interrupts successfully, 2.6.33 with
      the Adeos patch applied, CONFIG_IPIPE=y, CONFIG_XENOMAI off, and
      revert the change to drivers/i2c/busses/i2c-omap.c.

Is that correct?

Regards,
Bob Feretich


On 7/24/2010 5:42 AM, Gilles Chanteperdrix wrote:
> Bob Feretich wrote:
>>    I have started a new thread with a name that better describes the
>> failure I am seeing. This may or may not be the reason I was seeing root
>> file system mount hang on omap-2.6.31 (previous thread).
> Ok. In the case where you have Adeos without Xenomai, do you have
> CONFIG_IPIPE enabled, if yes, then please verify that when CONFIG_IPIPE
> is disabled, you return in the same situation as without the I-pipe
> patch. Please also try enabling CONFIG_IPIPE and only removing the
> commit which "fixes" the spurious irqs.
>
>

--------------020303030606000403090509
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
    <title></title>
  </head>
  <body bgcolor="#ffffff" text="#000000">
    Let me make sure I understand.<br>
    The most recent report from me contained console logs of two boots.<br>
    The first was 2.6.33 with no Adeos patch applied.<br>
    The second was 2.6.33 with the Adeos patch and Xenomai enabled
    (CONFIG_IPIPE=y) and CONFIG_XENOMAI=y).<br>
    <br>
    You want me to perform to tests:<br>
    <ol>
      <li>2.6.33 with the Adeos patch applied, but .config edited to
        turn off CONFIG_IPIPE and CONFIG_XENOMAI.</li>
      <li>Assuming test #1 passes the interrupts successfully, 2.6.33
        with the Adeos patch applied, CONFIG_IPIPE=y, CONFIG_XENOMAI
        off, and revert the change to drivers/i2c/busses/i2c-omap.c.<br>
      </li>
    </ol>
    Is that correct?<br>
    <br>
    Regards,<br>
    Bob Feretich<br>
    <br>
    <br>
    On 7/24/2010 5:42 AM, Gilles Chanteperdrix wrote:
    <blockquote cite="mid:4C4ADFC6.1010900@domain.hid" type="cite">
      <pre wrap="">Bob Feretich wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">  I have started a new thread with a name that better describes the 
failure I am seeing. This may or may not be the reason I was seeing root 
file system mount hang on omap-2.6.31 (previous thread).
</pre>
      </blockquote>
      <pre wrap="">
Ok. In the case where you have Adeos without Xenomai, do you have
CONFIG_IPIPE enabled, if yes, then please verify that when CONFIG_IPIPE
is disabled, you return in the same situation as without the I-pipe
patch. Please also try enabling CONFIG_IPIPE and only removing the
commit which "fixes" the spurious irqs.


</pre>
    </blockquote>
  </body>
</html>

--------------020303030606000403090509--

