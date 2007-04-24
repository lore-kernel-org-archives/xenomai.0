Message-ID: <bc4264770704240327k710e5856n8c6523aeda4e1167@domain.hid>
Date: Tue, 24 Apr 2007 10:27:07 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
In-Reply-To: <462DC627.9030203@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45F68258.5040603@domain.hid> <460AB8FF.5060904@domain.hid>
	<460B21C0.7090200@domain.hid> <460B7FDF.8030100@domain.hid>
	<460BECFD.2030003@domain.hid> <460C0C7D.7000001@domain.hid>
	<bc4264770704230809i9f9c554k14d67007b828971d@domain.hid>
	<17964.64208.463335.611234@domain.hid>
	<bc4264770704240144n74d4cfa0lafcbc84b76e06822@domain.hid>
	<462DC627.9030203@domain.hid>
Subject: Re: [Xenomai-help] Latencies due to RT-Socket-CAN register accesses
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-help@domain.hid

Hi,

Thanks for the response. Attached my top while running latency. I did
not bother to close any of the applications open since the performance
is the same.

What is VM activity? This is completely novel to me.

Regards,

Roland.

On 4/24/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> roland Tollenaar wrote:
> >>In case all that fails, enable the I-pipe tracer, run latency with the
> >>-f option, and check /proc/ipipe/trace/frozen once you observed the high
> >>latency in latency.
> >
> > Have done this and attached the result. I have looked at it myself but
> > cannot interpret the meaning.
> >
> > A bit of help would be appreciated.
>
> Your machine looks overloaded with some VM activity. What does top say ?
>
> --
>                                                  Gilles Chanteperdrix
>

