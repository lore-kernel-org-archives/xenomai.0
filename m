MIME-Version: 1.0
In-Reply-To: <5039D9A5.4090003@xenomai.org>
References: <CAKKWdte-kjOSZgPPkVe8UtGpeVSh0E52+-u1HyK2G2E0OS+RPg@mail.gmail.com>
	<5039D9A5.4090003@xenomai.org>
Date: Sun, 26 Aug 2012 12:56:11 +0430
Message-ID: <CAKKWdte30FgMziQWr7fGu94kdFvQ6EZA37c3+T1unG_wfcE+JA@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] stall/unstalling the pipeline domain automatically
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

I want to write a real time interrupt handler. I need to know when the
pipeline stage is stalled/unstalled.

Regards

On Sun, Aug 26, 2012 at 12:39 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Le 26/08/2012 05:29, ali hagigat a =E9crit :
>
>> As far as I understood the pipeline stage is stalled (for all
>> interrupts) automatically before servicing an interrupt handler and it
>> is unstalled upon returning from the interrupt. is that right?
>>
>> If i use an API function inside an interrput routine which stalls the
>> pipeline domain explicitly, will that domain remain in the stall state
>> after returning from the interrupt routine? (is there such an API
>> function?)
>> I mean , can i do something to force a domain to stay in a stalled state=
?
>
>
> No, but maybe you could explain us what you are trying to achieve,
> instead of asking all these questions, and we would tell you what
> we think is the best way to achieve it?
>
>
> --
> Gilles.

