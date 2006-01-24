Message-ID: <43D65F27.7000908@domain.hid>
Date: Tue, 24 Jan 2006 18:08:55 +0100
From: Hannes Mayer <h.mayer@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] wake_up_interruptible ?
References: <43D2B94C.3000202@domain.hid>	<200601230144.31936.berlemont.hauw@domain.hid>
	<17364.46664.389729.166491@domain.hid>
In-Reply-To: <17364.46664.389729.166491@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org


Thank you both Alexis and Gilles!

I think I'll pass on the blocking chrdev for now until
I exactly understand what is allowed and what is not
within IPIPE.

For now, I'll poll from userspace and see if data is
available. I wanted to use the blocking read for
notification only anyway.

Thanks again,
Hannes.


