Date: Wed, 18 May 2016 08:45:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160518064554.GG1722@hermes.click-hack.org>
References: <2396B4D2166B62479FBBE370D4A7C1F30A7395A9@mb2010-1.intra.tut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2396B4D2166B62479FBBE370D4A7C1F30A7395A9@mb2010-1.intra.tut.fi>
Subject: Re: [Xenomai] Send interrupt from RTDM kernel module to userspace
	app
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Umair Ali <ali.umair@tut.fi>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, May 17, 2016 at 01:51:59PM +0000, Umair Ali wrote:
> Hello, 
> 
> I need to send an interrupt from Rtdm kernel device to initiate the action in the userspace application. The interrupt will be send periodically by using kernel timers. Can someone give me the example how I can do send the interrupt from Rtdm module and read the interrupt in the userspace. I have read these articles
> http://stackoverflow.com/questions/33041199/sending-realtime-signal-from-a-kernel-module-to-user-space-fails
> Can anyone tell me how can I implement the above in rtdm modul. Give me example

Xenomai 3 does not support asynchronous signals. You can use
synchronous signals with sigwait, but that is uselessly complicated.
What you want is probably to have the thread blocked on read() or
ioctl() and wake it up when the event you are interested in happens,
this is how drivers usually work.

-- 
					    Gilles.
https://click-hack.org

