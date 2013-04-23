Message-ID: <51766F9F.6070407@xenomai.org>
Date: Tue, 23 Apr 2013 13:25:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <517536B8.4080508@gmail.com>
In-Reply-To: <517536B8.4080508@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] How to use rtdm_(io/m)map_to_user
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Victor Hiairrassary <victor.hiairrassary.ml@gmail.com>
Cc: xenomai@xenomai.org

On 04/22/2013 03:10 PM, Victor Hiairrassary wrote:

> Hello all,
> 
> This is my first post on this mailing list. I am really new with 
> xenomai, only
> few month ago.
> 
> Currently we have a real-time application using xenomai which interacts with
> hardware directly by mmaping /dev/mem.


This is wrong. The "abstraction layer" used by an application should be
the usual driver interface open/read/write/ioctl and mmap if there are
high volumes of data to exchange with the application. Access to the
registers should be confined to the driver implementation.

This way, in order to simulate the real hardware you only have to
implement another driver with the same interface (but with an
implementation not using registers). And when you decide to use another
hardware with a completely different registers interface, you do not
have to emulate the first device registers using the second one, you
simply implement another driver with the same interface.

This is the way, the interface between Linux drivers and applications is
done, and the way it can be done with Xenomai RTDM skin.


-- 
                                                                Gilles.

