Message-ID: <f45855d10807211051k7cd6b91co913b636af0003c74@domain.hid>
Date: Mon, 21 Jul 2008 13:51:59 -0400
From: "Vincent Levesque" <levesquev@domain.hid>
In-Reply-To: <4881F602.9020800@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_1640_9921680.1216662719940"
References: <3451.132.206.72.194.1216322618.squirrel@domain.hid>
	<4881F602.9020800@domain.hid>
Subject: Re: [Xenomai-help] Freeze on system()/fork() call (xenomai 2.4.4)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

------=_Part_1640_9921680.1216662719940
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Philippe,

You are quite correct. I was using adeos-ipipe-2.6.20.21-i386-1.12-03.patch
which predates the fix. I switched to adeos-ipipe-2.6.25-x86-2.0-08.patch
(also distributed with xenomai 2.4.4) and my issue was resolved.

Thank you for your help,

Vincent Levesque
vleves@domain.hid


This was not a Xenomai issue, but an Adeos one.
>
> Assuming that your arch is x86, Gilles's fix was merged back in April:
>
> http://download.gna.org/adeos/patches/v2.6/x86/older/adeos-ipipe-2.6.24-x86-2.0-05.patch
>
> The latest update for the 2.6.24 baseline you may want to grab is this one:
>
> http://download.gna.org/adeos/patches/v2.6/x86/older/adeos-ipipe-2.6.24-x86-2.0-08.patch
>
> You may also want to have a look at the Xenomai FAQ about picking the
> proper
> I-pipe patch for any given Xenomai release:
> http://www.xenomai.org/index.php/FAQs
>

------=_Part_1640_9921680.1216662719940
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hi Philippe,<br><br>You are quite correct. I was using adeos-ipipe-2.6.20.21-i386-1.12-03.patch which predates the fix. I switched to adeos-ipipe-2.6.25-x86-2.0-08.patch (also distributed with xenomai 2.4.4) and my issue was resolved.<br>
<br>Thank you for your help,<br><br>Vincent Levesque<br><a href="mailto:vleves@domain.hid">vleves@domain.hid</a><br><br><br><div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
This was not a Xenomai issue, but an Adeos one.<br>
<br>
Assuming that your arch is x86, Gilles&#39;s fix was merged back in April:<br>
<a href="http://download.gna.org/adeos/patches/v2.6/x86/older/adeos-ipipe-2.6.24-x86-2.0-05.patch" target="_blank">http://download.gna.org/adeos/patches/v2.6/x86/older/adeos-ipipe-2.6.24-x86-2.0-05.patch</a><br>
<br>
The latest update for the 2.6.24 baseline you may want to grab is this one:<br>
<a href="http://download.gna.org/adeos/patches/v2.6/x86/older/adeos-ipipe-2.6.24-x86-2.0-08.patch" target="_blank">http://download.gna.org/adeos/patches/v2.6/x86/older/adeos-ipipe-2.6.24-x86-2.0-08.patch</a><br>
<br>
You may also want to have a look at the Xenomai FAQ about picking the proper<br>
I-pipe patch for any given Xenomai release:<br>
<a href="http://www.xenomai.org/index.php/FAQs" target="_blank">http://www.xenomai.org/index.php/FAQs</a><br></blockquote></div><br></div>

------=_Part_1640_9921680.1216662719940--

