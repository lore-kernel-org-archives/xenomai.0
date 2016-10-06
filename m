From: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Date: Thu, 06 Oct 2016 19:24:15 +0200
Message-ID: <7810159.2OkF4KFj7y@fura>
In-Reply-To: <5ed168a2-fa54-0d21-a6ff-05abe1d95b11@siemens.com>
References: <2990549.hKSmcVRoDB@indiana> <2013828.8eEOvBkU4r@soho>
 <5ed168a2-fa54-0d21-a6ff-05abe1d95b11@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] About SMAP (was Re: Xenomai 3.0.3 is broken in my
	system)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

El Dijous, 6 d'octubre de 2016, a les 13:50:00, Jan Kiszka va escriure:
> On 2016-10-06 11:51, Leopold Palomo-Avellaneda wrote:
> > Hi,
> > 
> > lasts weeks I have been in a trouble with Xenomai and RTnet. Finally it
> > was
> > solved disabling some parameters in kernel (nosmap) Thanks again Jan.
> > 
> > That parameter is an interesting feature of the Intel processors [1,2],
> > that IMHO affects all the RTnet code and I hope that nothing more of
> > Xenomai.
> > 
> > It seems that fix it is could be easy, but it must be done (a boring task
> > ;-) In the middle, I would propose that some note could be added to the
> > FAQ, or "Troubleshooting a dual kernel configuration" page. Something
> > like this in the "Common kernel configuration issues":
> > 
> > CONFIG_X86_SMAP
> > 
> > On modern Intel processors with SMAP-enabled systems, kernel is not
> > allowed to access to userspace memory, it must be done in a special way.
> > So, until all Xenomai code was updated, specially RTnet, if you find
> > crashes with " unable to handle kernel paging request at " disable this
> > feature neither in kernel configuration or in boot with nosmap.
> 
> Send your proposal as patch for the included documentation or even the
> kernel Kconfig tests.

I think that I don't understand you. AFAIK xenomai documentation is in a 
Wordpress that Gilles installed and configured. I really don't know how to send 
a patch to that.

I'm just proposing that someone of the core team with write permissions to the 
wordpress make a cut and paste (if you think appropriate) of  that paragraph 
and add it to that part. That's all

Leopold
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part.
URL: <http://xenomai.org/pipermail/xenomai/attachments/20161006/71127e1e/attachment.sig>
