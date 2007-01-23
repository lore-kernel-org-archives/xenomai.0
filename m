Message-ID: <b647ffbd0701231345n33a7ecafm879ca25bdedab2fe@domain.hid>
Date: Tue, 23 Jan 2007 22:45:38 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] isolating unwanted mode switch
In-Reply-To: <200701231448.35285.jweber@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200701231448.35285.jweber@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Weber <jweber@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Hi,

>
> Are there other events (not system calls) that initiate a switch to secondary mode?

exceptions (CPU exceptions, e.g. page faults). I presume, you have
done mlockall(CURRENT | FUTURE), haven't you?

As a starting point, take a look at what /proc/xenomai/faults provides.

Moreover, enable "Nucleus debugging support" in your kernel config. If
it's an exception indeed, you would see a message like :

"Switching %s to secondary mode after exception #%u from "
                             "user-space at 0x%lx (pid %d)\n"

with proper parameters, of course.


-- 
Best regards,
Dmitry Adamushko

