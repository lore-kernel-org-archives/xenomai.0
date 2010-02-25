Message-ID: <4B85E29D.2000202@domain.hid>
Date: Wed, 24 Feb 2010 18:38:21 -0800
From: Bob Feretich <bob.feretich@domain.hid>
MIME-Version: 1.0
References: <4B856ADF.1030100@domain.hid> <4B858711.9040806@domain.hid>
In-Reply-To: <4B858711.9040806@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------000500060306020804090608"
Subject: [Xenomai-help] Xenomai built by OpenEmbedded
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
Cc: Jeff Stutzman <rhino@domain.hid>

This is a multi-part message in MIME format.
--------------000500060306020804090608
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Sorry, I reused an old e-mail and forgot to change the subject line last 
time. The subject line is more accurate on this e-mail.

How can I locate this previous report?  (identified below)
I am willing to spend some time pushing Xenomai forward on this front, 
but I will probably need some help. I have been involved with Linux 
system building just long enough to be dangerous. Installing a co-kernel 
is a new frontier for me.

Normally, when I need to attach a new module to the Angstrom kernel, I...

   1. bitbake the Linux system. (Kernel source is deleted upon completion.)
   2. bitbake the Angstrom kernel using the "-c compile" option, which
      leaves the kernel source and intermediate files in place.
   3. Build my kernel modules within the context of the kernel.

My theory is that the below sequence may work for Xenomai...

   1. bitbake the Linux system. (Kernel source is deleted upon completion.)
   2. bitbake the Angstrom kernel using the bitbake "-c compile" option,
      which leaves the kernel source and intermediate files in place.
   3. Apply the appropriate Adios kernel patches.
   4. Rebuild the Angstrom kernel using the "-c compile" option, which
      should use the patched  kernel source.
   5. Add the Xenomai sub-tree to the root file system.
   6. Build my modules as before.

Does this make sense?

Regards,
Bob Feretich

On 2/24/2010 12:07 PM, Gilles Chanteperdrix wrote:
> Bob Feretich wrote:
>   
>> Lately I have been using the OpenEmbedded bitbake tool to build my Linux 
>> systems (Angstrom for BeagleBoard based).  Has anyone created a recipe 
>> set to build Xenomai under OpenEmbedded?
>>
>> What I really want to do is install Xenomai into the BeagleBoard 
>> Angstrom kernel.
>>     
>
> Yes, recently someone reported using this method. However, he had issues
> with -Wl,--as-needed which we did not elucidate completely.
>   
>> Regards,
>> Bob
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>>
>>     

--------------000500060306020804090608
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=UTF-8" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Sorry, I reused an old e-mail and forgot to change the subject line
last time. The subject line is more accurate on this e-mail.<br>
<br>
How can I locate this previous report?  (identified below)<br>
I am willing to spend some time pushing Xenomai forward on this front,
but I will probably need some help. I have been involved with Linux
system building just long enough to be dangerous. Installing a
co-kernel is a new frontier for me.<br>
<br>
Normally, when I need to attach a new module to the Angstrom kernel,
I...<br>
<ol>
  <li>bitbake the Linux system. (Kernel source is deleted upon
completion.)<br>
  </li>
  <li>bitbake the Angstrom kernel using the "-c compile" option, which
leaves the kernel source and intermediate files in place.</li>
  <li>Build my kernel modules within the context of the kernel.</li>
</ol>
My theory is that the below sequence may work for Xenomai...<br>
<ol>
  <li>bitbake the Linux system. (Kernel source is deleted upon
completion.)<br>
  </li>
  <li>bitbake the Angstrom kernel using the bitbake "-c compile"
option, which leaves the kernel source and intermediate files in place.</li>
  <li>Apply the appropriate Adios kernel patches.</li>
  <li>Rebuild the Angstrom kernel using the "-c compile" option, which
should use the patched  kernel source. <br>
  </li>
  <li>Add the Xenomai sub-tree to the root file system.<br>
  </li>
  <li>Build my modules as before.<br>
  </li>
</ol>
Does this make sense?<br>
<br>
Regards,<br>
Bob Feretich<br>
<br>
On 2/24/2010 12:07 PM, Gilles Chanteperdrix wrote:
<blockquote cite="mid:4B858711.9040806@domain.hid" type="cite">
  <pre wrap="">Bob Feretich wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Lately I have been using the OpenEmbedded bitbake tool to build my Linux 
systems (Angstrom for BeagleBoard based).  Has anyone created a recipe 
set to build Xenomai under OpenEmbedded?

What I really want to do is install Xenomai into the BeagleBoard 
Angstrom kernel.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Yes, recently someone reported using this method. However, he had issues
with -Wl,--as-needed which we did not elucidate completely.
  </pre>
  <blockquote type="cite">
    <pre wrap="">Regards,
Bob
_______________________________________________
Xenomai-help mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a>
<a class="moz-txt-link-freetext" href="https://mail.gna.org/listinfo/xenomai-help">https://mail.gna.org/listinfo/xenomai-help</a><!---->

    </pre>
  </blockquote>
</blockquote>
</body>
</html>

--------------000500060306020804090608--

