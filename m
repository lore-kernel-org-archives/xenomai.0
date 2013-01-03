Message-ID: <50E608CF.3020606@xenomai.org>
Date: Thu, 03 Jan 2013 23:40:15 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAD1EtoiVOD7KdOD7ZyqtxQ3AttD=Ca0bbsOsKOiMQtyNxm47EA@mail.gmail.com>	<50E60647.5090309@xenomai.org>
	<CAD1EtoiFivw1qesTzEUF9Scb-uMwMaJpnw18cJJ79DJQ3tejLw@mail.gmail.com>
In-Reply-To: <CAD1EtoiFivw1qesTzEUF9Scb-uMwMaJpnw18cJJ79DJQ3tejLw@mail.gmail.com>
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

On 01/03/2013 11:38 PM, Daniel M. Drucker, Ph.D. wrote:

> 
>     Strange. The debian packages I use, temporarily available here:
>     http://xenomai.org/~gch/pub/deb/
> 
>     Get /dev/rtheap created. It is created by an udev AFAIK.
> 
> 
> I can't use yours, as I'm not amd. 
> These are the .debs that debuild made for me: http://3e.org/private/x/
> 
> Can you see if something went wrong?

Well the udev rules is installed by the libxenomai1 package which you do
not have. Have you followed the instructions here?

http://www.xenomai.org/index.php/Building_Debian_packages

-- 
                                                                Gilles.

