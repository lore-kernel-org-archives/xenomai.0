Message-ID: <421D8BDF.5070601@domain.hid>
Date: Thu, 24 Feb 2005 09:10:07 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] When to do __adeos_takeover() on ARM
References: <20050223184214.fff8ccbdc13c4021a107f546ce9db302.in@domain.hid>
In-Reply-To: <20050223184214.fff8ccbdc13c4021a107f546ce9db302.in@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: Jason Huang <jason.huang@domain.hid>
Cc: adeos-main@gna.org

Jason Huang wrote:
> Dear list members,
> 
> If __adeos_takeover is called in init(), the timer interrupt kicks in way before
> adp->irqs[] have been initialized and hence adeos_switch_domain is not called
> and the interrupt is not handled.
>

If the takeover has not taken place, then the standard IRQ vectors 
should be in place after the interrupt layer has been initialized, 
therefore further interrupts should be handled by the regular Linux 
handlers as they would if Adeos was absent. Additionally, 
__adeos_switch_domain() is only called when more than a single domain 
exists, which sounds unlikely during the boot phase.

> Has anybody seen the problem? How/where do I place __adeos_takeover?

Which architecture are you working on?

> 
> Thanks in advance.
> 
> Jason Huang
> Wescon Technology
> 408-727-8818 x108 
> 
> 
>>-----Original Message-----
>>From: adeos-main-admin@domain.hid [mailto:adeos-main-admin@domain.hid] On Behalf Of
>>adeos-main-request@domain.hid
>>Sent: Friday, February 04, 2005 5:43 PM
>>To: Jason Huang
>>Subject: Welcome to the "Adeos-main" mailing list
>>
>>Welcome to the Adeos-main@domain.hid mailing list!
>>
>>To post to this list, send your email to:
>>
>>  adeos-main@gna.org
>>
>>General information about the mailing list is at:
>>
>>  https://mail.gna.org/listinfo/adeos-main
>>
>>If you ever want to unsubscribe or change your options (eg, switch to
>>or from digest mode, change your password, etc.), visit your
>>subscription page at:
>>
>>  https://mail.gna.org/options/adeos-main/jason.huang%40wescongroup.com
>>
>>
>>You can also make such adjustments via email by sending a message to:
>>
>>  Adeos-main-request@domain.hid
>>
>>with the word `help' in the subject or body (don't include the
>>quotes), and you will get back a message with instructions.
>>
>>You must know your password to change your options (including changing
>>the password, itself) or to unsubscribe.  It is:
>>
>>  welcome
>>
>>If you forget your password, don't worry, you will receive a monthly
>>reminder telling you what all your gna.org mailing list passwords are,
>>and how to unsubscribe or change your options.  There is also a button
>>on your options page that will email your current password to you.
>>
>>You may also have your password mailed to you automatically from the
>>Web page noted above.
> 
> 
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main


-- 

Philippe.

