Message-ID: <48EB4BD8.10207@domain.hid>
Date: Tue, 07 Oct 2008 13:45:28 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <b054e88e0809290735x19e1618eh6facc56ee6baef18@domain.hid>		<48E3541E.8090808@domain.hid>		<b054e88e0810030957l3e25a1beo8866a3e8f79d9e9b@domain.hid>		<48E66224.7060709@domain.hid>		<b054e88e0810031129o1638c19cr1a1d096da5169aee@domain.hid>		<b054e88e0810060529u7c5189qd2853385e7ac64ce@domain.hid>		<48EA1127.6030405@domain.hid>	<b054e88e0810060628r7d4f18bnb78b33c6dda0048b@domain.hid>
	<48EB4B64.4020209@domain.hid>
In-Reply-To: <48EB4B64.4020209@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Error while building Xenomai on Powerpc with
 instrument function entries enabled
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Giammarco Zacheo <g.zacheo@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Philippe Gerum wrote:
> Giammarco Zacheo wrote:
>> Thank you. There's no hurry actually, just reporting the bug.
>>
>> If there's something I can do to help...
>>
> 
> I have no efika board at hand, but just booted a plain lite5200 IceCube
> successfully, with all tracing options enabled. This is a DENX-originated kernel
> (tagged "DENX-v2.6.26-stable") from the usual place.
> 
> Looking again to the trace output you got, I wonder now if the device tree file
> you are using is ok. Could you confirm that your board boots with the I-pipe
> support fully disabled?
> 

And if so, does it still boot with the I-pipe support enabled and the I-pipe
latency tracing option disabled?

-- 
Philippe.

