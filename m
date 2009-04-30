Message-ID: <49FA231F.1050108@domain.hid>
Date: Fri, 01 May 2009 00:15:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1FAD585D-B669-40CB-A779-0D1F496A3085@domain.hid>
In-Reply-To: <1FAD585D-B669-40CB-A779-0D1F496A3085@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] userspace applications and cache
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Steven Seeger <steven.seeger@domain.hid>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
> If a userspace application running xenomai threads is large (1MB or  
> so) then the code can't all live in cache on our puny 16kb instruction  
> cache. Does the cache handling occur as needed in the primary domain  
> or does it have to wait for Linux to handle it?

You should use the I-pipe tracer, it will tell you exactly what happens
on your system.

-- 
					    Gilles.

