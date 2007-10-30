Message-ID: <2ff1a98a0710300252o6ce6d2aap2e82e918ed0488d@domain.hid>
Date: Tue, 30 Oct 2007 10:52:05 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <200710300943.l9U9h56l004732@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200710300943.l9U9h56l004732@domain.hid>
Subject: Re: [Xenomai-help] TR: RT, nonRT communication
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Patrick <kpa_info@domain.hid>
Cc: xenomai@xenomai.org

On 10/30/07, Patrick <kpa_info@domain.hid> wrote:
>
>
>
>
> Hi,
>
>
>
> Is it possible to share a pthread_mutex between a rt task and a linux
> pthread ?

No, it is not possible

>
> My two tasks must share resources and I must protect them against concurrent
> access.
>
> If pthread_mutex is not the correct way to do it can you tell me how to
> achieve this ?

The way to handle these border line cases is to make your linux
pthread a xenomai thread running with the SCHED_OTHER scheduling
policy. Note that the main thread already has this property.

-- 
                                               Gilles Chanteperdrix

