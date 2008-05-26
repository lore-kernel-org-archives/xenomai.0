Message-ID: <2ff1a98a0805260816s1038690cj4a5b38e4171d004c@domain.hid>
Date: Mon, 26 May 2008 17:16:23 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <16282572.8252241211811692909.JavaMail.www@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <16282572.8252241211811692909.JavaMail.www@domain.hid>
Subject: Re: [Xenomai-help] patch on cirrus logic ep93xx
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "kerhoas.vincent" <kerhoas.vincent@domain.hid>
Cc: xenomai@xenomai.org

On Mon, May 26, 2008 at 4:21 PM, kerhoas.vincent
<kerhoas.vincent@domain.hid> wrote:
> Hi
>
> I don't understand how works the mailing list, but i would like to respond
> to the following message :

It is simple, when you want to reply a mail, open that mail with your
mail client and hit the "reply all" button. If you want to reply an
old mail, you can download it from the archives here:
https://mail.gna.org/public/xenomai-core/

When you want to send a patch, send it as the output of the "diff
-Naurdp"  command, which you can paste in your mail if your mail
client does not automatically add any carriage returns, or attach as a
plain/text attachment.

When you do it, we will be happy to review your patch.

Note that for the implementation of the tsc emulation in the ep93xx
patch, I would advise to use the free-running counter EP93XX_TIMER4,
like Linux does, and that I would add the export of this tsc to
user-space as explained in the ARM I-pipe porting guide:
http://www.xenomai.org/index.php/I-pipe:ArmPorting

-- 
 Gilles

