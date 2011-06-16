Message-ID: <4DFA4961.1030805@domain.hid>
Date: Thu, 16 Jun 2011 20:20:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <006001cc2c41$18e6ff70$4ab4fe50$@de>
In-Reply-To: <006001cc2c41$18e6ff70$4ab4fe50$@de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] CameraLink
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Franz Engel <franz_lambert_engel@domain.hid>
Cc: xenomai@xenomai.org

On 06/16/2011 06:18 PM, Franz Engel wrote:
> Hello,
> 
>  
> 
> I have to integrate a laser sensor with a cameraLink. Has somebody
> experience with that? I have no idea where I've to start to make the driver
> realtime. Or is it not needful to do that?

Hi,

If you want to write a real-time driver, you should use the RTDM skin
and read:
http://www.xenomai.org/documentation/branches/v2.3.x/pdf/RTDM-and-Applications.pdf

The skin itself is documented here:
http://www.xenomai.org/documentation/xenomai-2.5/html/api/group__rtdm.html

As to whether this is really needed, only you can tell.


-- 
                                                                Gilles.

