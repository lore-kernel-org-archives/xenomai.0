Message-ID: <2ff1a98a0709190519i233cb94dq5e26fafb33e07262@domain.hid>
Date: Wed, 19 Sep 2007 14:19:46 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <31254.194.114.62.37.1190202620.squirrel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <31254.194.114.62.37.1190202620.squirrel@domain.hid>
Subject: Re: [Xenomai-help] SMI on other than intel chipsets
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nadym Salem <Kaiman@domain.hid>
Cc: xenomai@xenomai.org

On 9/19/07, Nadym Salem <Kaiman@domain.hid> wrote:
> Hi,
>
> still having my latency problems, I have some general question about the
> SMI problems.
> The SMI workaround only works with intel chipsets, because of lack of
> documentation by other vendors, right ?

I am pretty sure we can find VIA chipsets documentation, the SMI
workaround only works for Intel chipset because it is the only one
implemented, but you could implement the workaround for other
chipsets.

> Does that mean, that Xenomai can only work as a realtime system either
> with intel chipsets or with older boards not having the SMI ?

SMI already existed on pentium II, so the question is not the board
age, but rather the choices made by the board manufacturer to use or
not to use SMI.

> Did you try to contact other vendors because of that problem ?
>
> Do you have any idea how other realtime systems, like RTAI or solutions
> for windows cope with that problem ?
>
> Sorry for the high number of questions, we might need to get new
> motherboards in dependency on these questions and don't have too much time
> :)
>
> Greets, Nadym
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>


-- 
                                               Gilles Chanteperdrix

