From: NZG <ngustavson@domain.hid>
Date: Thu, 7 Jun 2007 17:57:53 -0500
References: <200706071357.12212.ngustavson@domain.hid>
	<200706071709.03430.ngustavson@domain.hid>
	<1181256253.4998.217.camel@domain.hid>
In-Reply-To: <1181256253.4998.217.camel@domain.hid>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200706071757.53092.ngustavson@domain.hid>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] writing from NRT to a rt_pipe-> easy wait for
	completion
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

On Thursday 07 June 2007 5:44 pm, Philippe Gerum wrote:
> There is no simple call, I'm afraid. One way would be to make your RT
> side always wait on the read-side (and process the messages as they
> arrive); since the RT receiver would always have precedence over the NRT
> sender, you would have the guarantee that all the messages sent have
> been consumed before the NRT side closes its endpoint
I'm thinking this is the cleanest way, just spawn a separate RT thread of 
lesser priority to my main rt loop, set it up to do nothing but read and 
process messages, and put some locks on it.

thx,
NZG

