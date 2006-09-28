Subject: Re: [Adeos-main] [PATCH+HACK] optimise root stalling
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <451BA49D.2030303@domain.hid>
References: <451786B3.4020506@domain.hid> <1159434450.4949.7.camel@domain.hid>
	<451B92C8.9050802@domain.hid> <1159434997.4949.9.camel@domain.hid>
	<451B949B.4090602@domain.hid> <1159438034.4949.25.camel@domain.hid>
	<451BA49D.2030303@domain.hid>
Content-Type: text/plain
Date: Thu, 28 Sep 2006 12:46:51 +0200
Message-Id: <1159440412.4949.33.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main@gna.org

On Thu, 2006-09-28 at 12:31 +0200, Jan Kiszka wrote:
> Does it still make sense then to optimise like I proposed?
> 

If you did measure a 5% improvement on low-end x86 hw, then I guess so.
Moving __ipipe_unstall_root to the arch-dependent section would do, so
that we could use the most efficient implementation on a case by case
basis.

-- 
Philippe.



