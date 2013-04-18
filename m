Message-ID: <5170432B.3030108@xenomai.org>
Date: Thu, 18 Apr 2013 21:02:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAG5EsAGn8oNQkH-OkEpS6NHjW7y1vZfp5HjV3+FTGi-eh667pg@mail.gmail.com>
	<00DF7AD9-868B-4AFC-B385-8C47F8522E4B@mah.priv.at>
	<516F1510.3030608@xenomai.org>
	<CAG5EsAHjpA0JTKHGVsq2Egbq+r3Hx=xV_U3bp+zWxHa0dUTrzg@mail.gmail.com>
	<516FA9E6.9010800@xenomai.org>
	<CAG5EsAEfX-sseaJE6u+1mhDk_MqmEr-m4Xx8sx2_c_redLNWkQ@mail.gmail.com>
In-Reply-To: <CAG5EsAEfX-sseaJE6u+1mhDk_MqmEr-m4Xx8sx2_c_redLNWkQ@mail.gmail.com>
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
Cc: xenomai <xenomai@xenomai.org>

On 04/18/2013 06:38 PM, Ross Williamson wrote:

> Is this a bad idea from a RTlinux point of view or a style point of view?


It is a bad idea from a very general point of view. gpiolib does two things:
- it ensures that no two drivers try and request the same gpio
- if toggling a gpio state implies a read-modify-write operation, it
protects it with a spinlock, so that no two drivers can interrupt each
other and cause issues in the operation.

By accessing the registers directly, you do not get these protections.

-- 
                                                                Gilles.

