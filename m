From: Paul <paul_c@tuxcnc.org>
Date: Thu, 4 Jul 2013 12:14:38 +0100
References: <201302141227.05428.paul_c@tuxcnc.org>
	<51229E79.7030607@xenomai.org>
	<loom.20130702T010738-643@post.gmane.org>
In-Reply-To: <loom.20130702T010738-643@post.gmane.org>
MIME-Version: 1.0
Message-Id: <201307041214.38727.paul_c@tuxcnc.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai, Raspberry Pi, 3.5.7 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On Tuesday 02 July 2013, John Pham wrote:
> I've run into problems compiling the kernel with the above patch from
> git when sound drivers are enabled. It looks like some DMA code from
> commit
> https://github.com/torvalds/linux/commit/64ccc9c033c6089b2d426dad3c56
>477ab066c999 was missing. I've added them in the patch inlined below
> (to be applied after Paul's patch).
>
> Thanks for the work with getting Xenomai on the Pi! :)

Sound has never been a high priority for me, so I don't generally enable 
the drivers - Hence the reason I missed this... That said, got a "real 
time" voice recognition project surfacing at work.

Could you try the two attached patches - These are intended for 
the "official" Rasperry Pi kernel from 
https://github.com/raspberrypi/linux (rpi-3.8.y branch). Apply the 
*-pre.patch, followed by the ipipe-core.patch, and finish with the 
*-post.patch - Any failed hunks or other issues, let me know and I'll 
take a look when time allows.


Regards, Paul.





-------------- next part --------------
A non-text attachment was scrubbed...
Name: ipipe-core-3.8.13-RPi-pre.patch
Type: text/x-diff
Size: 5292 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130704/85668b14/attachment.patch>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ipipe-core-3.8.13-RPi-post.patch
Type: text/x-diff
Size: 12108 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130704/85668b14/attachment-0001.patch>
