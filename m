Message-ID: <516E336C.1060509@xenomai.org>
Date: Wed, 17 Apr 2013 07:30:20 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAD1EtognG+9J_Bbo3x6AsBCJ4eU4SLrXQz=wDvJtFw0vCSZ8NQ@mail.gmail.com>	<516BA7C4.1050403@grandegger.com>
	<CADVgf9nD4Qkaz54ba1PuKx0h1WkSkhPYQM9C0RU2LkE7aE96nQ@mail.gmail.com>
In-Reply-To: <CADVgf9nD4Qkaz54ba1PuKx0h1WkSkhPYQM9C0RU2LkE7aE96nQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] patch to src/utils/can/rtcansend.c to support data
 from a file
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthew Fornero <mfornero.lists@gmail.com>
Cc: "Daniel M. Drucker, Ph.D." <dmd@interactive-motion.com>, xenomai@xenomai.org

On 04/17/2013 05:04 AM, Matthew Fornero wrote:

> FWIW, we would find this extension to be pretty useful for testing. We
> often do regulatory compliance testing (FCC, CE, etc) well ahead of having
> a full software stack working, so use simple shell scripts to
> generate/check traffic on all of our interfaces.
> 
> Being able to script data without delays would allow us to generate more
> representative traffic during these tests. Of course we could accomplish
> the same with a small test program in C, but shell scripts seem to be more
> accessible for getting something up and running "quick and dirty".


Maybe you could make it a separate test?

-- 
                                                                Gilles.

