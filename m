Message-ID: <4AE08F32.80800@domain.hid>
Date: Thu, 22 Oct 2009 18:58:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <0B45E93C5FF65740AEAE690BF3848B7AD3878D@rennsmail04.eu.thmulti.com>
	<4AE07632.7070404@domain.hid> <4AE086A0.1050703@domain.hid>
In-Reply-To: <4AE086A0.1050703@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai and Libpcap
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> As far as I remember, however, the timestamping of each packet is done
>> in the Linux domain, so, if you want to get the real timestamp, you have
>> to modify rtnet to get the timestamp done in the Xenomai domain.
> 
> No, time stamping is actually done in the RTnet driver (it is a
> by-product of RTmac/TDMA).

Ok, right, bad memory.

> 
>> Unfortunately, that is not all, because if you get Xenomai's timestamp,
>> they drift when compared to Linux timestamps. But if you look only at
>> relative timestamps over short period of times, that is Ok.
>>
> 
> Yes, timestamps will drift compared to a precise reference clock or even
> the Linux host clock. But I'm optimistic we can fix this in the neat future.

Ok. Now I remember why I touched this: in secondary domain, while
copying the packet for the rtcap driver, I read Xenomai's real-time
clock and Linux' real-time clock, and subtracted to Linux' timestamp the
difference between Xenomai's timestamp and the packet timestamp. This
compensates for the drift.

However, I far as I understood, Benjamin wants to get timestamps using
the NIC's clock. So, the solution would be a bit different.

-- 
                                          Gilles


