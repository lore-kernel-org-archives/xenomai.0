From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 10 Jun 2015 10:24:59 -0400
Message-ID: <20150610142459.GC17436@csclub.uwaterloo.ca>
References: <DUB121-W42B693A503D6EC1D2F144381BF0@phx.gbl>
 <201506081211.15597.paul_c@tuxcnc.org>
 <DUB121-W1EC856DF0BB8FC70B291281BF0@phx.gbl>
 <201506090119.30719.paul_c@tuxcnc.org>
 <DUB403-EAS557D5FDB6E75C92D3DC47981BE0@phx.gbl>
 <20150609164046.GA12517@hermes.click-hack.org>
 <20150609174138.GA17436@csclub.uwaterloo.ca>
 <DUB121-W2271AF72F050D09F1D570681BD0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DUB121-W2271AF72F050D09F1D570681BD0@phx.gbl>
Subject: Re: [Xenomai] Raspberry Pi 2 patch - BCM2709
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: mobin Motallebizadeh <mobin.seven@live.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Jun 10, 2015 at 03:24:51AM +0000, mobin Motallebizadeh wrote:
> I've made some patches [see attachments]. I've just modified  ipipe patch for 3.18.12 and raspberry related patches to match RPi repo [https://github.com/raspberrypi/linux] which is 3.18.14 .
> the resulting kernel img boots without IPIPE and XENOMAI configs successfully(of course!) but with IPIPE doesn't boot.(so I haven't netconsole working)
> any suggestion to make it work will be appreciated. 		 	   		  
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: ipipe-core-3.18.14-arm.patch
> Type: application/octet-stream
> Size: 728647 bytes
> Desc: not available
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20150610/45d8899d/attachment.obj>
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: ipipe-core-3.18.14-raspberry-post.patch
> Type: application/octet-stream
> Size: 6556 bytes
> Desc: not available
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20150610/45d8899d/attachment-0001.obj>
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: ipipe-core-3.18.14-raspberry-pre.patch
> Type: application/octet-stream
> Size: 552 bytes
> Desc: not available
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20150610/45d8899d/attachment-0002.obj>

Do you have earlyprintk enabled?  I find it is often helpful for crashes
early in boot to get an idea where to look.  This assuming you have
a serial console (and if you don't, I would try to get one, they are
really helpful early on).

-- 
Len Sorensen

