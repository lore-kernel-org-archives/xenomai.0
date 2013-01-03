Message-ID: <50E60B67.7060401@xenomai.org>
Date: Thu, 03 Jan 2013 23:51:19 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAD1EtoiVOD7KdOD7ZyqtxQ3AttD=Ca0bbsOsKOiMQtyNxm47EA@mail.gmail.com>	<50E60647.5090309@xenomai.org>	<CAD1EtoiFivw1qesTzEUF9Scb-uMwMaJpnw18cJJ79DJQ3tejLw@mail.gmail.com>	<50E608CF.3020606@xenomai.org>	<CAD1EtoiHmA1YnRcoc-vHLT6BO1A61VuP9Ey+WWnoZS_7aOmYmQ@mail.gmail.com>	<50E60994.8010903@xenomai.org>	<CAD1Etohn+D9+8XebcRFj09hb=tbu_PgC_Tsx0bxLwMJ8w1xAzA@mail.gmail.com>	<50E60A3B.7040501@xenomai.org>
	<CAD1EtojxM6PajHda1V4DZ0OqUMd-EtutiPmgtkYPnwKWG5Z30g@mail.gmail.com>
In-Reply-To: <CAD1EtojxM6PajHda1V4DZ0OqUMd-EtutiPmgtkYPnwKWG5Z30g@mail.gmail.com>
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

On 01/03/2013 11:50 PM, Daniel M. Drucker, Ph.D. wrote:

> 
>     Are you sure Xenomai is started correctly?
> 
> 
> In the previous version (which we had working) we didn't have to do
> anything to start it - it just started on boot.
> 
> I have CONFIG_XENOMAI=y in my linux kernel config.
> 
> Is there something else I have to do? /etc/init.d/xenomai start doesn't
> appear to do anything.


You have to check if Xenomai is started correctly, see the
TROUBLESHOOTING guide.

-- 
                                                                Gilles.

