Date: Thu, 5 Feb 2015 15:03:10 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150205140310.GB32156@hermes.click-hack.org>
References: <54D350CA.90801@control.lth.se>
 <20150205115020.GA32156@hermes.click-hack.org>
 <54D37739.9020306@control.lth.se>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <54D37739.9020306@control.lth.se>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai-3/next: modprobe rtpacket fails with -EINVAL
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Anders Blomdell <anders.blomdell@control.lth.se>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On Thu, Feb 05, 2015 at 02:59:21PM +0100, Anders Blomdell wrote:
> On 2015-02-05 12:50, Gilles Chanteperdrix wrote:
> > I received a patch for this issue, I simply need to merge it. Thanks
> > for the reminder.
> 
> OK, ".device_count =     1," works for me now. 
> 
> BTW: is it the expected behaviour that when rtpacket is not loaded, socket()
> will default to __real_socket()?

Well, it depends on the parameters you pass to socket. I guess it
only happens if you want to create a raw packet socket.

-- 
					    Gilles.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 811 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150205/03d01172/attachment.sig>
