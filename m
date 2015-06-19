Message-ID: <55840603.4090600@siemens.com>
Date: Fri, 19 Jun 2015 14:07:31 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <7B9254AC-C035-4D61-884E-8C9B3706A22B@gmail.com>
 <5581BE6F.4030607@siemens.com>
 <624126A3-294C-48BF-A099-2AA8E000FE11@gmail.com>
 <99b5d80b7648a20419ad62efa3865cc3.squirrel@sourcetrek.com>
In-Reply-To: <99b5d80b7648a20419ad62efa3865cc3.squirrel@sourcetrek.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTDM-native brushup
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Michael Haberler <haberlerm@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On 2015-06-19 13:58, Gilles Chanteperdrix wrote:
> 
> Michael Haberler wrote:
>> Jan - thanks! I made minor progress. duh on the mknod..
> 
> Note that it is possible to get devices to be automatically created by
> udev/devtmptfs, I did the exercise once. I think you need the device to be
> instances of a "device class", or something like that.

Exactly, kernel/cobalt/pipe.c contains that pattern, to name just one
example. mknod is only a quick workaround.

> 
> Also note that with the advent of devtmpfs, the complexity of udev, the
> slow down it causes to the boot procses, and its entanglement with
> systemd, devtmpfs is probably a better choice on embedded systems now. If
> you need a larger subset of udev functionality, you can also have a look
> at busybox mdev.
> 

That should be an independent optimization path.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

