Message-ID: <99b5d80b7648a20419ad62efa3865cc3.squirrel@sourcetrek.com>
In-Reply-To: <624126A3-294C-48BF-A099-2AA8E000FE11@gmail.com>
References: <7B9254AC-C035-4D61-884E-8C9B3706A22B@gmail.com>
 <5581BE6F.4030607@siemens.com>
 <624126A3-294C-48BF-A099-2AA8E000FE11@gmail.com>
Date: Fri, 19 Jun 2015 13:58:43 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] RTDM-native brushup
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <haberlerm@gmail.com>
Cc: Jan Kiska <jan.kiszka@siemens.com>, xenomai <xenomai@xenomai.org>


Michael Haberler wrote:
> Jan - thanks! I made minor progress. duh on the mknod..

Note that it is possible to get devices to be automatically created by
udev/devtmptfs, I did the exercise once. I think you need the device to be
instances of a "device class", or something like that.

Also note that with the advent of devtmpfs, the complexity of udev, the
slow down it causes to the boot procses, and its entanglement with
systemd, devtmpfs is probably a better choice on embedded systems now. If
you need a larger subset of udev functionality, you can also have a look
at busybox mdev.

-- 
                                            Gilles.
https://click-hack.org


