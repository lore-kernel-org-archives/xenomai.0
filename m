From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <470E1FD6.2030607@domain.hid>
References: <470E1FD6.2030607@domain.hid>
Content-Type: text/plain
Date: Thu, 11 Oct 2007 16:47:59 +0200
Message-Id: <1192114079.6220.13.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Adeos-main] [PATCH 1/4] tracer: cleanup critical paths
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

On Thu, 2007-10-11 at 15:06 +0200, Jan Kiszka wrote:
> for_each_online_cpu is not free of function calls on SMP, thus causes
> false NMI noise in the tracer log (due to tracer recursions). Switch to
> some plain loop instead.

Series merged, thanks.

-- 
Philippe.



