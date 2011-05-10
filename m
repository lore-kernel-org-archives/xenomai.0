Message-ID: <4DC99265.5030903@domain.hid>
Date: Tue, 10 May 2011 21:30:45 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <509DA52866E38F47878413CF102D751F709E6632A2@domain.hid>
	<509DA52866E38F47878413CF102D751F709E6632A7@domain.hid>
In-Reply-To: <509DA52866E38F47878413CF102D751F709E6632A7@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Is Xenomai Fully Functional for me(newbie) on
 Linux 2.6.37.6
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sambasiva Rao Manchili <sambasiva.manchili@domain.hid>
Cc: Antonio Gambin <antonio.gambin@domain.hid>, "Xenomai-help@domain.hid" <Xenomai-help@domain.hid>

On 05/10/2011 02:38 PM, Sambasiva Rao Manchili wrote:
> Hi Gilles,
> After browing through  Xenomai Help Server(Gna), I found my problem is
> very close to the one of the users by name BONOS Antonis, who requested
> for  help  on an issue"Installation problem" yesterday!!!
> As I followed the pdf
> http://embedded.communities.intel.com/servlet/JiveServlet/download/4435-1248/xeno_intel.pdf,
> BONOS Antonis also followed it.
>  
> Looking forward for your help!!!

Hi Sambasiva,

I am not the only one replying on this list!

Especially since I only seldom run Xenomai on x86 these days. We already
had this error, but am unable to find the precise post. It is a
configuration error. So, please try removing all the superfluous things
in your kernel you will not use, such as numa, syscalls auditing,
selinux, ftrace, etc...

Regards.


------------------------------------------------------------------------
> This email and any attachment may contain confidential information which
> is intended for use only by the addressee(s) named above. If you
> received this email by mistake, please notify the sender immediately,
> and delete the email from your system. You are prohibited from copying,
> disseminating or otherwise using the email or any attachment.

If you intend to send some confidential information, please do not send
them to a public mailing list, as the only way for us to comply with
this disclaimer is to unsubscribe you.

-- 
                                                                Gilles.

