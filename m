Message-ID: <4CD817BB.80404@domain.hid>
Date: Mon, 08 Nov 2010 07:31:07 -0800
From: Thomas Lockhart <Thomas.Lockhart@domain.hid>
MIME-Version: 1.0
References: <1289211836.298721730@domain.hid>
In-Reply-To: <1289211836.298721730@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Supported cPCI systems
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "edward.robbins@domain.hid" <edward.robbins@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

> since I have been unsuccessful getting Xenomai to work on our MEN
> F19P and F17 systems, I would like to hear from anyone who has had
> success with other cPCI based systems - preferably x86 with dual
> processor support, but failing that anything will do at this point.

We have had success with a dual-processor cPCI Xeon board from 
Concurrent Technologies (a PP421 I think).

I have another board from them (a PP531 I think) which will not boot 
recent Linux kernels (past 2.6.27 or so) including the FC13 distro disk. 
The company claims FC13 is supported so I don't know what is up with 
that. So far they have not been helpful on that front. I haven't done 
much with Xenomai on that board but I think it builds and runs with a 
2.6.26-based kernel.

hth

                    - Tom

