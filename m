Message-ID: <462DC627.9030203@domain.hid>
Date: Tue, 24 Apr 2007 10:56:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <45F68258.5040603@domain.hid> <45F6AA11.40707@domain.hid>	
	<bc4264770703281005v17fc4802v53728cda11cb6b17@domain.hid>	
	<460AB8FF.5060904@domain.hid> <460B21C0.7090200@domain.hid>	
	<460B7FDF.8030100@domain.hid> <460BECFD.2030003@domain.hid>	
	<460C0C7D.7000001@domain.hid>	
	<bc4264770704230809i9f9c554k14d67007b828971d@domain.hid>	
	<17964.64208.463335.611234@domain.hid>
	<bc4264770704240144n74d4cfa0lafcbc84b76e06822@domain.hid>
In-Reply-To: <bc4264770704240144n74d4cfa0lafcbc84b76e06822@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
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
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: Xenomai-help@domain.hid

roland Tollenaar wrote:
>>In case all that fails, enable the I-pipe tracer, run latency with the
>>-f option, and check /proc/ipipe/trace/frozen once you observed the high
>>latency in latency.
> 
> Have done this and attached the result. I have looked at it myself but
> cannot interpret the meaning.
> 
> A bit of help would be appreciated.

Your machine looks overloaded with some VM activity. What does top say ?

-- 
                                                 Gilles Chanteperdrix

