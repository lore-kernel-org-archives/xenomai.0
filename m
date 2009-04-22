Message-ID: <49EF70E3.7090105@domain.hid>
Date: Wed, 22 Apr 2009 21:32:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <49EF6591.7000802@domain.hid>
	<468CF57C-40DE-498B-9C2C-C73AE07CFE4F@comcast.net>
In-Reply-To: <468CF57C-40DE-498B-9C2C-C73AE07CFE4F@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] An answer to Steven's questions.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <steven.seeger@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Steven Seeger wrote:
> The problem is that latency on Xenomai (even with kernel based  
> threads) is terrible on our board compared to RTAI and it's causing us  
> issues. I'm starting to think that Xenomai on Geode is not appropriate  
> for our application, but we have to salvage the work that's already  
> been done. At this point I'm simply looking to minimize the problem.
> 
> We are seeing jitters of upwards of 70us when we have a 125us and a  
> 500us task. That's a huge amount and we can't deal with it. Hopefully  
> the problem will be something else. It would be nice to have my other  
> questions answered, though.

To give you some figures, the Geode you sent me has a latency around
40us under full load.

-- 
					    Gilles.

