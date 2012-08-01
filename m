Message-ID: <50197439.70808@xenomai.org>
Date: Wed, 01 Aug 2012 20:23:53 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201208010957.20988.leo@alaxarxa.net>
In-Reply-To: <201208010957.20988.leo@alaxarxa.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] libusb devices with a xenomai kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: Xenomai@xenomai.org

On 08/01/2012 09:57 AM, Leopold Palomo-Avellaneda wrote:

> Hi,
> 
> we have a box that is running Xenomai 2.6.1 in a amd4 cpu. We have a usb 
> camera with a program that reads an image as fast it cans. It's executed as a 
> normal Linux task. 
> 
> We have also some tasks that use libxenomai within a realtime context. We have 
> realized that the usb device has some kind of strange behavior and it's 
> disconnected or simple sometimes spend too much time to acquire a image.


Well, it may sound stupid, but when you run a xenomai task, it has to
run from time to time, so, have you check that it is not simply the
real-time task interrupting the usb camera acquisition?

> 
> The question is, someone of you have experienced similar problems? or have we 
> have to implement any special protection when we want to use a usb device 
> (with libusb) using a Xenomai kernel? 
> 
> We don't pretend to have a realtime usb, just a "similar" use that if we use 
> the same code in a normal Linux kernel.


Well, when you run xenomai, there are two kernels running, one of them
being a real-time kernel that is in no way designed to share the
processor fairly with Linux.

If this is not your problem, Xenomai also provides the I-pipe tracer,
which will allow you to trace what happens when the camera takes to long
to acquire an image: simply programmatically trigger a trace freeze when
this happens and go read the trace to understand what just happened.

-- 
                                                                Gilles.

