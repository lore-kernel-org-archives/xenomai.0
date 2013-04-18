Message-ID: <516FA9E6.9010800@xenomai.org>
Date: Thu, 18 Apr 2013 10:08:06 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAG5EsAGn8oNQkH-OkEpS6NHjW7y1vZfp5HjV3+FTGi-eh667pg@mail.gmail.com>
	<00DF7AD9-868B-4AFC-B385-8C47F8522E4B@mah.priv.at>
	<516F1510.3030608@xenomai.org>
	<CAG5EsAHjpA0JTKHGVsq2Egbq+r3Hx=xV_U3bp+zWxHa0dUTrzg@mail.gmail.com>
In-Reply-To: <CAG5EsAHjpA0JTKHGVsq2Egbq+r3Hx=xV_U3bp+zWxHa0dUTrzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rtdm and rasberry-pi GPIO
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ross Williamson <rwilliamson@astro.caltech.edu>
Cc: xenomai@xenomai.org

On 04/18/2013 01:12 AM, Ross Williamson wrote:

> So I managed to get it working in kernel space - I'm not entirely sure what
> I did to fix it - I did a full read/modify/write on the GPIO registers


That is not a good idea either. You should use the gpiolib interface.


-- 
                                                                Gilles.

