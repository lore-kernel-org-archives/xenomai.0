Message-ID: <4C3F471F.4030002@domain.hid>
Date: Thu, 15 Jul 2010 19:36:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTinwyQgI26INSzLlvgyP2hlAmuziK7V3iNCVa8Nd@domain.hid>	<4C3EFB0B.7050801@domain.hid>	<AANLkTinH0vj7gAxa8LscV_-Hvmggo9LigQkp30nIUcz6@domain.hid>	<4C3F192A.8080203@domain.hid>
	<AANLkTinJaCoe5nfcUuC25_0eOLJid1hk582uFdzRZT1_@domain.hid>
In-Reply-To: <AANLkTinJaCoe5nfcUuC25_0eOLJid1hk582uFdzRZT1_@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [RTnet-users] Alignment problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Cyril Wallois <walloiscyril@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Cyril Wallois wrote:
> Thanks for your reply,
> 
> 2010/7/15 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org
> <mailto:gilles.chanteperdrix@xenomai.org>>
> 
>     Cyril Wallois wrote:
>     > Hi Gilles,
>     >
>     > Sorry, I don't mention that my problem has ever been evoqued on
>     > xenomai-help one month ago :
> 
>     Ok. But if you had used the "reply" function of your MUA, the mail you
>     would have sent would have contained a "Reference" header pointing to
>     the mail you were replying, which would have allowed the MUA of the
>     people reading your mail, including Xenomai mailing list archives, to
>     properly sort this new mail as a follow-up of the mail you were
>     replying to.
> 
> The reply function send email to your address, so I thought that you
> should be the only one person who could read it.

I do not know about your MUA, but mine has a "Reply all" button, which
sets the references correctly as well, and allows to add new addresses
to the mail.

The point is, you can not expect everybody which reads your post, and
which would find your post in the archives to remember what platform you
use. So, either use the "reply" function of a MUA so that mine allows me
to find back the context, or repeat what is your setup every time you
post to the mailing list.

>     Ok. So, you enter do_page_fault from primary mode. Compile your kernel
>     with frame pointers, and try and insert a call to show_stack(NULL,NULL)
>     in the Xenomai code printing the messages which you see.
> 
> I try show_stack(NULL,NULL)  after the Xenomai error message, but I have
> a lock up (the Xenomai code is not printing).

Ok. Try adding a call to xnarch_trace_panic_freeze() before the call to
show_stack.

> What do you mean by primary mode, do you refer to real-time domain ?

Right, primary mode is a term specific to user-space threads.

P.S: The next private mail you send me will receive no answer.

-- 
					    Gilles.

