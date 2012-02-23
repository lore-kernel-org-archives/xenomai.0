Message-ID: <4F464D25.3070905@domain.hid>
Date: Thu, 23 Feb 2012 15:28:53 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CADAaWNWQ0x_cnZUQeQ3DAYLJJKTgEi72yR51Zomw2qwsb=NUag@domain.hid>
In-Reply-To: <CADAaWNWQ0x_cnZUQeQ3DAYLJJKTgEi72yR51Zomw2qwsb=NUag@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Need help regarding system restore in Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: SUBRAMANIAN NATESAN <yenyes88@domain.hid>
Cc: xenomai@xenomai.org

On 02/23/2012 03:03 PM, SUBRAMANIAN NATESAN wrote:
> Hi,
> 
> I have to demonstrate how an RTOS implements "system restore" i.e.
> restoring back the systems state to a previous time. I picked up xenomai,
> but I am not able to figure out how it is done. Could you please direct me
> as to where it is implemented in xenomai source code?

I am not sure I understand what you mean. If you are talking about
suspend-to-ram or suspend-to-disk, linux does this, not xenomai. And it
probably does not work with xenomai threads.

-- 
					    Gilles.

