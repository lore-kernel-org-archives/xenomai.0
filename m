Message-ID: <49917AE7.5030207@domain.hid>
Date: Tue, 10 Feb 2009 13:02:31 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <729916.37479.qm@domain.hid>	<49915E95.7010101@domain.hid>
	<951569.86092.qm@domain.hid>
In-Reply-To: <951569.86092.qm@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Re : Problem with Xeno-test: "Something died a
 XXX	or"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Mathieu JOINIE-MAURIN <mjoiniem@domain.hid>
Cc: xenomai@xenomai.org

Mathieu JOINIE-MAURIN wrote:
> The thing is that as I had to compile many times my kernel in order
> to try many .config, I had time to try to run ./latency when
> compilation is made. And there is no problem with latencies for
> example.
> 
> What does make exactly the load generator ? How can I try to debug it
> ?

xeno-test is a script, so, debug it the way you would debug any script.
bash -x is your friend.
Also, since you seem to be running a localized Linux, you could try
export LANG=C before running the script.

-- 
                                                 Gilles.

