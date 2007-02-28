Subject: Re: [Xenomai-core] supervisor/user stack size for pSOS tasks
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <OFE710E4B4.0565BE65-ONC1257290.0056321A@uk.marconicomms.com>
References: <OFE710E4B4.0565BE65-ONC1257290.0056321A@uk.marconicomms.com>
Content-Type: text/plain
Date: Wed, 28 Feb 2007 18:27:55 +0100
Message-Id: <1172683676.2259.13.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Markus Osterried <Markus.Osterried@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2007-02-28 at 17:11 +0100, Markus Osterried wrote:
> Hello Philippe,
> 
> when using t_create() for creating a pSOS task in user space, the parameter
> sstack is ignored.
> But when creating the task in kernel space, sstack is added to ustack to
> create a stack of the combined sizes.
> The same behaviour as in kernel space should be implemented in user space.
> Because this is the behaviour of original pSOS for CPU architectures where
> supervisor and user stacks are not separated, like PowerPC.
> 

Fixed, thanks.

> Thanks
> Markus
> 
> 
> 
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



