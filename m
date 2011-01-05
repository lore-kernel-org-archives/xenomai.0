Message-ID: <4D24CF33.7090001@domain.hid>
Date: Wed, 05 Jan 2011 21:06:11 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <12d57b0ebf3.gprizzi@domain.hid>
In-Reply-To: <12d57b0ebf3.gprizzi@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] R: Re:  error in executing xenomai tests
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "gprizzi@domain.hid" <gprizzi@domain.hid>
Cc: xenomai@xenomai.org

gprizzi@domain.hid wrote:
> Tank you for your quick and clear replay.
> 
> I am going to use xenomai to run OROCOS based control applications.
> The faster frequency of periodic tasks is estimated between 1KHz to 2 KHz.

Well, that is not enough information. If you seriously want to meet some
deadlines, you have to make a few calculations, then see if your system
has sufficient latency, using the "latency" test. But this really is the
job you should be doing.

Note that for 1kHz or 2kHz on x86 platform, preempt_rt latencies may be
worth checking.

-- 
					    Gilles.

