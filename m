Message-ID: <4EFB4BC9.4050903@domain.hid>
Date: Wed, 28 Dec 2011 18:03:05 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <000101ccc4b8$74856eb0$5d904c10$@soterem.fr>	<4EF9F949.5000708@domain.hid>
	<000001ccc541$7fa8d960$7efa8c20$@soterem.fr>
	<4EFAE1BF.4090203@domain.hid>
	<000301ccc556$168472e0$438d58a0$@soterem.fr>
	<4EFB0456.9010409@domain.hid>
	<000d01ccc55c$3cc52d40$b64f87c0$@soterem.fr>
	<4EFB0D66.8060306@domain.hid>
	<000801ccc580$d9117ef0$8b347cd0$@soterem.fr>
In-Reply-To: <000801ccc580$d9117ef0$8b347cd0$@soterem.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] problem following 'xenomai quick build guide'
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gregory Gosse <gregory.gosse@domain.hid>
Cc: Christophe@domain.hid, 'xenomai-help' <xenomai@xenomai.org>

On 12/28/2011 05:50 PM, Gregory Gosse wrote:
>> cd  /usr/src/xenomai-2.6.0/examples/native
> 
>> make

Examples are broken in 2.6.0, will be fixed in 2.6.1.

> And
> 
>> cd /usr/xenomai/bin
> 
>> apt-get install rt-tests

rt-tests are testing real-time capabilities of the linux kernel, not of
xenomai.

If you are interested in a test which measures latency, run the
"latency" test.

The intel paper you cited contains a list of the tests xenomai contains.

-- 
                                                                Gilles.

