Message-ID: <473392F4.5010701@domain.hid>
Date: Thu, 08 Nov 2007 23:51:32 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4732C546.90602@domain.hid>
	<4733535E.4070700@domain.hid>	<47336447.8090203@domain.hid>
	<47336D6D.2020203@domain.hid>	<473382AB.6040708@domain.hid>
	<473386E6.4090204@domain.hid> <47339157.1010403@domain.hid>
In-Reply-To: <47339157.1010403@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Testing LTTng: first insights
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> ...
> Ok, I'm not going to argue about cleanliness or brokenness about this...
> issue, because it's first and foremost a matter of taste. The main
> point, I think, is this one: is the clock device something which may be
> changed on-the-fly during real-time operations, in such a way that we
> would have to atomically switch the device and get its frequency?
> Moreover, would this all-in-one approach guarantee anything when we use
> the frequency value to rescale timeout values, much later, long after
> the atomic section has been exited?
> 
> Because the answer is no, then I would not go for yet another interface
> breaking backward compatibility (even if I agree that we could live with
> a few patches being obsoleted), just for the purpose of getting the
> frequency in some atomic fashion, a guarantee which would not leave
> beyond the return point from ipipe_request_tickdev(), and above all, a
> guarantee we have no actual use of. This is where "cleanliness" may bite
> harder than perceived "brokenness".

Let's wait for my patches, and you may understand what I mean (e.g. that
the timer frequency is delivered by the selected clock_event_device -
atomically or not).

Jan

