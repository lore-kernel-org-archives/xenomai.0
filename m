Message-ID: <4294F508.2000805@domain.hid>
Date: Wed, 25 May 2005 23:58:32 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4294E32B.6010203@domain.hid>
In-Reply-To: <4294E32B.6010203@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] Re: PATCH: Adeos ppc g5 support
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
To: Heikki Lindholm <holindho@domain.hid>
Cc: rtai@domain.hid, adeos-main@gna.org

Heikki Lindholm wrote:
> Hello,
> Current adeos ppc has (at least) two problems with Apple G5 hardware:
> * the PowerPC 970 decrementer does not work the same way as most ppc32 
> decrementers: it can't be turned off and it's level-sensitive
> * cascading interrupts aren't handled correctly
> Attached is patch against fusion 0.7.4 included adeos to fix these 
> problems (not the cleanest possible implementation, but the ppc32 kernel 
> for g5 isn't either)
> 

Applied, thanks. These fixes will be part of the next patch set.

-- 

Philippe.

