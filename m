From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <b88603c31001040212m7b20037fre7668fd46587881d@domain.hid>
References: <b88603c31001040212m7b20037fre7668fd46587881d@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 04 Jan 2010 16:01:35 +0100
Message-ID: <1262617295.2220.30.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Deadlock with test apps in 2.5.0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henri Roosen <henriroosen@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2010-01-04 at 11:12 +0100, Henri Roosen wrote:
> I just had a quick look at the newly released Xenomai 2.5.0 version.
> The release notes show some interesting performance optimizations, so
> we are evaluating whether we can use this version for our future
> development.
> 
> I compiled a 2.6.30.10 x86 kernel with this version and as always I
> started the latency test to give me a first impression whether the
> system behaves as expected. Then played around with the new test-suite
> programs that come with this new release.
> 
> The latency app got into a deadlock when running the
> mutex-torture-native/posix (in a while loop) at the same time. I did
> not look into it in any detail, but these apps should not lock each
> other, right? Is this expected behaviour or this is a bug?

At least, this is not expected. Could you enable all debug options from
the Xenomai nucleus and try again? TIA,,

> 
> Thanks,
> Henri
> 
> To reproduce run:
> latency
> while true; do mutex-torture-native ; done
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.



