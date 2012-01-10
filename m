Message-ID: <4F0C9C25.5080401@domain.hid>
Date: Tue, 10 Jan 2012 21:14:29 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F0B90C6.8040007@domain.hid>
In-Reply-To: <4F0B90C6.8040007@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Arm support for 3.2 kernel?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Mitchell Tasman <tasman@domain.hid>
Cc: xenomai@xenomai.org

On 01/10/2012 02:13 AM, Mitchell Tasman wrote:
> Hi.  I saw the recent discussion regarding ARM I-pipe and 3.x, and am 
> wondering if anyone can hazard a guess as to a timetable for 3.2 support?

3.0 is on its way. 3.1 will be next because it is the first version to
support a new I-pipe architecture, so I was hoping to be able to skip 3.2...

> 
> For OMAP3, I've wondered what's considered the optimal kernel strategy: 
> mainline, linux-omap, or an OMAPPSP branch of TI's linux-omap3 staging 
> tree on Arago.  My understanding based on previous discussions is that 
> for anything but mainline, a Xenomai user is on his or her own as far as 
> adapting an ARM I-pipe patchset to the selected kernel.

It is true that we can not ship I-pipe patches for all the vendor
specific branches around, so you have to adapt the patch to the vendor
branch you want to use. But it is usually not a big deal.

-- 
                                                                Gilles.

