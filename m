Message-ID: <OFE710E4B4.0565BE65-ONC1257290.0056321A@uk.marconicomms.com>
From: "Markus Osterried" <Markus.Osterried@domain.hid>
Date: Wed, 28 Feb 2007 17:11:35 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Subject: [Xenomai-core] supervisor/user stack size for pSOS tasks
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hello Philippe,

when using t_create() for creating a pSOS task in user space, the parameter
sstack is ignored.
But when creating the task in kernel space, sstack is added to ustack to
create a stack of the combined sizes.
The same behaviour as in kernel space should be implemented in user space.
Because this is the behaviour of original pSOS for CPU architectures where
supervisor and user stacks are not separated, like PowerPC.

Thanks
Markus




