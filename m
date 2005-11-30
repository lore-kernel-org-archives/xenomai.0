Message-ID: <438DA0C8.10306@domain.hid>
Date: Wed, 30 Nov 2005 13:53:28 +0100
From: Kai Moritz <kai.m.moritz@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Problems with mutex
References: <438D993E.7010904@domain.hid> <438D9B20.5090609@domain.hid>
In-Reply-To: <438D9B20.5090609@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Reply-To: kai.m.moritz@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Jan Kiszka schrieb:
> 
> Does the same thread lock this mutex over and over again (I did not look
> at your code yet)? If so, note that mutexes can be acquired recursively
> by the original owner.
>
Oh, yes!
That's the solution. I read over that in the API.

Thanks for the quick answer :)

Kai

