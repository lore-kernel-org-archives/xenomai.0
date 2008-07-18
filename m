Message-ID: <488092CE.903@domain.hid>
Date: Fri, 18 Jul 2008 14:55:42 +0200
From: Sebastian Smolorz <smolorz@domain.hid>
MIME-Version: 1.0
References: <825218.87114.qm@domain.hid>
In-Reply-To: <825218.87114.qm@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] milisecond delay
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: menege1@domain.hid
Cc: xenomai@xenomai.org

egemen kaleli wrote:
> I need a function that provides milisecond-resolution delay in rt task.do you know any?

Please see the Xenomai API at:
http://www.xenomai.org/documentation/branches/v2.4.x/html/api/index.html
and the description of your favourite Xenomai skin. Normally, you even 
have a nanosecond resolution.

> At least a function that works in gcc.

What do you mean with "works in gcc"? Xenomai and its applications are
compiled with gcc so where is the problem?

-- 
Sebastian

