Message-ID: <50E60F86.8070009@xenomai.org>
Date: Fri, 04 Jan 2013 00:08:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAD1EtoiVOD7KdOD7ZyqtxQ3AttD=Ca0bbsOsKOiMQtyNxm47EA@mail.gmail.com>	<50E60647.5090309@xenomai.org>	<CAD1EtoiFivw1qesTzEUF9Scb-uMwMaJpnw18cJJ79DJQ3tejLw@mail.gmail.com>	<50E608CF.3020606@xenomai.org>	<CAD1EtoiHmA1YnRcoc-vHLT6BO1A61VuP9Ey+WWnoZS_7aOmYmQ@mail.gmail.com>	<50E60994.8010903@xenomai.org>	<CAD1Etohn+D9+8XebcRFj09hb=tbu_PgC_Tsx0bxLwMJ8w1xAzA@mail.gmail.com>	<50E60A3B.7040501@xenomai.org>	<CAD1EtojxM6PajHda1V4DZ0OqUMd-EtutiPmgtkYPnwKWG5Z30g@mail.gmail.com>	<50E60B67.7060401@xenomai.org>	<CAD1Etoi=F2Ds7hUCKZD7M2j2CT3FKo_5vkqY2O3mLwjBVHYG=A@mail.gmail.com>	<CAD1Etojxz1tt9wDxjO7ghQE95p8vbuT9r0b3DeuqmwEZRyLnxw@mail.gmail.com>	<50E60E32.4060704@xenomai.org>	<50E60EE9.9060909@xenomai.org>
	<CAD1Etohx2MUrmZsGacCD11eaH97e-tPRhaw4L7xQqTDrXuPAig@mail.gmail.com>
In-Reply-To: <CAD1Etohx2MUrmZsGacCD11eaH97e-tPRhaw4L7xQqTDrXuPAig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] make devices not run from deb
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Daniel M. Drucker, Ph.D." <dmd@interactive-motion.com>
Cc: xenomai@xenomai.org

On 01/04/2013 12:07 AM, Daniel M. Drucker, Ph.D. wrote:

> 
>     Or try /var/log/syslog or /var/log/messages
> 
> 
> Same - it doesn't look like xenomai is getting loaded at all. There are
> no references to 'xeno' other than in the uname.


Then your problem is solved, you found out why /dev/rtheap is not created.

-- 
                                                                Gilles.

