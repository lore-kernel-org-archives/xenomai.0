Message-ID: <4EF49DA3.8070904@domain.hid>
Date: Fri, 23 Dec 2011 10:26:27 -0500
From: Makarand Pradhan <makarandpradhan@domain.hid>
MIME-Version: 1.0
References: <56F449AE83D74177BAC5887692E0EF55@domain.hid>
	<4EF44DB9.9000609@domain.hid>
In-Reply-To: <4EF44DB9.9000609@domain.hid>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Interrupt numbers
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

On 23/12/11 04:45 AM, Gilles Chanteperdrix wrote:
>
> Xenomai uses the same interrupt numbers as linux. But rt_intr_create is
> deprecated in user-space, you should instead write a driver using the
> rtdm skin. The enable bit is handled by xenomai when you request the irq
> at xenomai level.
>
Hi Gilles,

We use rt_intr_create in our code. So I am trying to understand the 
reasons for it being deprecated. So far, I have not been able to see any 
comments in the code regarding the deprecation or anything in the git log.

Can you pl comment on the reasons for deprecating rt_intr_create? Will 
it be removed in the next release?

Rgds,
Makarand.

-- 
___________________________________________________________________________
NOTICE OF CONFIDENTIALITY:
This e-mail and any attachments may contain confidential and privileged information.  If you are
not the intended recipient, please notify the sender immediately by return e-mail and delete this
e-mail and any copies.  Any dissemination or use of this information by a person other than the
intended recipient is unauthorized and may be illegal.
_____________________________________________________________________

  


