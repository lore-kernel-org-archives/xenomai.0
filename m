Message-ID: <445E6267.6020407@domain.hid>
Date: Sun, 07 May 2006 17:11:03 -0400
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] help on alarms..
References: <445C2D1700022E97@domain.hid> (added
	by	postmaster@domain.hid)
In-Reply-To: <445C2D1700022E97@domain.hid> (added
	by	postmaster@domain.hid)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Prashanti Bedapudi <pbedapudi@domain.hid>
Cc: xenomai@xenomai.org

Prashanti Bedapudi wrote:
> Attached is a piece of code using alarms, but I am seeing some unexpected
> behavior.  Any help will be appreciated.
>
>   
have a look at src/testsuite/latency
it does what I believe youre seeking to do (tho I havent read your code)


> in function main() the program behaves two different ways depending on where
> I have the last printf()
>
> 1. It works fine and terminates as expected if I have it like this
> 	while(!quit_now)
> 	   printf("quit_now = %d\n", quit_now);
>
> 2. It does not terminate if I have it this way. I know quit_now is set to 1,
> since the last statement printed is 'quit_now is set to 1'.
>
> 	while(!quit_now);
> 	printf("quit_now = %d\n", quit_now);
>
> thanks,
> Shanti
>
>   


