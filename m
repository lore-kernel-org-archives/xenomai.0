Subject: Re: [Adeos-main] 2.6.5 + vesuvio + gcc-3.4.0 = success
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <Pine.LNX.4.53.0405021911080.23891@domain.hid>
References: <Pine.LNX.4.53.0405021911080.23891@domain.hid>
Content-Type: text/plain
Message-Id: <1083517623.683.73.camel@domain.hid>
Mime-Version: 1.0
Date: Sun, 02 May 2004 19:07:04 +0200
Content-Transfer-Encoding: 7bit
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: "Rus V. Brushkoff" <rus@domain.hid>
Cc: adeos-main@gna.org

On Sun, 2004-05-02 at 18:17, Rus V. Brushkoff wrote:
> 	Hi.
> 
>  This little patch against hal5c2-2.6.5.patch needed to compile all the above.

Applied and committed, thanks. Even works with 2.95.3, good. :o)

> The rtai_up examples works ok, but lxrt scheduler failed (box freezed
> solid while starting XFree 4.4.0 and running lxrt latency test).

As far as I can remember, starting the X server while a RT app is
running always crashed the box. There must be something in the card
support messing with the interrupt machinery well beyond the real-time
layer can bear...

However, we made good progress on vesuvio last week, and now the full
stack works in UP+SMP, including with the preemptible kernel support
enabled.

> Congratulations - it worked ! ;)
> 

Thanks, but it was not deliberate! Nah, just kidding... :o)

> 
> 		Rus
-- 

Philippe.


