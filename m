Message-ID: <4BBBD4F7.2040708@domain.hid>
Date: Tue, 06 Apr 2010 17:42:31 -0700
From: Bob Feretich <bob.feretich@domain.hid>
MIME-Version: 1.0
References: <4BBA5480.9090608@domain.hid> <4BBA61AD.5020100@domain.hid>
	<4BBB9D96.7060808@domain.hid> <4BBB9FBC.5010400@domain.hid>
In-Reply-To: <4BBB9FBC.5010400@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------080108090501060008070400"
Subject: Re: [Xenomai-help] Adeos patch interference with Angstrom 2.6.29-r46
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------080108090501060008070400
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I'll move to the mainline kernel.
When do you expect a patch that supports the OMAP VFP will be available?

Regards,
Bob

On 4/6/2010 1:55 PM, Gilles Chanteperdrix wrote:
> Bob Feretich wrote:
>   
>> Your statement concerns me. I need NEON/VFP support and here are four
>> patches applied to it by the distribution.
>>            file://vfp/02-vfp-ptrace.patch;patch=1 \
>>            file://vfp/03-vfp-corruption.patch;patch=1 \
>>            file://vfp/04-vfp-threads.patch;patch=1 \
>>            file://vfp/05-vfp-signal-handlers.patch;patch=1 \
>> Are these patches well known? Can you identify them from the above?
>>     
>
> These URLs are relative to your system, I can not load the corresponding
> file from this mail. But yes, these patches sound familiar to me and at
> least some of then have been integrated in later versions of the Linux
> kernel. The beagle board is supported by the mainline kernel, you have
> no reason to use a distribution-specific fork.
>
> Also note that the VFP support is broken in the Adeos I-pipe patch for
> Linux 2.6.29. It has been fixed in the upcoming Adeos I-pipe patch for
> Linux 2.6.31. Patch for 2.6.33, and maybe 2.6.32 should follow soon.
>
>
>   

--------------080108090501060008070400
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=UTF-8" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
I'll move to the mainline kernel.<br>
When do you expect a patch that supports the OMAP VFP will be available?<br>
<br>
Regards,<br>
Bob<br>
<br>
On 4/6/2010 1:55 PM, Gilles Chanteperdrix wrote:
<blockquote cite="mid:4BBB9FBC.5010400@domain.hid" type="cite">
  <pre wrap="">Bob Feretich wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Your statement concerns me. I need NEON/VFP support and here are four
patches applied to it by the distribution.
           <a class="moz-txt-link-freetext" href="file://vfp/02-vfp-ptrace.patch;patch=1">file://vfp/02-vfp-ptrace.patch;patch=1</a> \
           <a class="moz-txt-link-freetext" href="file://vfp/03-vfp-corruption.patch;patch=1">file://vfp/03-vfp-corruption.patch;patch=1</a> \
           <a class="moz-txt-link-freetext" href="file://vfp/04-vfp-threads.patch;patch=1">file://vfp/04-vfp-threads.patch;patch=1</a> \
           <a class="moz-txt-link-freetext" href="file://vfp/05-vfp-signal-handlers.patch;patch=1">file://vfp/05-vfp-signal-handlers.patch;patch=1</a> \
Are these patches well known? Can you identify them from the above?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
These URLs are relative to your system, I can not load the corresponding
file from this mail. But yes, these patches sound familiar to me and at
least some of then have been integrated in later versions of the Linux
kernel. The beagle board is supported by the mainline kernel, you have
no reason to use a distribution-specific fork.

Also note that the VFP support is broken in the Adeos I-pipe patch for
Linux 2.6.29. It has been fixed in the upcoming Adeos I-pipe patch for
Linux 2.6.31. Patch for 2.6.33, and maybe 2.6.32 should follow soon.


  </pre>
</blockquote>
</body>
</html>

--------------080108090501060008070400--

