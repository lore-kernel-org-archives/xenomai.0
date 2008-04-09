MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18428.56663.660915.361180@domain.hid>
Date: Wed, 9 Apr 2008 17:14:31 +0200
In-Reply-To: <d3f72a390803270133j5447d15ax5110010ddd803933@domain.hid>
References: <d3f72a390803270133j5447d15ax5110010ddd803933@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] CATCH EXCEPTION
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: axel axel <softaxel@domain.hid>
Cc: xenomai@xenomai.org

axel axel wrote:
 > Hi,
 > 
 > i want to catch an exception in realtime tasks ( for example a null pointer
 > ).
 > 
 > i saw that in xenomai there is a function rthal_trap_catch.
 > But i don't know how works.

Well, Xenomai handles exceptions itself, and it is not currently
user-configurable. In a kernel module launched after xenomai nucleus
module, you will have to call rthal_trap_catch, passing a pointer to a
function of yours, which falls back to xenomai exception handler
when the exception is not of interest to your application.

-- 


					    Gilles.

