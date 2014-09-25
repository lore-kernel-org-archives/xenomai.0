Message-ID: <54244037.8060507@xenomai.org>
Date: Thu, 25 Sep 2014 18:17:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <54243D1E.9090904@axelsw.it>
In-Reply-To: <54243D1E.9090904@axelsw.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Problems triggering a nested interrupt to a user
 space process
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marco Tessore <marco.tessore@axelsw.it>, xenomai@xenomai.org

On 09/25/2014 06:04 PM, Marco Tessore wrote:
> Good morning,
> I'd like to manage, from user-space, the reaction to interrupts on GPIO
> pins, on a board based on processor Freescale iMX28.
> I have Linux 3.11 and Xenomai 2.6.3.

We did not make an I-pipe patch for Linux 3.11. Are you able to
reproduce the issue with an I-pipe patch we delivered?

-- 
                                                                Gilles.

