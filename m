Message-ID: <bc4264770704241136j7c34ba4bva67820f8b7486ff9@domain.hid>
Date: Tue, 24 Apr 2007 18:36:32 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
In-Reply-To: <462DFECE.3080908@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45F68258.5040603@domain.hid> <460BECFD.2030003@domain.hid>
	<460C0C7D.7000001@domain.hid>
	<bc4264770704230809i9f9c554k14d67007b828971d@domain.hid>
	<17964.64208.463335.611234@domain.hid>
	<bc4264770704240144n74d4cfa0lafcbc84b76e06822@domain.hid>
	<462DC627.9030203@domain.hid>
	<bc4264770704240327k710e5856n8c6523aeda4e1167@domain.hid>
	<bc4264770704240327o35f0404btad323785b5a8d27b@domain.hid>
	<462DFECE.3080908@domain.hid>
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

Hi Gilles,

There seems to be distinct improvement.
latency seems to improved structurally by 5 or 6 us.

I am not sure I have manged to entirely kill sound, followed your advice below.

Thanks.

Roland


On 4/24/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> roland Tollenaar wrote:
> > Now with the attachment.
>
> On configurations when an audio card is not properly configured, the
> artsd daemon used to eat a lot of CPU. Could you try disabling this
> daemon ?
> Try and deactivate the sound effects in KDE.
> KDE control center/Sound and multimedia/Sound system uncheck "Enable
> sound system"
> --
>                                                  Gilles Chanteperdrix
>

