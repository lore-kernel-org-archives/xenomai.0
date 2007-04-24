Message-ID: <bc4264770704240331v31f81487l32e27634e77804b4@domain.hid>
Date: Tue, 24 Apr 2007 10:31:11 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
In-Reply-To: <462DC874.20303@domain.hid>
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
	<462DC874.20303@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-help@domain.hid

Hi

> Two conclusions:
>
>  - You are running your kernel as i586 without TSC support - suboptimal,
>    costs you a few micros.
I am aware of this. For the current machine I will stick to this.


>  - The reported latency perfectly matches the trace, nothing
>    pathological there. The trace looks like this: Timer fired,
>    measurement task woken up, two interrupts squeeze themselves between
>    wakeup and time stamp acquisition. All sane.
Is it not a bit strange that a machine as fast as this one is supposed
to be give worse latencies than much slower machines. Are the 2
interrupts causing the latency?

Regards,

Roland
>
> Jan
>
>
>

