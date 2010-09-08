Message-ID: <4C877A2A.10908@domain.hid>
Date: Wed, 08 Sep 2010 13:57:30 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTi=J9DJvEE274+rDiYBrqQSt7kNRZ3oW9+KPW7ra@domain.hid>
In-Reply-To: <AANLkTi=J9DJvEE274+rDiYBrqQSt7kNRZ3oW9+KPW7ra@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] question about priorities
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Charles Clerdan <charles.clerdan@domain.hid>
Cc: xenomai@xenomai.org

Charles Clerdan wrote:
> Hi,
> 
> 
> I have a technical question about priorities under Xenomai.
> 
> According to my research, Xenomai use priority levels from 0 to 99. 99 is
> the highest effective priority and 0 the lowest.
> But Linux uses levels from 0 to 139. For current task it uses levels 100 to
> 139 where 100 is highest priority than 139, and for "real time" threads 0 to
> 99 where 0 is highest than 99.s

No. 99 is the highest, 0 the lowest.

-- 
                                                                Gilles.

