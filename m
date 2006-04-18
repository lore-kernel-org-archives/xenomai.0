Message-ID: <4445413B.9070004@domain.hid>
Date: Tue, 18 Apr 2006 21:42:51 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <444530EA.4020005@domain.hid>
In-Reply-To: <444530EA.4020005@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] Re: ipipe-2.6.15-i386-1.2-04 is lacking notrace
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

Jan Kiszka wrote:
> Hi Philippe,
> 
> your generation script for the 2.6.15 patch seems to lack the
> include/linux/compiler.h patch for notrace - doesn't build with the
> tracer switched on.
> 

I've overwritten -04 a few hours ago with the proper fix.

-- 

Philippe.

